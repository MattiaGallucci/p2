package it.unisa.control;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.model.Carrello;
import it.unisa.model.ItemCarrello;
import it.unisa.model.ProdottoDao;

@WebServlet("/carrello")
public class CarrelloServlet extends HttpServlet{

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		ProdottoDao prodDao = new ProdottoDao();
		Carrello cart = (Carrello)request.getSession().getAttribute("cart");
		if(cart == null) {
			cart = new Carrello();
			request.getSession().setAttribute("cart", cart);
		}
		
		String action = request.getParameter("action");
		String quantita = request.getParameter("qnt");
		String redirectedPage = request.getParameter("page");
		
		
		try {
			if (action != null) {
				if (action.equalsIgnoreCase("addC")) {
					int id = Integer.parseInt(request.getParameter("id"));
					cart.addProdotto(prodDao.doRetrieveByKey(id));
				} else if (action.equalsIgnoreCase("deleteC")) {
					int id = Integer.parseInt(request.getParameter("id"));
					cart.deleteProdotto(prodDao.doRetrieveByKey(id));
					
				}
			}
				if(quantita!=null) {
					int id = Integer.parseInt(request.getParameter("Id"));
					ItemCarrello item = cart.getItem(id);
					item.setQuantitaCarrello(Integer.parseInt(quantita));
					
				}
			
			
		} catch (SQLException e) {
			System.out.println("Error:" + e.getMessage());
		}
		
	
		
		request.getSession().setAttribute("cart", cart);
		request.setAttribute("cart", cart);
		
		
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/" + redirectedPage);
			dispatcher.forward(request, response);

	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		super.doPost(request, response);
	}
	

}
