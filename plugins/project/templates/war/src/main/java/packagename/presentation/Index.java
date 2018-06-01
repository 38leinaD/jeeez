package packagename.presentation;

import java.io.Serializable;

import javax.enterprise.inject.Model;

@Model
public class Index implements Serializable {

	private static final long serialVersionUID = 1L;

	public Object clicked() {
		
		System.out.println("HELLO!!!");
		return null;
	}
}
