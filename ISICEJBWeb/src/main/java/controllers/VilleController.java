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
import entities.Ville;

@WebServlet("/VilleController")
public class VilleController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@EJB(beanName = "serviceVille")
	private IDaoLocale<Ville> ejb;
       
    
    public VilleController() {
        super();
      
    }
    @Override
    public void init() throws ServletException {
        super.init();
        List<Ville> villes = ejb.findAll();
        getServletContext().setAttribute("villes", villes);
    }

	
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	String nom = request.getParameter("ville");
        String op = request.getParameter("op");
        String idstr = request.getParameter("id");

        if (op != null) {
            if (op.equals("Ajouter")) {
                ejb.create(new Ville(nom));
            } else if (op.equals("Modifier") && idstr != null) {
            	int id = Integer.parseInt(idstr);
            	Ville v = ejb.findById(id);
            	v.setNom(nom);
            	ejb.update(v);
                            
            } else if (op.equals("Delete") && idstr != null) {
                int id = Integer.parseInt(idstr);
                ejb.delete(ejb.findById(id));
                
            }
        }

        List<Ville> villes = ejb.findAll();
        
        request.setAttribute("villes", villes);
       

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