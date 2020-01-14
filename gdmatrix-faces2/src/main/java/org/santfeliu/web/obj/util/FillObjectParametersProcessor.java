/*
 * GDMatrix
 *  
 * Copyright (C) 2020, Ajuntament de Sant Feliu de Llobregat
 *  
 * This program is licensed and may be used, modified and redistributed under 
 * the terms of the European Public License (EUPL), either version 1.1 or (at 
 * your option) any later version as soon as they are approved by the European 
 * Commission.
 *  
 * Alternatively, you may redistribute and/or modify this program under the 
 * terms of the GNU Lesser General Public License as published by the Free 
 * Software Foundation; either  version 3 of the License, or (at your option) 
 * any later version. 
 *   
 * Unless required by applicable law or agreed to in writing, software 
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT 
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. 
 *    
 * See the licenses for the specific language governing permissions, limitations 
 * and more details.
 *    
 * You should have received a copy of the EUPL1.1 and the LGPLv3 licenses along 
 * with this program; if not, you may find them at: 
 *    
 * https://joinup.ec.europa.eu/software/page/eupl/licence-eupl
 * http://www.gnu.org/licenses/ 
 * and 
 * https://www.gnu.org/licenses/lgpl.txt
 */
package org.santfeliu.web.obj.util;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import org.matrix.dic.Property;
import org.santfeliu.dic.util.DictionaryUtils;


/**
 * This ParametersProcessor is used to inform object properties with the values
 * passed in URL paramters preceeded by @ or _ prefix.
 *
 * @author blanquepa
 */
public class FillObjectParametersProcessor extends ParametersProcessor
{
  public static final String PARAMETER_PREFIX = "@"; //Prefix applied to fields
  public static final String PARAMETER_PREFIX2 = "_"; //Prefix applied to fields
  
  private Object object;
  private List<Property> processedParameters;  
  private boolean objectModified = false;
  
  public FillObjectParametersProcessor(Object object)
  {
    this.object = object;
  }

  public Object getObject()
  {
    return object;
  }

  public void setObject(Object object)
  {
    this.object = object;
  }

  @Override
  public String processParameters(Map parameters)
  { 
    setParametersToObject(parameters, object);
    return null;
  }

  public boolean isObjectModified()
  {
    return objectModified;
  }

  public void setObjectModified(boolean objectModified)
  {
    this.objectModified = objectModified;
  }

  public List<Property> getProcessedParameters()
  {
    return processedParameters;
  }

  public void setProcessedParameters(List<Property> processedParameters)
  {
    this.processedParameters = processedParameters;
  }
  
  private void setParametersToObject(Map requestMap, Object object)
  {
    objectModified = false;
    processedParameters = new ArrayList();
    Set keys = requestMap.keySet();
    Iterator it = keys.iterator();
    while (it.hasNext())
    {
      String key = (String)it.next();
      if ((key.startsWith(PARAMETER_PREFIX) || key.startsWith(PARAMETER_PREFIX2)) 
        && !key.endsWith(PARAMETER_PREFIX2))
      {
        Object value = requestMap.get(key);
        key = key.substring(1);
        DictionaryUtils.setProperty(object, key, value);

        if (DictionaryUtils.containsProperty(object, key) ||
          KeywordsManager.KEYWORDS_PROPERTY.equals(key))
            DictionaryUtils.addProperty(processedParameters, key, String.valueOf(value));

        objectModified = true;
      }
    }
  }  
  
}
