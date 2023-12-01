package controllers;

import jakarta.ejb.EJB;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import dao.IDaoLocale;
import entities.Ville;

/**
 * Servlet implementation class VilleController
 */
public class VilleController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@EJB
	private IDaoLocale<Ville> ejb;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public VilleController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String nom = request.getParameter("ville");
		ejb.create(new Ville(nom));
		
		request.setAttribute("villes", ejb.findAll());
		RequestDispatcher dispatcher = request.getRequestDispatcher("ville.jsp");
		
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
