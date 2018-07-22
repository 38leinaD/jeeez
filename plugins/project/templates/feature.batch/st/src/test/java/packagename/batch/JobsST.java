package packagename.batch;

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
public class JobsST {

    WebTarget tut;

    @Before
    public void init() {
        String httpPort = System.getenv("APPSVR_HTTP_PORT") != null ? System.getenv("APPSVR_HTTP_PORT") : "80";
        tut = ClientBuilder.newClient().target("http://localhost:" + httpPort + "/template-artifactid");
    }

    @Test
    public void testJobs() throws Exception {


        Response response = tut.path("resources/jobs").request().post(Entity.text("myfile.txt"));
        String jobId = response.readEntity(String.class);
        assertThat(response.getStatus(), CoreMatchers.is(200));
        
        Response queryResponse = tut.path("resources/jobs/" + jobId).request().get();
        assertThat(queryResponse.getStatus(), CoreMatchers.is(200));
        String status = queryResponse.readEntity(String.class);
        assertThat(status, CoreMatchers.is("STARTED"));
    }
}