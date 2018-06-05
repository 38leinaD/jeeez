package packagename.business.boundary;

import java.util.List;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import packagename.business.entity.Car;

@Stateless
@Path("cars")
public class CarsResource {

	@PersistenceContext
	EntityManager em;

	
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public List<Car> getAll() {
		List<Car> cars = em.createQuery("SELECT c FROM Car c", Car.class).getResultList();
		return cars;
	}
	
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public Car create(Car c) {
		em.persist(c);
		return c;
	}
	
	@GET
	@Path("{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public Car getById(@PathParam("id") Integer id) {
		return em.find(Car.class, id);
	}
	
	@PUT
	@Consumes(MediaType.APPLICATION_JSON)
	public void update(Car c) {
		em.merge(c);
	}
}
