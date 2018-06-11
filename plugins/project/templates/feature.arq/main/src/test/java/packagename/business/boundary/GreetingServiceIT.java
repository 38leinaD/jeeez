package packagename.business.boundary;

import javax.inject.Inject;

import org.arquillian.container.chameleon.api.ChameleonTarget;
import org.arquillian.container.chameleon.api.Property;
import org.arquillian.container.chameleon.deployment.file.File;
import org.arquillian.container.chameleon.runner.ArquillianChameleon;
import org.jboss.arquillian.container.test.api.Deployment;
import org.jboss.shrinkwrap.api.ShrinkWrap;
import org.jboss.shrinkwrap.api.spec.WebArchive;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;

@RunWith(ArquillianChameleon.class)
@File("build/libs/template-artifactid.war")
@ChameleonTarget(value = "Wildfly:11.0.0.Final:managed", customProperties = {
    // Properties for wildfly:11.0.0.Final:remote
    //@Property(name = "port", value = "80"),
    //@Property(name = "username", value = "admin"),
    //@Property(name = "password", value = "admin")
})
public class GreetingServiceIT {

    // @Deployment
    // public static WebArchive deployService() {
    //     return ShrinkWrap.create(WebArchive.class)
    //             .addClass(GreetingService.class);
    // }

    @Inject
    private GreetingService greetings;

    @Test
    public void shouldGreetDuke() throws Exception {
        Assert.assertEquals("hello duke", greetings.greet("duke"));
    }
}