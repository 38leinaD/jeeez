package packagename;

import static org.junit.Assert.assertThat;

import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.Response;

import org.hamcrest.CoreMatchers;
import org.junit.Before;
import org.junit.Test;

/**
 * HelloIT
 */
public class HealthCheckST {

    WebTarget tut;

    @Before
    public void init() {
        tut = ClientBuilder.newClient().target("http://localhost/appname");
    }

    @Test
    public void testMe() {
        Response response = tut.path("resources/health")
            .request()
            .get();

        assertThat(response.getStatus(), CoreMatchers.is(200));
        assertThat(response.readEntity(String.class), CoreMatchers.startsWith("UP"));
    }
}