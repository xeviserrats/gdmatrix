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
package org.santfeliu.matrix.ide;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.Writer;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.function.Consumer;
import javax.swing.JTextArea;
import javax.swing.SwingUtilities;
import org.mozilla.javascript.Context;
import org.mozilla.javascript.ContextFactory;
import org.mozilla.javascript.Scriptable;
import org.mozilla.javascript.Undefined;
import org.santfeliu.util.script.ScriptableBase;

/**
 *
 * @author realor
 */
public class JavaScriptRunner extends Thread
{
  private final String code;
  private final JTextArea outputTextArea;
  private final HashMap variables = new HashMap();
  private Object result;
  private long startMillis;
  private long executionTime;
  private Consumer resultConsumer;

  public JavaScriptRunner(String code, JTextArea outputTextArea)
  {
    this.code = code;
    this.outputTextArea = outputTextArea;
  }

  public HashMap getVariables()
  {
    return variables;
  }

  @Override
  public void run()
  {
    Context cx = ContextFactory.getGlobal().enterContext();
    try
    {
      variables.put("output", new PrintWriter(new OutputWriter()));
      startMillis = System.currentTimeMillis();
      Scriptable scope = new ScriptableBase(cx, variables);
      result = cx.evaluateString(scope, code, "", 1, null);
    }
    catch (Exception ex)
    {
      result = ex.toString();
    }
    catch (ThreadDeath d)
    {
      result = "Execution interrupted.";
    }
    finally
    {
      executionTime = System.currentTimeMillis() - startMillis;

      Context.exit();
      SwingUtilities.invokeLater(() ->
      {
        if (!(result instanceof Undefined))
        {
          outputTextArea.append("\n" + result);
        }
        outputTextArea.append("\nExecution time: " +
          executionTime + " ms.");

        if (resultConsumer != null)
        {
          resultConsumer.accept(result);
        }
      });
    }
  }

  public Consumer getResultConsumer()
  {
    return resultConsumer;
  }

  public void setResultConsumer(Consumer resultConsumer)
  {
    this.resultConsumer = resultConsumer;
  }

  public void end()
  {
    try
    {
      Method method = this.getClass().getMethod("stop", new Class[0]);
      if (method != null)
      {
        method.invoke(this, new Object[0]);
      }
    }
    catch (Exception ex)
    {
      // ignore
    }
  }

  class OutputWriter extends Writer
  {
    @Override
    public void write(char[] cbuf, int off, int len) throws IOException
    {
      final String text = new String(cbuf, off, len);
      SwingUtilities.invokeLater(() ->
      {
        outputTextArea.append(text);
      });
      try
      {
        Thread.sleep(1);
      }
      catch (InterruptedException ex)
      {
        //ignore;
      }
    }

    @Override
    public void flush() throws IOException
    {
    }

    @Override
    public void close() throws IOException
    {
    }
  }
}
