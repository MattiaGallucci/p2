package it.unisa.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ComposizioneDao implements ComposizioneDaoInterfaccia{

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
	
	private static final String TABLE_NAME = "composizione";

	
	@Override
	public synchronized void doSave(ComposizioneBean composizione) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String insertSQL = "INSERT INTO " + ComposizioneDao.TABLE_NAME
						+ " (ID_ORDINE, ID_PRODOTTO, QUANTITA, IVA, PREZZO_TOT) VALUES (?, ?, ?, ?, ?) ";

		try {
			connection = ds.getConnection();
			connection.setAutoCommit(false);
			preparedStatement = connection.prepareStatement(insertSQL);
			preparedStatement.setInt(1, composizione.getIdOrdine());
			preparedStatement.setInt(2, composizione.getIdProdotto());
			preparedStatement.setInt(3, composizione.getQuantita());
			preparedStatement.setString(4, composizione.getIva());
			preparedStatement.setDouble(5, composizione.getPrezzoTotale());
			
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
	public synchronized ArrayList<ComposizioneBean> doRetrieveByOrdine(int idOrdine) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		ArrayList<ComposizioneBean> composizioni = new ArrayList<ComposizioneBean>();
		
		String selectSQL = "SELECT * FROM " + ComposizioneDao.TABLE_NAME
						+ " WHERE ID_ORDINE = ? ";
		
		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setInt(1, idOrdine);
			
			ResultSet rs = preparedStatement.executeQuery();
			
			while (rs.next()) {
				ComposizioneBean composizione = new ComposizioneBean();
				composizione.setIdOrdine(rs.getInt("ID_ORDINE"));
				composizione.setIdProdotto(rs.getInt("ID_PRODOTTO"));
				composizione.setQuantita(rs.getInt("QUANTITA"));
				composizione.setIva(rs.getString("IVA"));
				composizione.setPrezzoTotale(rs.getDouble("PREZZO_TOT"));
				composizioni.add(composizione);
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
		
		return composizioni;
	}
		
}