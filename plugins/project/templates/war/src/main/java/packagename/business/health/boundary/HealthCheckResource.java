package packagename.business.health.boundary;

import javax.ejb.Stateless;
import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;

@Stateless
@Path("health")
public class HealthCheckResource {

	@Inject
	HealthService healthService;

    // Call with "curl -i http://localhost/template-artifact/resources/healthcheck"
	@GET
	public String healthcheck() {
        System.out.println("+ HealthCheck @" + System.currentTimeMillis());
		return healthService.isHealthy() ? "UP" : "DOWN";
	}
}
