package com.nc.admin;

import java.io.FileInputStream;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Properties;

import com.nc.util.*;

// 각 데이타 베이스별 sql를 생성해 주는 객체..
public class QueryMaker {

    String dbName;
    boolean caseSensitive;
    char quoteChar;
    char quoteEsc;
    String type_null;
    String type_integer;
    String type_integer_null;
    String type_double;
    String type_double_null;
    String type_string;
    String type_string_null;
    String type_longstring;
    String type_longstring_null;
    String type_date;
    String type_date_null;
    String type_time;
    String type_time_null;
    String type_autonumber;
    String listStart;
    String listEnd;
    String listSep;
    boolean useCVCounter;
    boolean useIdentity;
    boolean useCounter;
    boolean manualCounterCreate;
    boolean useSchema;
    boolean useCatalog;
    boolean useFetchSize;
    DateFormat dateFormat;
    DateFormat timeFormat;
    Properties prop;
	public ArrayList tableList;

	public void log(String s){System.out.println(s);}

	public QueryMaker(String dbName){
		this.dbName = dbName;
	}

	public String getDatabaseName(){
		return dbName;
	}

	public String getProperty(String str){
		return prop.getProperty(str);
	}

	public String getProperty(String str1, String str2){
		return prop.getProperty(str1, str2);
	}

	public void init(String s){
		try {
                    prop = ServerUtil.loadFields(new FileInputStream(ServerUtil.getFile(s)));
                    quoteChar = getProperty("STRING.QUOTE").charAt(0);
                    quoteEsc = getProperty("STRING.ESCAPE").charAt(0);
                    caseSensitive = "true".equals(getProperty("STRING.CASE_SENSITIVE"));
                    useSchema = "true".equals(getProperty("USE_SCHEMA"));
                    useCatalog = "true".equals(getProperty("USE_CATALOG"));
                    useFetchSize = "true".equals(getProperty("USE_FETCH_SIZE", "true"));
                    useIdentity = prop.containsKey("SQL.GET_IDENTITY");
                    type_null = getProperty("DATA.NULL", "NULL");
                    type_autonumber = getProperty("DATA.AUTONUMBER");
                    //if(type_autonumber == null)
                        //Log.error("SQLProducer.init", "Missing DATA.AUTONUMBER");
                    type_integer = getProperty("DATA.INTEGER");
                    type_integer_null = getProperty("DATA.INTEGER.NULL", type_null);
                    //if(type_integer == null)
                        //Log.error("SQLProducer.init", "Missing DATA.INTEGER");
                    type_double = getProperty("DATA.DOUBLE");
                    type_double_null = getProperty("DATA.DOUBLE.NULL", type_null);
                    //if(type_double == null)
                       // Log.error("SQLProducer.init", "Missing DATA.DOUBLE");
                    type_date = getProperty("DATA.DATE");
                    type_date_null = getProperty("DATA.DATE.NULL", type_null);
                    //if(type_date == null)
                        //Log.error("SQLProducer.init", "Missing DATA.DATE");
                    type_time = getProperty("DATA.TIMESTAMP");
                    type_time_null = getProperty("DATA.TIMESTAMP.NULL", type_null);
                    //if(type_time == null)
                        //Log.error("SQLProducer.init", "Missing DATA.TIMESTAMP");
                    type_string = getProperty("DATA.STRING");
                    type_string_null = getProperty("DATA.STRING.NULL", type_null);
                    //if(type_string == null)
                        //Log.error("SQLProducer.init", "Missing DATA.STRING");
                    type_longstring = getProperty("DATA.LONGSTRING");
                    type_longstring_null = getProperty("DATA.LONGSTRING.NULL", type_null);
                    if(type_longstring == null)
                    {
                        //Log.info("SQLProducer.init", "Default DATA.LONGSTRING to DATA.STRING");
                        type_longstring = type_string;
                        type_longstring_null = type_string_null;
                    }
                    useCounter = "true".equals(getProperty("DATA.AUTONUMBER.USE_COUNTER"));
                    useCVCounter = "CVCOUNTER".equals(getProperty("COUNTER"));
                    manualCounterCreate = useCounter && "true".equals(getProperty("DATA.AUTONUMBER.CREATE_COUNTER", "true"));
                    dateFormat = Util.getDateFormat(getProperty("DATA.DATE.FORMAT"));
                    timeFormat = Util.getDateFormat(getProperty("DATA.TIMESTAMP.FORMAT"));
                    listStart = getProperty("LIST.START");
                    listEnd = getProperty("LIST.END");
                    listSep = getProperty("LIST.SEPARATOR");
		} catch (Exception e) {
			//Log.error("SQLProducer.init", "Failed to initialise", e);
		}
	}

