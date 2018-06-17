package packagename.presentation;

import java.io.Serializable;

import javax.enterprise.inject.Model;

@Model
public class Index implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String input1 = null;
	private String output = null;
	
	public Object clicked() {
		
		System.out.println("HELLO!!!");
		output = "Hello " + input1 + " @" + System.currentTimeMillis();
		return null;
	}
	
	public void setInput(String input) {
		System.out.println("SET TO : " + input);
		this.input1 = input;
	}

	public String getInput() {
		return input1;
	}

	public String getOutput() {
		return this.output;
	}
}
