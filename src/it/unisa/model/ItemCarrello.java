package it.unisa.model;

public class ItemCarrello {

	public ItemCarrello(ProdottoBean prodotto){
		this.prodotto = prodotto;
		quantitaCarrello = 1;
	}
	
	public ProdottoBean getProdotto() {
		return prodotto;
	}
	
	public void setProdotto(ProdottoBean prodotto) {
		this.prodotto = prodotto;
	}
	
	public int getQuantitaCarrello() {
		return quantitaCarrello;
	}
	
	public void setQuantitaCarrello(int quantita) {
		this.quantitaCarrello = quantita;
	}
	
	public int getId() {
		return prodotto.getIdProdotto();
	}
	
	public double getTotalPrice() {
		return quantitaCarrello * prodotto.getPrezzo();
		

	}
	
	public String getDescription() {
		return prodotto.getDescrizione();
	}
	
	public void incrementa() {
		if(quantitaCarrello < prodotto.getQuantita() )
			quantitaCarrello = quantitaCarrello + 1;
	}
	
	public void decrementa() {
		if( quantitaCarrello > 1)
			quantitaCarrello = quantitaCarrello - 1;
	}
	
	private ProdottoBean prodotto;
	private int quantitaCarrello;
}