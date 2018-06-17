package packagename.business.boundary;

import java.util.concurrent.TimeUnit;

import org.jboss.arquillian.graphene.Graphene;
import org.jboss.arquillian.graphene.page.Location;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;

@Location("http://localhost:80/template-artifactid/index.xhtml")
public class IndexPage {

	@FindBy
	WebElement input;
	
	@FindBy
	WebElement output;
	
	@FindBy(css = "input[type=submit]")
	WebElement button;
	
	public String greet(String inputText) throws InterruptedException {
		input.sendKeys(inputText);
		Graphene.guardHttp(button).click();
		return output.getText();
	}
}
