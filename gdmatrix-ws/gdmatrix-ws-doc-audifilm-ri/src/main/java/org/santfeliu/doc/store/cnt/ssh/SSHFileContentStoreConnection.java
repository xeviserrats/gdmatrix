package org.santfeliu.doc.store.cnt.ssh;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.activation.DataHandler;

import org.matrix.doc.Content;
import org.matrix.doc.ContentInfo;
import org.santfeliu.doc.store.cnt.jdbc.ora.OracleContentStoreConnection;
import org.santfeliu.doc.store.cnt.ssh.utils.ConnSSH;
import org.santfeliu.doc.store.cnt.ssh.utils.FileSSHUtils;
import org.santfeliu.doc.store.cnt.ssh.utils.InfoModeSSH;
import org.santfeliu.util.TemporaryDataSource;

public class SSHFileContentStoreConnection extends OracleContentStoreConnection {
	private static final Logger log = Logger.getLogger(SSHFileContentStoreConnection.class.getName());

	public SSHFileContentStoreConnection(Connection conn, Properties config) {
		super(conn, config);
	}

	@Override
	public List<Content> findContents(Set<String> contentIds) throws Exception 
	{
		List<Content> contents = new ArrayList<Content>();
		int contentsSize = contentIds.size();
		if (contentsSize > 0) {
			String sql = "SELECT uuid, mimetype, puid, language, captureuser, capturedate, contentsize FROM CNT_CONTENT WHERE uuid = ?";

			int count = 1;
			while (count < contentsSize) 
			{
				sql = sql + " or uuid = ?";
				count++;
			}

			try (PreparedStatement prepStmt = conn.prepareStatement(sql)) 
			{
				count = 1;
				for (String contentId : contentIds) 
				{
					prepStmt.setString(count, contentId);
					count++;
				}

				System.out.println(sql);
				System.out.println(contentIds);

				try (ResultSet rs = prepStmt.executeQuery()) 
				{
					while (rs.next()) {
						Content content = new Content();
						content.setContentId(rs.getString(1));
						content.setContentType(rs.getString(2));
						content.setFormatId(rs.getString(3));
						content.setLanguage(rs.getString(4));
						content.setCaptureUserId(rs.getString(5));
						content.setCaptureDateTime(rs.getString(6));
						content.setSize(new Long(rs.getLong(7)));
						contents.add(content);
					}
				}
			}
		}
		return contents;
	}

	@Override
	public Content storeContent(Content content, File file) throws Exception 
	{
		boolean internal = (file != null);
		if (internal) {
			insertContentMetaData(conn, content);
			insertInternalContentFile(conn, content, file);
		} else // external
		{
			insertContentMetaData(conn, content);
			insertExternalContent(conn, content);
		}
		return content;
	}

	private void insertExternalContent(Connection conn, Content content) throws Exception 
	{
		String sql = "INSERT INTO CNT_EXTERNAL (uuid, fmt, url) VALUES (?, ?, ?)"; // config.getProperty("insertExternalContentSQL");

		try (PreparedStatement prepStmt = conn.prepareStatement(sql)) 
		{
			prepStmt.setString(1, content.getContentId());
			prepStmt.setString(2, getFormat(content.getContentType()));
			prepStmt.setString(3, content.getUrl());
			prepStmt.executeUpdate();
		}
	}

	private String getFormat(String mimeType) 
	{
		String format;
		if (mimeType.startsWith("text/")) {
			format = FMT_TEXT;
		} else if (mimeType.startsWith("image/") || mimeType.startsWith("video/") || mimeType.startsWith("audio/")
				|| mimeType.equalsIgnoreCase("application/octet-stream")) {
			format = FMT_IGNORE;
		} else {
			format = FMT_BINARY;
		}
		return format;
	}

	private void insertInternalContentFile(Connection conn, Content content, File pFile) throws Exception 
	{
		try (ConnSSH wConnSSH = new ConnSSH())
		{
			InfoModeSSH wSSH = ConnSSH.getInfoModeSSH(conn);
			wConnSSH.init(wSSH.servidor, wSSH.usuari, wSSH.contrasenya, wSSH.dirBase);

			String wRemoteDir = wConnSSH.getDirectoriByIdNReg(conn, content.getContentId());
			String wRemoteFile = wRemoteDir + "/" + wConnSSH.getFileName(content.getContentId());

			if (FileSSHUtils.existeixFitxer(wConnSSH.getCanal(), wRemoteFile)) 
			{
				String wAra = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
				String wNewName = wRemoteFile + "_" + wAra + ".deleted";

				log.log(Level.INFO, "El fichero '" + wRemoteFile + "' existe. Se modificará a: '" + wNewName + "'");

				try {
					wConnSSH.rename(wRemoteFile, wNewName);
				} catch (Exception e) {
					log.log(Level.WARNING, e.getMessage(), e);
				}
			}

			wConnSSH.put(pFile, wRemoteFile);

			String sql = "INSERT INTO CNT_INTERNAL (uuid, fmt, data) VALUES (?, ?, null)"; // config.getProperty("insertInternalSSHContentSQL");

			try (PreparedStatement prepStmt = conn.prepareStatement(sql);) {
				prepStmt.setString(1, content.getContentId());
				prepStmt.setString(2, getFormat(content.getContentType()));
				prepStmt.executeUpdate();
			}
		}
	}

