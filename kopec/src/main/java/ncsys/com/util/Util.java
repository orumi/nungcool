package ncsys.com.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONException;
import net.sf.json.JSONObject;

public class Util {

	synchronized
    public static Map<String, Object> TOMAP(JSONObject jsonobj)  throws JSONException {
        Map<String, Object> map = new HashMap<String, Object>();
        Iterator<String> keys = jsonobj.keys();
        while(keys.hasNext()) {
            String key = keys.next();
            Object value = jsonobj.get(key);
            if (value instanceof JSONArray) {
                value = TOLIST((JSONArray) value);
            } else if (value instanceof JSONObject) {
                value = TOMAP((JSONObject) value);
            }
            map.put(key, value);
        }   return map;
    }

	synchronized
    public static List<Object> TOLIST(JSONArray array) throws JSONException {
        List<Object> list = new ArrayList<Object>();
        for(int i = 0; i < array.size(); i++) {
            Object value = array.get(i);
            if (value instanceof JSONArray) {
                value = TOLIST((JSONArray) value);
            }
            else if (value instanceof JSONObject) {
                value = TOMAP((JSONObject) value);
            }
            list.add(value);
        }   return list;
    }

}
