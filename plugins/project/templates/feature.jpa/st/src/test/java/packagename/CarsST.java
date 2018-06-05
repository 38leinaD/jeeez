package packagename;

import static org.junit.Assert.assertThat;

import javax.json.Json;
import javax.json.JsonObject;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.Entity;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.hamcrest.CoreMatchers;
import org.junit.Before;
import org.junit.Test;

/**
 * HelloIT
 */
public class CarsST {

    WebTarget tut;

    @Before
    public void init() {
        String httpPort = System.getenv("APPSVR_HTTP_PORT") != null ? System.getenv("APPSVR_HTTP_PORT") : "80";
        tut = ClientBuilder.newClient().target("http://localhost:" + httpPort + "/template-artifactid");
    }

    @Test
    public void testMe() {
        // Create
        JsonObject createdCar = Json.createObjectBuilder()
            .add("model", "tesla")
            .build();

        Response createResponse = tut.path("resources/cars").request(MediaType.APPLICATION_JSON).post(Entity.entity(createdCar, MediaType.APPLICATION_JSON));
        createdCar = createResponse.readEntity(JsonObject.class);
        assertThat(createResponse.getStatus(), CoreMatchers.is(200));

        // Query
        Response queryResponse = tut.path("resources/cars/" + createdCar.getInt("id")).request(MediaType.APPLICATION_JSON).get();
        assertThat(queryResponse.getStatus(), CoreMatchers.is(200));
        JsonObject queriedCar = queryResponse.readEntity(JsonObject.class);

        // Update
        JsonObject updatedCar = Json.createObjectBuilder()
            .add("id", createdCar.getInt("id"))
            .add("model", "tesla-x")
            .build();

        Response updateResponse = tut.path("resources/cars").request().put(Entity.entity(updatedCar, MediaType.APPLICATION_JSON));
        assertThat(updateResponse.getStatus(), CoreMatchers.is(204));
    }
}