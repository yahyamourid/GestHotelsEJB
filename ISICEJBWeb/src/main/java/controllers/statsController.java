package controllers;

import jakarta.ejb.EJB;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import dao.IDaoLocale;
import entities.Hotel;
import entities.Ville;

/**
 * Servlet implementation class statsController
 */
public class statsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@EJB(beanName = "serviceHotel")
	private IDaoLocale<Hotel> ejb;
	
	@EJB(beanName = "serviceVille")
	private IDaoLocale<Ville> ejbv;

       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public statsController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Hotel> hotels = ejb.findAll();
        
        List<Ville> villes = ejbv.findAll();
        
        request.setAttribute("villes", villes);
        request.setAttribute("hotels", hotels);
        RequestDispatcher dispatcher = request.getRequestDispatcher("statistiques.jsp");
        dispatcher.forward(request, response);
        System.out.println(request.toString() + response.toString());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
