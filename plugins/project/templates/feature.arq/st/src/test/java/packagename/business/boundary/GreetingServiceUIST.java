package packagename.business.boundary;

import static org.hamcrest.CoreMatchers.startsWith;
import static org.junit.Assert.assertThat;

import org.jboss.arquillian.container.test.api.RunAsClient;
import org.jboss.arquillian.drone.api.annotation.Drone;
import org.jboss.arquillian.graphene.page.InitialPage;
import org.jboss.arquillian.junit.Arquillian;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.openqa.selenium.WebDriver;

@RunWith(Arquillian.class)
@RunAsClient
public class GreetingServiceUIST {

	@Drone
	WebDriver browser;
	
    @Test
    public void shouldGreetDuke(@InitialPage IndexPage index) throws Exception {
    	String greeting = index.greet("Daniel");
    	
        assertThat(greeting, startsWith("Hello Daniel @"));
    }
}