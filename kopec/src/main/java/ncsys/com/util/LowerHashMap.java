package ncsys.com.util;

import java.io.Serializable;
import java.util.HashMap;

import org.springframework.jdbc.support.JdbcUtils;


public class LowerHashMap extends HashMap implements Serializable {
	private static final long serialVersionUID = -5416380944607994144L;

	@SuppressWarnings("unchecked")
	@Override
	public Object put(Object key, Object value){
		return super.put(JdbcUtils.convertUnderscoreNameToPropertyName((String) key), value);
	}

}
