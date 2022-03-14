package org.santfeliu.doc.store.cnt.ssh;

import java.sql.Connection;
import java.util.Properties;

import org.santfeliu.doc.store.cnt.jdbc.JdbcContentStoreConnection;
import org.santfeliu.doc.store.cnt.jdbc.ora.OracleContentStore;

public class SSHFileContentStore extends OracleContentStore 
{
	@Override
	protected JdbcContentStoreConnection getContentStoreConnection(Connection conn, Properties config)
	{
		return new SSHFileContentStoreConnection(conn, config);
	}
}
