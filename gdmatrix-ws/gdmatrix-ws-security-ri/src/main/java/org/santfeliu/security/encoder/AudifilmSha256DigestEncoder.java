package org.santfeliu.security.encoder;

import java.math.BigInteger;
import java.security.MessageDigest;

/**
 * Encode the password using SHA-256 with a SALT
 * <br>
 * <br>
<pre>
   <context-param>
       <param-name>org.santfeliu.security.service.SecurityManager.digestEncoder</param-name>
       <param-value>org.santfeliu.security.encoder.AudifilmSha256DigestEncoder</param-value>
   </context-param><br>
      <context-param>
       <param-name>org.santfeliu.security.service.SecurityManager.digestParameters</param-name>
       <param-value>SALT_DIGEST_VALUE</param-value>
   </context-param>
</pre>
 * @author xserrats
 *
 */
public class AudifilmSha256DigestEncoder implements DigestEncoder 
{
	@Override
	public String encode(String password, String parameters) throws Exception 
	{
		String wHashConcatenar = "_hash_";
		if (parameters!=null && parameters.length()>0)
			wHashConcatenar = parameters.trim();
		
		return sha256(wHashConcatenar + password.trim()).toUpperCase();
	}

	private static String sha256(String missatge) throws Exception
	{
		MessageDigest  md;
		try
		{
			md= MessageDigest.getInstance("SHA-256");
            md.update(missatge.getBytes());
            byte[] mdbytes = md.digest();

            BigInteger intNumber = new BigInteger(1, mdbytes);
	        String strHashCode = intNumber.toString(16);

	        while (strHashCode.length() < 64) {
	            strHashCode = "0" + strHashCode;
	        }

	        return strHashCode;
		}
		catch(Exception e)
		{
			e.printStackTrace(System.out);
			throw e;
		}
	}
	
}
