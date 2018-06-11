package packagename.business.boundary;

import javax.ejb.Stateless;

@Stateless
public class GreetingService {

    public String greet(String name) {
        return "hello " + name;
    }
}