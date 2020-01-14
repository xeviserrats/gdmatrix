package com.audifilm.matrix.cases.service;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map.Entry;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.persistence.EntityManager;
import org.matrix.cases.CaseFilter;
import org.matrix.dic.Property;
import org.santfeliu.jpa.JPAQuery;

/**
 *
 * @author blanquepa
 */
public class FindCasesQueryBuilder
{
  protected static final Logger log = Logger.getLogger(FindCasesQueryBuilder.class.getName());


  private HashMap<String, Object> parameters = new HashMap<String, Object>();
  private List<String> userRoles;
  private boolean counterQuery;
  private boolean caseAdmin;
  private CaseFilter caseFilter;

  final static private String FIND_CASES_WHERE =
      " WHERE " +
      "  (locate(concat(',', concat(trim(e.caseId), ',')), :caseId) > 0 or :caseId is null) " +
      "  AND (((:registryFromDate <= e.registryDate or :registryFromDate IS NULL) " +
      "    and (:registryToDate >= e.registryDate or :registryToDate IS NULL) " +
      "    and :registryDateComparator = '1') or :registryDateComparator = '0') " +
      "  AND trim(ap.aplId) = 'SDE' " +
      "  AND trim(ap.docorigen) = 'EXPED' " +
      "  AND trim(ap.docId) = trim(e.caseTypeId) ";

  private StringBuilder select = new StringBuilder("SELECT ");
  private StringBuilder from = new StringBuilder(" FROM Case e, AplDocument ap ");
  private StringBuilder where = new StringBuilder(FIND_CASES_WHERE);
  private StringBuilder orderBy = new StringBuilder(" ORDER BY e.caseId ");


  public FindCasesQueryBuilder(CaseFilter caseFilter)
  {
    this.caseFilter = caseFilter;
  }


  public List<Property> getPropertiesFilter()
  {
    return caseFilter.getProperty();
  }


  
  public boolean isCounterQuery()
  {
    return counterQuery;
  }

  public void setCounterQuery(boolean counterQuery)
  {
    this.counterQuery = counterQuery;
  }

  public boolean isCaseAdmin()
  {
    return caseAdmin;
  }

  public void setCaseAdmin(boolean caseAdmin)
  {
    this.caseAdmin = caseAdmin;
  }

  public List<String> getUserRoles()
  {
    return userRoles;
  }

  public void setUserRoles(List<String> userRoles)
  {
    this.userRoles = userRoles;
  }

  public String getFilterTypeId()
  {
    return caseFilter.getCaseTypeId();
  }

  public CaseFilter getCaseFilter()
  {
    return caseFilter;
  }
  
  public JPAQuery getFilterCasesQuery(EntityManager em) throws Exception
  {
    StringBuilder buffer = new StringBuilder();

    appendSelect();
    appendWhereTitle();
    appendWhereDescription();
    appendWhereTypeIds();
    appendWhereClassId();
    appendWhereProperties();
    appendAditionalSearchExpression();

    buffer.append(select);
    buffer.append(from);
    buffer.append(where);
    if (!isCounterQuery()) buffer.append(orderBy);

    System.out.println("FilterCasesQuery: SQL " + buffer);
    System.out.println("FilterCasesQuery: SQL " + parameters.toString());

    JPAQuery query = new JPAQuery(em.createQuery(buffer.toString()));
    try
    {
      setCaseFilterParameters(query);
    }
    catch (Exception ex)
    {
      Logger.getLogger(CaseManager.class.getName()).log(Level.SEVERE, null, ex);
    }

    return query;
  }

  private void appendSelect()
  {
    if (counterQuery)
    {
      select.append(" count(e) ");
    }
    else
    {
      select.append(" e, ap.classId ");
    }
  }

  private void appendWhereTypeIds()
  {
    String filterTypeId = caseFilter.getCaseTypeId();
    if (filterTypeId!=null && filterTypeId.equals("SDE")) {
      filterTypeId = null;
    }

    if (isCaseAdmin()) {
      if (filterTypeId!=null) {
        where.append("  AND (trim(e.caseTypeId) = :caseTypeId OR :caseTypeId IS NULL)");
        parameters.put("caseTypeId", filterTypeId);
      }
    } else {
      Set<String> typeIds = getTypeIds();
      int i = 0;
      if (filterTypeId != null && filterTypeId.trim().length() > 0)
      {
        if (typeIds != null && typeIds.contains(filterTypeId))
        {
          where.append(" AND trim(e.caseTypeId) = :caseTypeId" + i);
          parameters.put("caseTypeId" + i, filterTypeId);
        }
        else
        {
          where.append(" AND 1=0");
        }
      }
      else
      {
        if (typeIds != null && typeIds.size() > 0)
        {
          where.append(" AND (");

          Iterator it = typeIds.iterator();
          while (it.hasNext())
          {
            if (i != 0) where.append(" OR ");

            where.append(" trim(e.caseTypeId) = :caseTypeId" + i);
            parameters.put("caseTypeId" + i, (String)it.next());
            i++;
          }
          where.append(")");
        }
        else
          where.append(" AND 1=0");
      }
    }
  }

