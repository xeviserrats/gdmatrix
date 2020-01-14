package org.santfeliu.web.obj.util;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashSet;
import java.util.List;
import org.matrix.dic.Property;
import org.matrix.dic.PropertyDefinition;
import org.santfeliu.dic.Type;
import org.santfeliu.dic.util.DictionaryUtils;
import org.santfeliu.util.FilterUtils;
import org.santfeliu.util.TextUtils;

/**
 *
 * @author blanquepa
 */
public class KeywordsManager implements Serializable
{
  public static final String KEYWORDS_PROPERTY = "keywords";
  public static final String KEYWORDS_PROPERTIES_PROPERTY = "_keywordsProperties";

  private List<String> keywords;
  private HashSet<String> dummyWords = new HashSet();

  public KeywordsManager(String searchText)
  {
    dummyWords = loadDummyWords();
    keywords = parseSearchText(searchText);
  }

  public static KeywordsManager newInstance(List<Property> formProperties)
  {
    KeywordsManager keywordsManager = null;
    if (formProperties != null)
    {
      int remove = -1;
      for (Property property : formProperties)
      {
        if (property.getName().equals(KEYWORDS_PROPERTY))
        {
          keywordsManager = new KeywordsManager(property.getValue().get(0));
          remove = formProperties.indexOf(property);
        }
      }
      if (remove >= 0)
        formProperties.remove(remove);
    }
    return keywordsManager;
  }

  public Property getDisjointKeywords()
  {
    Property property = new Property();
    property.setName(KEYWORDS_PROPERTY);
    if (keywords != null && !keywords.isEmpty())
    {
      for (String keyword : keywords)
      {
        property.getValue().add(FilterUtils.addWildcards(keyword));
      }
    }

    return property;
  }

  public List<Property> getJointKeywords()
  {
    List<Property> properties = new ArrayList();
    if (keywords != null && !keywords.isEmpty())
    {
      for (String keyword : keywords)
      {
        Property property = new Property();
        property.setName(KEYWORDS_PROPERTY);
        property.getValue().add(FilterUtils.addWildcards(keyword));
        properties.add(property);
      }
    }

    return properties;
  }

  public void sortResults(List results)
  {
    Collections.sort(results, new KeywordsComparator());
  }

  public static void storeKeywords(Object object, Type type,
    String defaultMainProperty)
  {
    if (isKeywordsDefined(type))
    {
      String keywords = null;
      if (!DictionaryUtils.containsProperty(object, KeywordsManager.KEYWORDS_PROPERTY))
      {
        //Main property
        Property p = DictionaryUtils.getProperty(object, defaultMainProperty);
        if (p != null)
          keywords = KeywordsManager.toKeywordsText(keywords, p.getValue().get(0));

        PropertyDefinition propDef =
          type.getPropertyDefinition(KeywordsManager.KEYWORDS_PROPERTIES_PROPERTY);
        if (propDef != null)
        {
          String properties = propDef.getValue().get(0);
          for (String prop : properties.split(","))
          {
            p = DictionaryUtils.getProperty(object, prop.trim());
            if (p != null)
              keywords = KeywordsManager.toKeywordsText(keywords, p.getValue().get(0));
          }
        }
      }
      else
      {
        Property p = DictionaryUtils.getProperty(object, KeywordsManager.KEYWORDS_PROPERTY);
        keywords = KeywordsManager.toKeywordsText(p.getValue().get(0));
      }
      DictionaryUtils.setProperty(object, KeywordsManager.KEYWORDS_PROPERTY, keywords);
    }
  }

  private List<String> parseSearchText(String searchText)
  {
    List<String> result = new ArrayList();
    if (searchText != null)
    {
      String[] parts = searchText.split(" ");
      if (parts.length > 0)
      {
        List<String> searchWords = new ArrayList();
        for (int i = 0; i < parts.length; i++)
        {
          String word = parts[i].toLowerCase();
          word = TextUtils.unAccent(word);
          word = word.replaceAll("[^\\w]", "");
          if (word.length() > 2)
            searchWords.add(word);
        }
        searchWords = removeDummyWords(searchWords);
        result.addAll(searchWords);
      }
    }

    return result;
  }

  private static String toKeywordsText(String currentText, String text)
  {
    StringBuilder sb = new StringBuilder();
    if (currentText != null)
      sb.append(currentText);
    if (text != null)
    {
      String parts[] = text.split(" ");
      for (int i = 0; i < parts.length; i++)
      {
        String word = parts[i].toLowerCase();
        word = TextUtils.unAccent(word);
        word = word.replaceAll("[^\\w]", "");
        if (word.length() > 2 && !sb.toString().contains(word + " "))
        {
          sb.append(word).append(" ");
        }
      }
    }
    return sb.toString();
  }

  private static String toKeywordsText(String text)
  {
    return toKeywordsText(null, text);
  }


  private static boolean isKeywordsDefined(Type type)
  {
    if (type != null)
      return type.getPropertyDefinition(KeywordsManager.KEYWORDS_PROPERTY) != null;
    else
      return false;
  }

  private HashSet<String> loadDummyWords()
  {
    //TODO:
    return new HashSet();
  }

  private List<String> removeDummyWords(List<String> searchWords)
  {
    List<String> result = new ArrayList();
    for (String searchWord : searchWords)
    {
      if (!dummyWords.contains(searchWord))
        result.add(searchWord);
    }
    return result;
  }

  public class KeywordsComparator implements Comparator
  {
    public KeywordsComparator()
    {
    }
    
    public int compare(Object o1, Object o2)
    {
      if (o1 != null && o2 != null)
      {
        Property p1 =
          DictionaryUtils.getProperty(o1, KeywordsManager.KEYWORDS_PROPERTY);
        Property p2 =
          DictionaryUtils.getProperty(o2, KeywordsManager.KEYWORDS_PROPERTY);
        if (p1 != null && p2 != null)
        {
          String k1 = p1.getValue().get(0);
          String k2 = p2.getValue().get(0);
          List<String> keywords1 = parseSearchText(k1);
          List<String> keywords2 = parseSearchText(k2);
          double score1 = 0;
          double score2 = 0;
          for (String word : keywords)
          {
            score1 = score1 + (keywords1.indexOf(word) >= 0 ?
              (double)((double)keywords1.indexOf(word) / (double)keywords1.size()) : 2.0);
            score2 = score2 + (keywords2.indexOf(word) >= 0 ?
              (double)((double)keywords2.indexOf(word) / (double)keywords2.size()) : 2.0);
          }
          return (score1 <= score2 ? -1 : 1);
        }
      }
      else if (o1 != null)
        return -1;
      else if (o2 != null)
        return 1;

      return 0;
    }

  }
}
