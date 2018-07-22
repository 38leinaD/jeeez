package packagename.business.batch.control;

import java.io.IOException;
import java.io.Serializable;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;
import java.util.Properties;
import java.util.LinkedList;

import javax.batch.api.chunk.AbstractItemReader;
import javax.batch.operations.JobOperator;
import javax.batch.runtime.BatchRuntime;
import javax.batch.runtime.context.JobContext;
import javax.inject.Inject;
import javax.inject.Named;

@Named
public class SimpleItemReader extends AbstractItemReader {

	@Inject
	private JobContext jobContext;

	private List<String> input = new LinkedList<>();
	private int lineNum;

	@Override
	public void open(Serializable checkpoint) throws Exception {
		JobOperator jobOperator = BatchRuntime.getJobOperator();
		Properties parameters = jobOperator.getParameters(jobContext.getExecutionId());
		String resourceName = parameters.getProperty("filename");
		System.out.println("+ JobProperties: " + jobContext.getExecutionId() + ", " + jobContext.getBatchStatus());
		System.out.println("+ File is: " + resourceName);

		input.add("1");
		input.add("2");
		input.add("3");
		input.add("4");
		input.add("5");
		input.add("6");
		input.add("7");
		
		System.out.println("+ Checkpoint: " + checkpoint);
		if (checkpoint != null) {
			lineNum = (int) checkpoint;
		}
	}

	@Override
	public Object readItem() throws Exception {
		if (lineNum >= input.size()) {
			System.out.println("+ No more data.");
			return null;
		}

		String line = input.get(lineNum++);
		System.out.println("+ Processing line: " + line);
		return line.toUpperCase();
	}

	@Override
	public Serializable checkpointInfo() throws Exception {
		System.out.println("+ Runtime asks for checkpoint: " + lineNum);
		return lineNum;
	}

}
