package services;

import java.util.List;

import dao.IDaoLocale;
import dao.IDaoRemote;
import entities.Hotel;
import entities.Ville;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;

@Stateless(name = "serviceHotel")
public class HotelService implements IDaoRemote<Hotel>, IDaoLocale<Hotel> {
	
	@PersistenceContext
	private EntityManager em;

	@Override
	public Hotel create(Hotel o) {
		em.persist(o);
		return o;
	}

	@Override
	public boolean delete(Hotel o) {
		em.remove(em.contains(o) ? o : em.merge(o));
		return true;
	}

	@Override
	public Hotel update(Hotel o) {
		em.merge(o);
		return null;
	}

	@Override
	public Hotel findById(int id) {
		// TODO Auto-generated method stub
		return em.find(Hotel.class, id);
	}

	@Override
	public List<Hotel> findAll() {
		Query query = em.createQuery("select h from Hotel h");
		return query.getResultList();
	}
	
	@Override
	public List<Hotel> findHotelsByVille(int id) {
		Query query = em.createQuery("SELECT h FROM Hotel h WHERE h.ville.id = :id");
		query.setParameter("id", id);
		return query.getResultList();
	}

}
