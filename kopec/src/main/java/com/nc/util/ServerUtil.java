package com.nc.util;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.io.*;
import java.text.*;
import java.util.*;


public class ServerUtil {
	public static SimpleDateFormat dateFormat;
	private static char hexDigit[]={
			'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};
 
	public ServerUtil(){

	}

	public static int decodeColor(String str, int i){
		int j;
		try {
			j = str!= null?Integer.decode(str).intValue():i;
		} catch (Exception e) {
			j = i;
		}
		return j;
	}

	public static String encodeColor(int i){
		String str;
		for(str = Integer.toHexString(0xffffff & i).toUpperCase();str.length()<6;str='0'+str);
		return "#"+str;
	}

	public static String getString(ResultSet resultSet, int i)throws SQLException{
		try {
			return resultSet.getString(i);
		} catch (SQLException e) {
			return null;
		}
	}

	public static Object getObject(ResultSet resultSet, int i)throws SQLException{
		try {
			return resultSet.getObject(i);
		} catch (SQLException e) {
			return null;
		}
	}
	
	public static String getString(ResultSet resultset, String key){
		try{
			return resultset.getString(key).trim();
		} catch (SQLException se){
			return "";
		} catch (Exception e){
			return "";
		}
	}

	public static double getDouble(ResultSet rs, String key){
		try {
			return rs.getDouble(key);
		} catch (SQLException e) {
			return 0;
		} catch (Exception e){
			return 0;
		}
	}

	public static boolean isEmptyRow(String as[], boolean flag){
		int i = as.length;
		for (int j = 0; j < i; j++) {
			String s = as[j];
			if(flag)
				s = s.trim();
			if(s.length()>0)
				return false;
			as[j] = s;
		}
		return true;
	}

	public static String[] toStringArray(ArrayList arrayList){
		if(arrayList == null)
			return null;
		int i = arrayList.size();
		String as[] = new String[i];
		for (int j = 0; j < i; j++) {
			as[j] = (String)arrayList.get(j);
		}

		return as;
	}

	public static int getType(String s) throws Exception{
        if(s.equals("INTEGER"))
            return 4;
        if(s.equals("STRING"))
            return 12;
        if(s.equals("DATE"))
            return 91;
        if(s.equals("TIMESTAMP"))
            return 93;
        if(s.equals("DOUBLE"))
            return 8;
        if(s.equals("AUTONUMBER"))
            return -999;
        if(s.equals("LONGSTRING"))
            return -1;
        if(s.equals("LINK"))
            return 0xf00003;
        else
            throw new Exception(s + " is not a recognised type.");
	}


	public static int getMeasurePeriodFrequency(String s) throws Exception{
		if(s==null)
			throw new Exception("Frequency value is null");
		s = s.toUpperCase();
		if(s.equals("일"))    //if(s.equals("DAILY"))
			return 1;
		if(s.equals("주"))    //if(s.equals("WEEKLY"))
			return 2;
		if(s.equals("월별"))         //if(s.equals("MONTHLY"))
			return 3;
		if(s.equals("분기별"))     //if(s.equals("QUARTERLY"))
			return 4;
		if(s.equals("반기별"))       //if(s.equals("SEMESTER"))
			return 5;
		return !s.equals("년도별")?-1:6;     //return !s.equals("YEARLY")?-1:6;
	}


    public static String escapeHTML(String s) {
        StringBuffer stringbuffer = new StringBuffer();
        int i = s.length();
        for(int j = 0; j < i; j++) {
            char c = s.charAt(j);
            switch(c) {
            case 60: // '<'
                stringbuffer.append("&lt;");
                break;

            case 62: // '>'
                stringbuffer.append("&gt;");
                break;

            case 38: // '&'
                stringbuffer.append("&amp;");
                break;

            case 32: // ' '
                stringbuffer.append("&nbsp;");
                break;

            default:
                stringbuffer.append(c);
                break;
            }
        }

        return stringbuffer.toString();
    }

  

     public static void writeShortcut(DataOutputStream dataoutputstream, int i, int j, String s, String s1, String s2, String s3) throws IOException {
         dataoutputstream.writeInt(i);
         dataoutputstream.writeInt(j);
         dataoutputstream.writeUTF(s != null ? s : "");
         dataoutputstream.writeUTF(s1 != null ? s1 : "");
         boolean flag = s3 != null && s3.length() != 0;
         dataoutputstream.writeBoolean(flag);
         if(flag)
             dataoutputstream.writeUTF(s3);
         boolean flag1 = s2 != null && s2.length() != 0;
         dataoutputstream.writeBoolean(flag1);
         if(flag1)
             dataoutputstream.writeUTF(s2);
     }

 

    public static String parseVar(String s, Map map)  {
        StringBuffer stringbuffer = new StringBuffer();
        boolean flag = false;
        int j = -1;
        do   {
            int i = s.indexOf('%', j + 1);
            if(i < 0)
            {
                stringbuffer.append(s.substring(j + 1));
                break;
            }
            stringbuffer.append(s.substring(j + 1, i));
            j = s.indexOf('%', i + 1);
            if(j < 0) {
                //Log.error("ServerUtil.parseVar", "Unexpected end in environment string: " + s);
                break;
            }
            if(i + 1 == j)  {
                stringbuffer.append('%');
            } else {
                String s1 = s.substring(i + 1, j);
                Object obj = map.get(s1);
                if(obj == null) {
                    //Log.error("ServerUtil.parseVar", "Environment string not found: " + s1);
                    return null;
                }
                stringbuffer.append(obj);
            }
        } while(true);
        return stringbuffer.toString();
    }

    public static ArrayList getParameters(String s){
        boolean flag = false;
        int j = -1;
        ArrayList arraylist = new ArrayList();
        do {
            int i = s.indexOf('%', j + 1);
            if(i < 0)
                break;
            j = s.indexOf('%', i + 1);
            if(j < 0)
                break;
            if(i + 1 != j) {
                String s1 = s.substring(i + 1, j);
                arraylist.add(s1);
            }
        } while(true);
        return arraylist;
    }

    public static File getFile(String s, String s1){
        return getFile(s + File.separator + s1);
    }

    public static File getFile(String s){
        File file = new File(s);
        if(!file.isAbsolute()){
            if(ServerStatic.WEB_INF == null)
                return null;
            file = new File(ServerStatic.WEB_INF, s);
        }
        return file;
    }

    public static String[] getFiles(File file, final String suffix){
        return file.list(new FilenameFilter() {

            public boolean accept(File file1, String s){
                return s.endsWith(suffix);
            }

        });
    }
    
    public static String[] getFiles(String s){
    	File file = getFile(s);
    	return file.list();
    }

    public static Properties getProperties(String s){
        Properties properties = null;
        try{
            FileInputStream fileinputstream = new FileInputStream(getFile(s));
            properties = new Properties();
            properties.load(fileinputstream);
            fileinputstream.close();
        }catch(Exception exception){
            //Log.error("ServerUtil.getProperties", "Can't read file " + s, exception);
        }
        return properties;
    }

    public static String getFileContent(String s)
        throws IOException{
        return getFileContent(s, false);
    }

    public static String getFileContent(String s, boolean flag)
        throws IOException{
        File file = getFile(s);
        if(flag){
            DataInputStream datainputstream = new DataInputStream(new FileInputStream(file));
            String s1 = datainputstream.readUTF();
            datainputstream.close();
            return s1;
        }
        BufferedReader bufferedreader = new BufferedReader(new FileReader(file));
        StringBuffer stringbuffer = new StringBuffer();
        String s3 = System.getProperty("line.separator");
        String s2;
        while((s2 = bufferedreader.readLine()) != null){
            stringbuffer.append(s2);
            stringbuffer.append(s3);
        }
        bufferedreader.close();
        return stringbuffer.toString();
    }

    public static boolean saveFileContent(String s, String s1, boolean flag){
        try{
            File file = getFile(s);
            if(flag){
                DataOutputStream dataoutputstream = new DataOutputStream(new FileOutputStream(file));
                dataoutputstream.writeUTF(s1);
                dataoutputstream.close();
            } else{
                FileWriter filewriter = new FileWriter(file);
                filewriter.write(s1, 0, s1.length());
                filewriter.close();
            }
        }
        catch(Exception exception){
            //Log.error("ServerUtil.saveFileContent", "Error writing file " + s, exception);
            return false;
        }
        return true;
    }

  
    public static String readString(String s) throws Exception{
        if(s == null)
            return null;
        s = s.trim();
        StringBuffer stringbuffer = new StringBuffer();
        int i = s.length() - 1;
        if(s.charAt(0) != '"')
            throw new Exception("String must begin with a quote (\"): " + s);
        for(int j = 1; j < i; j++){
            char c = s.charAt(j);
            if(c == '\\'){
                c = s.charAt(++j);
                switch(c){
                case 110: // 'n'
                    c = '\n';
                    break;

                case 114: // 'r'
                    c = '\r';
                    break;

                case 116: // 't'
                    c = '\t';
                    break;

                case 98: // 'b'
                    c = '\b';
                    break;

                case 39: // '\''
                    c = '\'';
                    break;

                case 34: // '"'
                    c = '"';
                    break;

                case 117: // 'u'
                    c = (char)Integer.parseInt(s.substring(j + 1, j + 5), 16);
                    j += 4;
                    break;

                default:
                    throw new Exception("Unrecognised escape command (\\" + c + ") : " + s);
                }
            }
            stringbuffer.append(c);
        }

        if(s.charAt(i) != '"')
            throw new Exception("String must end with a quote (\"): " + s);
        else
            return stringbuffer.toString();
    }

    public static void readCSVRow(String s, ArrayList arraylist){
        if(s == null)
            return;
        int i = s.length();
        int j = 0;
        for(int k = 0; j < i; k++){
            char c = s.charAt(j++);
            if(c == ','){
                arraylist.add("");
            } else{
                StringBuffer stringbuffer = new StringBuffer();
                boolean flag;
                if(!(flag = c == '"'))
                    stringbuffer.append(c);
                while(j < i){
                    char c1 = s.charAt(j++);
                    if(!flag && c1 == ',' || c1 == '"' && (j == i || s.charAt(j++) != '"'))
                        break;
                    stringbuffer.append(c1);
                }
                arraylist.add(stringbuffer.toString());
            }
        }

    }

    public static String writeCSVRow(Object aobj[]){
        if(aobj == null)
            return null;
        StringBuffer stringbuffer = new StringBuffer();
        int i = aobj.length;
        for(int j = 0; j < i; j++){
            String s = (String)aobj[j];
            boolean flag = s.indexOf('"') >= 0 || s.indexOf(',') >= 0;
            if(j > 0)
                stringbuffer.append(',');
            if(flag)
                stringbuffer.append('"');
            int k = s.length();
            for(int l = 0; l < k; l++){
                char c = s.charAt(l);
                if(c == '"')
                    stringbuffer.append(c);
                stringbuffer.append(c);
            }

            if(flag)
                stringbuffer.append('"');
        }

        return stringbuffer.toString();
    }

    private static char toHex(int i){
        return hexDigit[i & 0xf];
    }

    public static String writeString(String s){
        return writeString(s, true);
    }

    public static String writeString(String s, boolean flag){
        if(s == null)
            return null;
        int i = s.length();
        StringBuffer stringbuffer = new StringBuffer();
        stringbuffer.append("\"");
        for(int j = 0; j < i; j++){
            char c = s.charAt(j);
            switch(c){
            case 92: // '\\'
                stringbuffer.append('\\');
                stringbuffer.append('\\');
                break;

            case 9: // '\t'
                stringbuffer.append('\\');
                stringbuffer.append('t');
                break;

            case 10: // '\n'
                stringbuffer.append('\\');
                stringbuffer.append('n');
                break;

            case 13: // '\r'
                stringbuffer.append('\\');
                stringbuffer.append('r');
                break;

            default:
                if(flag && (c < ' ' || c >= '\177')){
                    stringbuffer.append('\\');
                    stringbuffer.append('u');
                    stringbuffer.append(toHex(c >> 12 & 0xf));
                    stringbuffer.append(toHex(c >> 8 & 0xf));
                    stringbuffer.append(toHex(c >> 4 & 0xf));
                    stringbuffer.append(toHex(c >> 0 & 0xf));
                } else{
                    stringbuffer.append(c);
                }
                break;
            }
        }

        stringbuffer.append("\"");
        return stringbuffer.toString();
    }

    public static Properties loadFields(InputStream inputstream)
        throws IOException{
        Properties properties = new Properties();
        BufferedReader bufferedreader = new BufferedReader(new InputStreamReader(inputstream));
        String s;
        while((s = bufferedreader.readLine()) != null){
            s = s.trim();
            if(s.length() > 0 && s.charAt(0) != '#')
            {
                int i = s.indexOf('=');
                if(i > 0)
                {
                    String s1 = s.substring(0, i).trim();
                    String s2 = s.substring(i + 1).trim();
                    properties.setProperty(s1, s2);
                }
            }
        }
        bufferedreader.close();
        return properties;
    }

    public static void deleteFile(File file){
        if(file.exists()){
            if(file.isDirectory()){
                File afile[] = file.listFiles();
                for(int i = 0; i < afile.length; i++)
                    deleteFile(afile[i]);

            }
            //Log.info("ServerUtil.deleteFile", "Deleting " + file.getAbsolutePath());
            file.delete();
        }
    }

    public static void mapFolder(File file, Hashtable hashtable, List list, String s){
        if(hashtable == null){
            hashtable = new Hashtable();
            list = new ArrayList();
        }
        if(file.exists()){
            File afile[] = file.listFiles();
            for(int i = 0; i < afile.length; i++){
                File file1 = afile[i];
                String s1 = afile[i].getAbsolutePath();
                String s2 = s1.substring(s1.lastIndexOf(s) + s.length());
                if(file1.isDirectory()){
                    hashtable.put(s2 + "/", afile[i]);
                    list.add(s2 + "/");
                    mapFolder(afile[i], hashtable, list, s);
                } else{
                    hashtable.put(s2, afile[i]);
                    list.add(s2);
                }
            }

        }
    }

    public static void copyFolder(File file, String s)
        throws IOException{
        //Log.info("ServerUtil.copyFolder", "Copying " + file + " to " + s);
        if(file.exists()){
            File afile[] = file.listFiles();
            for(int i = 0; i < afile.length; i++){
                File file1 = afile[i];
                if(file1.isDirectory())
                    copyFolder(afile[i], s + File.separator + file1.getName());
                else
                    copyFile(file1.getAbsolutePath(), s + File.separator + file1.getName());
            }

        }
    }

    public static void copyFile(String s, String s1){
        try{
            BufferedInputStream bufferedinputstream = new BufferedInputStream(new FileInputStream(s));
            File file = getFile(s1);
            File file1 = file.getParentFile();
            if(!file1.exists())
                file1.mkdirs();
            BufferedOutputStream bufferedoutputstream = new BufferedOutputStream(new FileOutputStream(s1));
            int i;
            while((i = bufferedinputstream.read()) != -1)
                bufferedoutputstream.write(i);
            bufferedinputstream.close();
            bufferedoutputstream.close();
        }catch(IOException ioexception){
            //Log.error("ServerUtil.copyFile", "Copying " + s + " to " + s1, ioexception);
        }
    }

	public static String getColor(double dbl) { 
		try{
			if (dbl >= ServerStatic.HIGH) return ServerStatic.COLOR01;
			else if(dbl >= ServerStatic.LOW) return ServerStatic.COLOR02;
			else if (dbl>= ServerStatic.LOWER) return ServerStatic.COLOR03;
			else return ServerStatic.DEFAULTCOLOR;
		} catch (Exception e){
			System.out.println("ScoreMapUtil getColor : "+e);
		}
		return null;
	}
    //public static void writeDouble(DataOutputStream out, ResultSet rs, String key) throws SQLException{
    	//out.writeBoolean(rs.getDouble(key)!= null);
    //}

}
