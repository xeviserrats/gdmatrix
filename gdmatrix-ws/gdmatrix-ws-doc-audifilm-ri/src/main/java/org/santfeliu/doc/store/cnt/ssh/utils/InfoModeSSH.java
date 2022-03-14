package org.santfeliu.doc.store.cnt.ssh.utils;

public class InfoModeSSH 
{
	public String servidor;
	public String usuari;
	public String contrasenya;
	public String dirBase;

	public InfoModeSSH(String servidor, String usuari, String contrasenya, String dirBase)
	{
		super();
		this.servidor = servidor;
		this.usuari = usuari;
		this.contrasenya = contrasenya;
		this.dirBase = dirBase;
	}
}
