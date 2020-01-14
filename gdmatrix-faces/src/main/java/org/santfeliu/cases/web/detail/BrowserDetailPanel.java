package org.santfeliu.cases.web.detail;

import java.util.List;
import org.matrix.cases.CaseDocumentFilter;
import org.matrix.cases.CaseDocumentView;
import org.matrix.dic.Property;
import org.matrix.doc.ContentInfo;
import org.matrix.doc.Document;
import org.santfeliu.cases.web.CaseConfigBean;
import org.santfeliu.dic.util.DictionaryUtils;
import org.santfeliu.doc.web.DocumentConfigBean;
import org.santfeliu.web.obj.DetailBean;
import org.santfeliu.web.obj.DetailPanel;

/**
 *
 * @author blanquepa
 */
public class BrowserDetailPanel extends DetailPanel
{
  public static final String CASE_DOCUMENT_TYPE_PROPERTY =
    "caseDocumentTypeId";
  public static final String PROPERTY_NAME =
    "propertyName";
  public static final String PROPERTY_VALUE =
    "propertyValue";

  private String url;

  @Override
  public void loadData(DetailBean detailBean)
  {
    try
    {
      String caseId = ((CaseDetailBean) detailBean).getCaseId();
      CaseDocumentFilter filter = new CaseDocumentFilter();
      filter.setCaseId(caseId);
      List<CaseDocumentView> caseDocuments =
        CaseConfigBean.getPort().findCaseDocumentViews(filter);
      //Search for specific CaseDocumentType
      for (CaseDocumentView caseDocument : caseDocuments)
      {
        if (getCaseDocumentTypeIds().contains(caseDocument.getCaseDocTypeId()))
          url = "/documents/" + caseDocument.getDocument().getDocId();
      }

      //If not type found, search properties in document
      String propertyName = getProperty(PROPERTY_NAME);
      String propertyValue = getProperty(PROPERTY_VALUE);
      if (url == null && propertyName != null && propertyValue != null)
      {
        for (CaseDocumentView caseDocument : caseDocuments)
        {
          Document document = DocumentConfigBean.getClient().loadDocument(
            caseDocument.getDocument().getDocId(), 0, ContentInfo.METADATA);

          Property property = DictionaryUtils.getProperty(document, propertyName);
          if (property != null && property.getValue() != null &&
            property.getValue().contains(propertyValue))
          {
            url = "/documents/" + caseDocument.getDocument().getDocId();
          }
        }
      }
    }
    catch (Exception ex)
    {
      error(ex);
    }
  }

  public List<String> getCaseDocumentTypeIds()
  {
    return getMultivaluedProperty(CASE_DOCUMENT_TYPE_PROPERTY);
  }

  public String getUrl()
  {
    return url;
  }

  public void setUrl(String url)
  {
    this.url = url;
  }

  @Override
  public boolean isRenderContent()
  {
    return getUrl() != null;
  }

  @Override
  public String getType()
  {
    return "browser";
  }
}
