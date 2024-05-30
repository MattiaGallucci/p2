package it.unisa.model;

import java.io.Serializable;

public class ProdottoBean implements Serializable {

private static final long serialVersionUID = 1L;

	public ProdottoBean() {
		
	}

	public int getIdProdotto() {
		return idProdotto;
	}

	public void setIdProdotto(int idProdotto) {
		this.idProdotto = idProdotto;
	}
	

	public String getNome() {
		return nome;
	}
	
	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getDescrizione() {
		return descrizione;
	}

	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}
	
	public int getQuantita() {
		return quantita;
	}
	
	public void setQuantita(int quantita) {
		this.quantita = quantita;
	}
	
	
	public boolean isInVendita() {
		return inVendita;
	}
	
	public void setInVendita(boolean inVendita) {
		this.inVendita = inVendita;
	}
	
	public String getIva() {
		return iva;
	}
	
	public void setIva(String iva) {
		this.iva = iva;
	}

	public double getPrezzo() {
		return prezzo;
	}

	public void setPrezzo(double prezzo) {
		this.prezzo = prezzo;
	}

	public String getDataUscita() {
		return dataUscita;
	}
	
	public void setDataUscita(String dataUscita) {
		this.dataUscita = dataUscita;
	}
	
	public String getGenere() {
		return genere;
	}
	
	public void setGenere(String genere) {
		this.genere = genere;
	}
	
	public String getImmagine() {
		return immagine;
	}
	
	public void setImmagine(String immagine) {
		this.immagine = immagine;
	}
	
	public String getPiattaforma() {
		return piattaforma;
	}
	
	public void setPiattaforma(String piattaforma) {
		this.piattaforma = piattaforma;
	}
	
	public String getDescrizioneDettagliata() {
		return descrizioneDettagliata;
	}
	
	public void setDescrizioneDettagliata(String descrizioneDettagliata) {
		this.descrizioneDettagliata = descrizioneDettagliata;
	}
	
	
	@Override
	public String toString() {
		return nome +", " + idProdotto +", " + prezzo +", " + descrizione +", " + piattaforma +", " + quantita +", " + genere+", "+ immagine+", " + dataUscita + ", " +iva;
	}

	private int idProdotto;
	private String piattaforma;
	private String nome;
	private String descrizione;
	private int quantita;
	private String dataUscita;
	private boolean inVendita;
	private String iva;
	private double prezzo;
	private String immagine;
	private String genere;
	private String descrizioneDettagliata;
}