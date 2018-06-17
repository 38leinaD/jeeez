package packagename.business.boundary;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.net.URL;
import java.util.concurrent.TimeUnit;

import org.arquillian.container.chameleon.api.ChameleonTarget;
import org.arquillian.container.chameleon.deployment.file.File;
import org.arquillian.container.chameleon.runner.ArquillianChameleon;
import org.jboss.arquillian.container.test.api.RunAsClient;
import org.jboss.arquillian.drone.api.annotation.Drone;
import org.jboss.arquillian.test.api.ArquillianResource;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.openqa.selenium.WebDriver;

@RunWith(ArquillianChameleon.class)
@RunAsClient
@File("build/libs/template-artifactid.war")
@ChameleonTarget(value = "Wildfly:11.0.0.Final:managed", customProperties = {
    // Properties for wildfly:11.0.0.Final:remote
    //@Property(name = "port", value = "80"),
    //@Property(name = "username", value = "admin"),
    //@Property(name = "password", value = "admin")
})
public class GreetingServiceUIT {

	@Drone
	WebDriver browser;
	
	@ArquillianResource
    private URL deploymentUrl;
	
    @Test
    public void shouldGreetDuke() throws Exception {
    	browser.get(deploymentUrl.toString());
        String title = browser.getTitle();
        assertThat(title, is("hello world"));
    }
}