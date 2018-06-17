package packagename.presentation;

import java.io.Serializable;

import javax.enterprise.inject.Model;

@Model
public class Index implements Serializable {

	private static final long serialVersionUID = 1L;

	private String output = null;
	
	public Object clicked() {
		
		System.out.println("HELLO!!!");
		output = "Hello @" + System.currentTimeMillis();
		return null;
	}
	
	public String output() {
		return output;
	}
}