	private void insertContentMetaData(Connection conn, Content content) throws Exception 
	{
		String sql = "INSERT INTO CNT_CONTENT (uuid, filetype, mimetype, puid, language, captureuser, capturedate, contentsize, creationdate) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

		try (PreparedStatement prepStmt = conn.prepareStatement(sql)) 
		{
			String fileType = content.getData() == null ? EXTERNAL : INTERNAL;
			prepStmt.setString(1, content.getContentId());
			prepStmt.setString(2, fileType);
			prepStmt.setString(3, content.getContentType());
			prepStmt.setString(4, content.getFormatId());
			prepStmt.setString(5, content.getLanguage());
			prepStmt.setString(6, content.getCaptureUserId());
			prepStmt.setString(7, content.getCaptureDateTime());
			prepStmt.setLong(8, content.getSize());
			prepStmt.setString(9, content.getCreationDate());
			prepStmt.executeUpdate();
		}
	}

	protected void insertInternalContent(Connection conn, Content content, File pFile) throws Exception 
	{
		String sql = "INSERT INTO CNT_INTERNAL (uuid, fmt, data) VALUES (?, ?, null)";

		try (ConnSSH wConnSSH = new ConnSSH())
		{
			InfoModeSSH wSSH = ConnSSH.getInfoModeSSH(conn);
			wConnSSH.init(wSSH.servidor, wSSH.usuari, wSSH.contrasenya, wSSH.dirBase);

			String wRemoteDir = wConnSSH.getDirectoriByIdNReg(conn, content.getContentId());
			String wRemoteFile = wRemoteDir + "/" + wConnSSH.getFileName(content.getContentId());

			if (FileSSHUtils.existeixFitxer(wConnSSH.getCanal(), wRemoteFile)) {
				String wAra = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
				String wNewName = wRemoteFile + "_" + wAra + ".deleted";

				log.log(Level.WARNING, "El fichero '" + wRemoteFile + "' existe. Se modificará a: '" + wNewName + "'");

				try 
				{
					wConnSSH.rename(wRemoteFile, wNewName);
				} catch (Exception e) {
					log.log(Level.WARNING, e.getMessage(), e);
				}
			}

			wConnSSH.put(pFile, wRemoteFile);

			try (PreparedStatement prepStmt = conn.prepareStatement(sql)) {
				prepStmt.setString(1, content.getContentId());
				prepStmt.setString(2, getFormat(content.getContentType()));
				prepStmt.executeUpdate();
			}
		}
	}

	@Override
	public Content loadContent(String contentId, ContentInfo contentInfo) throws Exception 
	{
		Content content = null;
		String sql = // config.getProperty("selectContentSSHSQL");
				"SELECT c.uuid, c.filetype, c.mimetype, c.puid, c.language, c.captureuser, c.capturedate, c.contentsize, null, e.url "
						+ "FROM CNT_CONTENT c, CNT_INTERNAL i, CNT_EXTERNAL e  "
						+ "WHERE c.uuid = i.uuid (+) and c.uuid = e.uuid (+) and c.uuid = ?";

		try (ConnSSH wConnSSH = new ConnSSH();
			PreparedStatement prepStmt = conn.prepareStatement(sql);
			ResultSet rs = prepStmt.executeQuery())
		{
			InfoModeSSH wSSH = ConnSSH.getInfoModeSSH(conn);
			wConnSSH.init(wSSH.servidor, wSSH.usuari, wSSH.contrasenya, wSSH.dirBase);

			File wFileGetDocument = File.createTempFile("MATRIX_GET_GILE_", ".dat");

			prepStmt.setString(1, contentId);

			if (rs.next()) 
			{
				content = new Content();
				String fileType = rs.getString(2);
				content.setContentId(rs.getString(1));
				if (!ContentInfo.ID.equals(contentInfo)) 
				{
					content.setContentType(rs.getString(3));
					content.setFormatId(rs.getString(4));
					content.setLanguage(rs.getString(5));
					content.setCaptureUserId(rs.getString(6));
					content.setCaptureDateTime(rs.getString(7));
					content.setSize(new Long(rs.getLong(8)));
					if (INTERNAL.equals(fileType)) 
					{
						if (ContentInfo.ALL.equals(contentInfo)) {
							String wRemoteDir = wConnSSH.getDirectoriByIdNReg(conn, content.getContentId());
							String wRemoteFile = wRemoteDir + "/" + wConnSSH.getFileName(content.getContentId());

							wConnSSH.get(wRemoteFile, wFileGetDocument);

							DataHandler dh = new DataHandler(
									new TemporaryDataSource(wFileGetDocument, content.getContentType()));
							content.setData(dh);
						}
					} else if (EXTERNAL.equals(fileType))
						if (!ContentInfo.ID.equals(contentInfo))
							content.setUrl(rs.getString(10));
				}
			}
		}
		return content;
	}
}
