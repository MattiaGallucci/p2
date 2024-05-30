package it.unisa.control;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import it.unisa.model.*;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/Login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserDao usDao = new UserDao();

        try {
            UserBean user = new UserBean();
            user.setUsername(request.getParameter("un"));
            // Recupera la password crittografata dal database
            String encryptedPassword = usDao.retrieveEncryptedPassword(request.getParameter("un"));
            // Calcola l'hash della password fornita dall'utente
            String hashedPassword = hashPassword(request.getParameter("pw"));
            
            // Confronta la password crittografata nel database con quella fornita dall'utente
            if (encryptedPassword != null && encryptedPassword.equals(hashedPassword)) {
                HttpSession session = request.getSession(true);
                session.setAttribute("currentSessionUser", user);
                String checkout = request.getParameter("checkout");
                if (checkout != null)
                    response.sendRedirect(request.getContextPath() + "/account?page=Checkout.jsp");
                else
                    response.sendRedirect(request.getContextPath() + "/Home.jsp");
            } else
                response.sendRedirect(request.getContextPath() + "/Login.jsp?action=error"); // error page
        } catch (SQLException e) {
            System.out.println("Error:" + e.getMessage());
        }
    }

    // Metodo per crittografare la password usando SHA-256
    private String hashPassword(String password) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(password.getBytes());
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1)
                    hexString.append('0');
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }
}