  private void appendWhereTitle()
  {
    if (caseFilter.getTitle()!=null && !caseFilter.getTitle().equals("")) {
      String whereTitle = CaseManager.evalFieldExpression("CaseFilter.title", this, "UPPER(e.caseTypeNum) like :title", "");
      where.append(" AND (" + whereTitle + ")");
      parameters.put("title", caseFilter.getTitle().toUpperCase());
    }
  }

  private void appendWhereDescription()
  {
    if (caseFilter.getDescription()!=null && !caseFilter.getDescription().equals("")) {
      String whereTitle = CaseManager.evalFieldExpression("CaseFilter.description", this, "UPPER(e.sdetext) like :description", "");
      where.append(" AND (" + whereTitle + ")");
      parameters.put("description", caseFilter.getDescription().toUpperCase());
    }
  }


  private Set<String> getTypeIds()
  {
    Set<String> typeIds = new HashSet<String>();
    for (String role : userRoles)
    {
      List<String> types = RoleTypes.getTypes(role);
      if (types != null)
      {
        typeIds.addAll(types);
      }
    }

    return typeIds;
  }

  private void appendWhereProperties()
  {
    boolean filterByCaseState = false;
    boolean filterBySituacio = false;
    int filterByVariableCount = 0;

    for( Property prop : caseFilter.getProperty() ) {

      String name = prop.getName();
      String value = (prop.getValue()!=null)?prop.getValue().get(0):null;

      DBCaseProperty cp = null;
      try{ cp = DBCaseProperty.valueOf(name); } 
      catch (IllegalArgumentException ex) {};
      if (cp!=null) {
        where.append(" AND (" + cp.filterJPAObjectAlias + "." + cp.fieldName + " =:" + name + " OR :" + name + " IS NULL)");
        parameters.put(name, value);
        if (cp.className.equals("com.audifilm.matrix.cases.service.DBCaseState")) filterByCaseState = true;
        else if (cp.className.equals("com.audifilm.matrix.cases.service.DBSituacio")) filterBySituacio = true;
      
      } else if (name.startsWith("VAR")) {
        filterByVariableCount++;
        from.append(", CaseVariable cv" + filterByVariableCount);

        where.append(" AND (")
             .append(" cv" + filterByVariableCount + ".caseId=e.caseId")
             .append(" AND cv" + filterByVariableCount + ".variableId=:variableId" + filterByVariableCount)
             .append(" AND UPPER(cv" + filterByVariableCount + ".value) LIKE :varvalue" + filterByVariableCount)
             .append(" )");

        parameters.put("variableId" + filterByVariableCount, name.substring(3));
        parameters.put("varvalue" + filterByVariableCount, value==null?null:value.toUpperCase());
      }
    }
    if (filterByCaseState) {
      from.append(", CaseState cs");
      where.append(" AND cs.caseId = c.caseId");
    }
    if (filterBySituacio) {
      from.append(", Situacio s");
      where.append(" AND (e.caseId = s.caseId AND UPPER(s.propertyValue) LIKE :situacio" );
      where.append(")");
    }


  }

  private void appendAditionalSearchExpression()
  {
    String searchExpression = caseFilter.getSearchExpression();
    if (searchExpression !=null && !searchExpression.equals("") && !searchExpression.toUpperCase().contains("ORDER BY")) 
    {
      where.append(" AND (").append(searchExpression).append(")");
    }
  }

  private void appendWhereClassId()
  {
    if (caseFilter.getClassId() != null && caseFilter.getClassId().size() > 0)
    {
      //String classIds = PKUtil.globalIdListToLocalString(caseEntity, filter.getClassId());
      where.append(" AND (locate(concat(',', concat(trim(ap.classId), ',')), :classId) > 0)");
      parameters.put("classId", caseFilter.getClassId());
    }
  }


private void setCaseFilterParameters(JPAQuery query) throws Exception
  {
    if (caseFilter.getCaseId() != null && caseFilter.getCaseId().size() > 0)
    {
      //String caseIds = PKUtil.globalIdListToLocalString(caseEntity, filter.getCaseId());
      query.setIdParameter("caseId", caseFilter.getCaseId());
    }
    else
    {
      query.setParameter("caseId", null);
    }

    query.setParameter("registryFromDate", caseFilter.getFromDate());
    query.setParameter("registryToDate", caseFilter.getToDate());
    query.setParameter("registryDateComparator", caseFilter.getDateComparator());

    Set<Entry<String, Object>> paramSet = parameters.entrySet();
    for (Entry<String, Object> param : paramSet)
    {
      String name = param.getKey();
      Object value = param.getValue();
      query.setParameter(name, value);
    }

    
  }

}
