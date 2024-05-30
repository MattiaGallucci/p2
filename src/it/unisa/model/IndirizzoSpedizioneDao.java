package it.unisa.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class IndirizzoSpedizioneDao implements IndirizzoSpedizioneDaoInterfaccia{

	private static DataSource ds;

	static {
		try {
			Context initCtx = new InitialContext();
			Context envCtx = (Context) initCtx.lookup("java:comp/env");

			ds = (DataSource) envCtx.lookup("jdbc/storage");

		} catch (NamingException e) {
			System.out.println("Error:" + e.getMessage());
		}
	}
	
	private static final String TABLE_NAME = "indirizzo_spedizione";

	
	@Override
	public synchronized void doSave(IndirizzoSpedizioneBean bean) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String insertSQL = "INSERT INTO " + IndirizzoSpedizioneDao.TABLE_NAME
				+ " (INDIRIZZO, CAP, TELEFONO, PROVINCIA, NOME, COGNOME, CITTA) VALUES (?, ?, ?, ?, ?, ?, ?)";

		try {
			connection = ds.getConnection();
			connection.setAutoCommit(false);
			preparedStatement = connection.prepareStatement(insertSQL);
			preparedStatement.setString(1, bean.getIndirizzo());
			preparedStatement.setString(2, bean.getCap());
			preparedStatement.setString(3, bean.getTelefono());
			preparedStatement.setString(4, bean.getProvincia());
			preparedStatement.setString(5, bean.getNome());
			preparedStatement.setString(6, bean.getCognome());
			preparedStatement.setString(7, bean.getCitta());


			preparedStatement.executeUpdate();

			connection.commit();
		} 
		finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} 
			finally {
				if (connection != null)
					connection.close();
			}
		}
	}

	
	@Override
	public synchronized IndirizzoSpedizioneBean doRetrieveByKey(String indirizzo, String cap) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		IndirizzoSpedizioneBean bean = new IndirizzoSpedizioneBean();

		String selectSQL = "SELECT * FROM " + IndirizzoSpedizioneDao.TABLE_NAME 
						+ " WHERE INDIRIZZO = ? AND CAP = ?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setString(1, indirizzo);
			preparedStatement.setString(2, cap);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				bean.setTelefono(rs.getString("TELEFONO"));
				bean.setProvincia(rs.getString("PROVINCIA"));
				bean.setNome(rs.getString("NOME"));
				bean.setCognome(rs.getString("COGNOME"));
				bean.setCitta(rs.getString("CITTA"));
				bean.setIndirizzo(rs.getString("INDIRIZZO"));
				bean.setCap(rs.getString("CAP"));

				
			}

		} 
		finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} 
			finally {
				if (connection != null)
					connection.close();
			}
		}
		
		return bean;
	}
	
	
	public synchronized void doDelete(IndirizzoSpedizioneBean bean) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		String query = "DELETE FROM " + IndirizzoSpedizioneDao.TABLE_NAME
				+ " WHERE INDIRIZZO = ? AND CAP = ? ";
		
		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(query);
			preparedStatement.setString(1, bean.getIndirizzo());
			preparedStatement.setString(2, bean.getCap());

			preparedStatement.executeUpdate();
		
		}
		finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} 
			finally {
				if (connection != null)
					connection.close();
			}
		}
	}
	
	
}
