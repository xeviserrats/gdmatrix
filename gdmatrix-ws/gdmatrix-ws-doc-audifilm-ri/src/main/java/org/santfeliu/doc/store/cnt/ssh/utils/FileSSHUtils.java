package org.santfeliu.doc.store.cnt.ssh.utils;

import java.util.Date;
import java.util.Random;
import java.util.Vector;

import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.SftpException;

public class FileSSHUtils 
{
    /**
     * Si no existeix, crea l'estructura de directoris de 4 nivells.
     * @param pFTP
     * @param pGUID
     * @throws Exception
     */
    public static String mkdirByGUID(ChannelSftp pFTP, String pDirBase, String pGUID) throws Exception
    {
    	String wDirChar1 = pGUID.substring(0, 1).toUpperCase();
    	String wDirChar2 = pGUID.substring(1, 2).toUpperCase();
    	String wDirChar3 = pGUID.substring(2, 3).toUpperCase();

    	String wActualDir = pDirBase;
    	if (!wActualDir.endsWith("/"))
    		wActualDir += "/";
    	
    	mkdir(pFTP, wActualDir + wDirChar1);
    	mkdir(pFTP, wActualDir + wDirChar1 + "/" + wDirChar2);
    	mkdir(pFTP, wActualDir + wDirChar1 + "/" + wDirChar2 + "/" + wDirChar3);
    	
    	return pDirBase + wDirChar1 + "/" + wDirChar2 + "/" + wDirChar3;
    }
    
    public static  boolean existeixFitxer(ChannelSftp pSFTP, String pRemoteFile) throws Exception
    {
    	return existeixFitxer(pSFTP, pRemoteFile, true);
    }

    public static boolean existeixFitxer(ChannelSftp pSFTP, String pRemoteFile, boolean pRetryOnException) throws Exception
    {
    	try
    	{
    		Vector wVector = pSFTP.ls(pRemoteFile);
    		
    		if (wVector!=null)
    		{
	    		return wVector!=null && wVector.size()>0;
    		}
    		else
    			throw new IllegalArgumentException("Vector NULL");
    	}
    	catch(SftpException e)
    	{
    		if (e.id==2)
    			return false;
    		else
    		{
	    			throw new Exception(e);
    		}
    	}
    	catch(Exception e)
    	{
   			throw new Exception(e);
    	}
    }
    
    public static void mkdir(ChannelSftp pFTP, String wDirectori) throws Exception
    {
    	if (!existeixFitxer(pFTP, wDirectori))
    	{
    		// pot ser que dos threads diferents vulguin crear el directori alhora, ens hem de protegir de la concurrencia al crear el directori
    		try
    		{
	    		pFTP.mkdir(wDirectori);
    		}
    		catch(Exception e)
    		{
    			Thread.sleep(1000 + getRandomWait() );
    			try
    			{
	    			if (!existeixFitxer(pFTP, wDirectori, false))
			    		pFTP.mkdir(wDirectori);
    			}
    			catch(Exception ex) { }
    		}
    	}
    }
    
    
    /**
     * Retorna un valor aleatori entre 0 i 1000.
     * @return
     */
    public static int getRandomWait()
    {
    	return new Random(new Date().getTime()).nextInt(1000);
    }
}
