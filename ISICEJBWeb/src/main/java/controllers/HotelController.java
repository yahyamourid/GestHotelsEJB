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


public class HotelController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@EJB(beanName = "serviceHotel")
	private IDaoLocale<Hotel> ejb;
	
	@EJB(beanName = "serviceVille")
	private IDaoLocale<Ville> ejbv;
       
   
    public HotelController() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	String nom = request.getParameter("nom");
    	String adresse = request.getParameter("adresse");
    	String telephone = request.getParameter("telephone");
        String op = request.getParameter("op");
        String idHotelstr = request.getParameter("idH");
        String idVillestr = request.getParameter("idV");

        if (op != null) {
            if (op.equals("Ajouter") && idVillestr != null) {
            	Ville v = ejbv.findById(Integer.parseInt(idVillestr));
                ejb.create(new Hotel(nom,adresse,telephone,v));
            } 
            else if (op.equals("Modifier") && idHotelstr != null && idVillestr != null) {
            	Ville v = ejbv.findById(Integer.parseInt(idVillestr));
            	Hotel h = ejb.findById(Integer.parseInt(idHotelstr));
            	h.setNom(nom);
            	h.setAdresse(adresse);
            	h.setTelephone(telephone);
            	h.setVille(v);
            	ejb.update(h);
                            
            } 
            else if (op.equals("Delete") && idHotelstr != null) {
                ejb.delete(ejb.findById(Integer.parseInt(idHotelstr)));
                
            }
        }
        List<Hotel> hotels;
        if(op != null && op.equals("Tri")  && idVillestr != null)
        	hotels = ejb.findHotelsByVille(Integer.parseInt(idVillestr));
        else 
        	hotels = ejb.findAll();
        
        List<Ville> villes = ejbv.findAll();
        
        request.setAttribute("villes", villes);
        request.setAttribute("hotels", hotels);
        RequestDispatcher dispatcher = request.getRequestDispatcher("hotel.jsp");
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
