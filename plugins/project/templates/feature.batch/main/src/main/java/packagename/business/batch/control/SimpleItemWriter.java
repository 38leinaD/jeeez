package packagename.business.batch.control;

import java.util.List;

import javax.batch.api.chunk.AbstractItemWriter;
import javax.inject.Named;

@Named
public class SimpleItemWriter extends AbstractItemWriter {

	@Override
	public void writeItems(List<Object> items) throws Exception {
		System.out.println("+ Write Items: " + items.size());
	}

}
