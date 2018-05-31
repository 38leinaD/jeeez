package packagename.control;

import javax.enterprise.context.ApplicationScoped;
import javax.enterprise.context.Initialized;
import javax.enterprise.event.Observes;

@ApplicationScoped
public class TimeServer {

    public void init(@Observes @Initialized(ApplicationScoped.class) Object init) {
        System.out.println("++++ TIME SERVER STARTED ++++");
    }

    public long getTime() {
        return System.currentTimeMillis();
    }
    
}