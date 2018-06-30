package packagename.business.health.boundary;

import org.hamcrest.CoreMatchers;
import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;

import static org.junit.Assert.assertThat;

public class HealthServiceTest {

    @Test
    public void should_be_healthy() {
        HealthService cut = new HealthService();
        assertThat(cut.isHealthy(), CoreMatchers.is(true));
    }
}