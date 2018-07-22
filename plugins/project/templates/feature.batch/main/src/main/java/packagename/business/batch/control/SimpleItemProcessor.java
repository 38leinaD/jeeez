package packagename.business.batch.control;

import javax.batch.api.chunk.ItemProcessor;
import javax.batch.runtime.context.JobContext;
import javax.inject.Inject;
import javax.inject.Named;

@Named
public class SimpleItemProcessor implements ItemProcessor {

	@Inject
	JobContext jobContext;

	@Override
	public Object processItem(Object item) throws Exception {
		System.out.println("+ Process Item: " + item);
		Thread.sleep(5000);
		return "-" + ((String) item) + "-";
	}

}