	public boolean userIdCounter(){
		return useCounter;
	}

	public boolean manuallyCreateCounter(){
		return manualCounterCreate;
	}

	public boolean useCVCounter(){
		return useCVCounter;
	}

	public boolean suppertsIdentity(){
		return useIdentity;
	}

	public String getIdentity(String s){
		return buildSQL("SQL.GET_IDENTITY",new String[]{s});
	}

	public String getCounterSQL(String s){
		return buildSQL("SQL.CHECK_COUNTER",new String[]{s});
	}

	public boolean isCaseSensitive(){
		return caseSensitive;
	}

	public boolean useSchema(){
		return useSchema;
	}

	public boolean useCatalog(){
		return useCatalog;
	}

	public boolean useFetchSize(){
		return useFetchSize;
	}

	public String getJDBCDriver(){
		return getProperty("JDBC.DRIVER");
	}

	public String getJDBCURL(){
		return getProperty("JDBC.URL");
	}

	public ArrayList getJDBCParameters(){
		return ServerUtil.getParameters(getProperty("JDBC.URL"));
	}

	public String toUpperCase(String s){
		return buildSQL("FUNC.UPPER_CASE",new String[]{s});
	}

	public String addField(String s, String s1, int i){
		String s2 = getProperty("DATA.STRING.DEFSIZE");
		if(s2 != null && i == 12)
			return addField(s,s1,i,Integer.parseInt(s2));
		else
			return buildSQL("SQLADD_FIELD",new String[]{s,s1,getType(i)});
	}

	public String addField(String s, String s1, int i, int j){
		return buildSQL("SQL.ADD_FIELD",new String[]{s,s1,getType(i)+"("+j+")"});
	}

	public String dropField(String s, String s1){
		return buildSQL("SQL.DROP_FIELD",new String[]{s,s1});
	}

	public String modifyField(String s, String s1, int i, int j){
		return buildSQL("SQL.Mod_FIELD",new String[]{s,s1,getType(i)+"("+j+")"});
	}

	public String renameField(String s, String s1, String s2){
		return buildSQL("SQL.RENAME_FIELD",new String[]{s,s1,s2});
	}

	public String addView(String s, String s1){
		return buildSQL("SQL.ADD_VIEW", new String[]{s,s1});
	}

	public String dropView(String s){
		return buildSQL("SQL.DROP_VIEW", new String[]{s});
	}

	public String insertBasic(String s, String s1, String s2){
		return buildSQL("SQL.INSERT", new String[]{s,s1,s2});
	}


    public String createIdCounter(String s){
        return buildSQL("SQL.CREATE_ID_COUNT", new String[] {
            s
        });
    }

    public String dropIdCounter(String s){
        return buildSQL("SQL.DROP_ID_COUNT", new String[] {
            s
        });
    }

    public String addConstraint(String s, String s1, String s2, String s3, String s4){
        return buildSQL("SQL.ADD_CONSTRAINT", new String[] {
            s, s1, s2, s3, s4
        });
    }

    public String createTable(String s, String s1){
        return buildSQL("CREATE_TABLE", new String[] {
            s, s1
        });
    }

    public String createTableField(String s, int i, String s1){
        return buildSQL("CREATE_TABLE.FIELD", new String[] {
            s, getType(i), s1
        });
    }

