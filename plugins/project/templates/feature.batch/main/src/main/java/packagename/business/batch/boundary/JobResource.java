package packagename.business.batch.boundary;

import java.util.Properties;

import javax.batch.operations.JobOperator;
import javax.batch.runtime.BatchRuntime;
import javax.ejb.Stateless;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;

@Stateless
@Path("jobs")
public class JobResource {

	@POST
	public String startJob(String filename) {
		JobOperator jobOperator = BatchRuntime.getJobOperator();
		Properties props = new Properties();
		props.setProperty("filename", filename);
		return jobOperator.start("myjob", props) + "";
	}

	@GET
	@Path("{id}")
	public String getStatus(@PathParam("id") long id) {
		JobOperator jobOperator = BatchRuntime.getJobOperator();
		return jobOperator.getJobExecution(id).getBatchStatus().name();
	}
}
