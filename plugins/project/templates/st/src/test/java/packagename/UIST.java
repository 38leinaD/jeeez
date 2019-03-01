package packagename;

import static org.junit.Assert.assertThat;

import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.Response;

import org.hamcrest.CoreMatchers;
import org.junit.Before;
import org.junit.Test;

import org.jboss.arquillian.drone.api.annotation.Drone;
import org.jboss.arquillian.junit.Arquillian;
import org.junit.runner.RunWith;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;

@RunWith(Arquillian.class)
public class UIST {

    @Drone
    WebDriver browser;

    @Test
    public void testMe() {
        String httpPort = System.getenv("APPSVR_HTTP_PORT") != null ? System.getenv("APPSVR_HTTP_PORT") : "80";
        browser.get("http://localhost:" + httpPort + "/template-artifactid/index.xhtml");
    }
}