    public String createTableField(String s, int i, int j, String s1){
        return buildSQL("CREATE_TABLE.FIELD", new String[] {
            s, getType(i) + "(" + j + ")", s1
        });
    }

    public String createTableForeign(String s, String s1, String s2){
        return buildSQL("CREATE_TABLE.FOREIGN", new String[] {
            s, s1, s2
        });
    }

    public String createTablePrimary(String s){
        return buildSQL("CREATE_TABLE.PRIMARY", new String[] {
            s
        });
    }

    public String createTable(Table table){
        return table.createSQL;
    }

    public String dropTable(String s){
        return buildSQL("SQL.DROP_TABLE", new String[] {
            s
        });
    }

    public String emptyTable(String s){
        return buildSQL("SQL.EMPTY_TABLE", new String[] {
            s
        });
    }

    public String buildSQL(String s, String as[]){
        String s1 = getProperty(s);
        if(s1 == null){
            //Log.info("SQLProducer.buildSQL", "No SQL defined for " + s);
            return "";
        } else{
            return Util.parseVar(s1, as);
        }
    }

    public boolean isCompatibleType(int i, int j){
        switch(i){
        case -999:
        case 4: // '\004'
            return j == 4 || j == 2 || j == 3;

        case 8: // '\b'
            return j == 8 || j == 6 || j == 7 || j == 2 || j == 3;

        case -1:
        case 12: // '\f'
            return j == 12 || j == -1;

        case 91: // '['
        case 93: // ']'
            return j == 91 || j == 92 || j == 93;
        }
        return false;
        //throw new InternalRSCException("Type not recognised " + i);
    }

    public String getType(int i){
        switch(i){
        case -999:
            return type_autonumber;

        case 4: // '\004'
            return type_integer;

        case 8: // '\b'
            return type_double;

        case -1:
            return type_longstring;

        case 12: // '\f'
            return type_string;

        case 91: // '['
            return type_date;

        case 93: // ']'
            return type_time;
        }
        return  "";
        //throw new InternalRSCException("Type not recognised " + i);
    }

    public String getSQLString(String s){
        if(s == null || s.length() == 0)
            return type_string_null;
        StringBuffer stringbuffer = new StringBuffer();
        int i = s.length();
        stringbuffer.append(quoteChar);
        for(int j = 0; j < i; j++){
            char c = s.charAt(j);
            if(c == quoteChar)
                stringbuffer.append(quoteEsc);
            stringbuffer.append(c);
        }

        stringbuffer.append(quoteChar);
        return stringbuffer.toString();
    }

    public synchronized String getSQLDate(Date date){
        if(date == null)
            return null;
        else
            return dateFormat.format(date);
    }

    public String getSQLDate(long l){
        return getSQLDate(new Date(l));
    }

    public String getSQLTime(Date date){
        if(date == null)
            return null;
        else
            return timeFormat.format(date);
    }

    public String getSQLTime(){
        return timeFormat.format(new Date());
    }

    public String toSQLList(Object obj){
        StringBuffer stringbuffer = new StringBuffer();
        int i = 0;
        byte byte0 = 0;
        if(obj instanceof Object[]){
            byte0 = 1;
            i = ((Object[])obj).length;
        } else if(obj instanceof int[]){
            byte0 = 2;
            i = ((int[])obj).length;
        } else if(obj instanceof double[]){
            byte0 = 3;
            i = ((double[])obj).length;
        } else {
            //throw new InternalRSCException("Cannot comvert list " + obj.getClass().getName());
        }
        stringbuffer.append(listStart);
        for(int j = 0; j < i; j++) {
            if(j > 0)
                stringbuffer.append(listSep);
            switch(byte0) {
            case 1: // '\001'
                stringbuffer.append(((Object[])obj)[j]);
                break;

            case 2: // '\002'
                stringbuffer.append(((int[])obj)[j]);
                break;

            case 3: // '\003'
                stringbuffer.append(((double[])obj)[j]);
                break;
            }
        }

        stringbuffer.append(listEnd);
        return stringbuffer.toString();
    }








































}
