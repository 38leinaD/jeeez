package packagename.control;

import javax.ejb.Stateless;
import javax.inject.Inject;

@Stateless
public class HelloService {

    @Inject
    TimeServer time;

    public String hello() {
        return "hello @" + time.getTime();
    }
    
}