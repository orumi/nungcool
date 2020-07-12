package com.nc.cool;


import java.io.*;
import java.util.*;

import com.nc.util.ServerUtil;

public class Config {
  Properties prop;
  String configFile;
  HashMap map;

  public Config(String s) {
    configFile = s;
  }

  public String getConfigFile(){
    return configFile;
  }

  public Properties getProperties(){
    return prop;
  }

  public String getProperty(String s){
    return prop.getProperty(s);
  }

  public String getProperty(String s, String s1){
    return prop.getProperty(s,s1);
  }

  public void removeProperty(String s){
    prop.remove(s);
  }

  public void insertProperty(String s, String s1, String s2){
    if(prop.getProperty(s1)!= null)
      //Log.warn("Config.insertProperty","Property"+s1+"already exists");
      if(s != null)
        map.put(s,s1);
      prop.setProperty(s1,s2);
  }

  public void load() throws IOException{
    load(configFile);
  }

  public void load(String s) throws IOException{
    prop = new Properties();
    File file = ServerUtil.getFile(s);
    FileInputStream fileInputStream = new FileInputStream(file);
    prop.load(fileInputStream);
    fileInputStream.close();
    configFile = s;
    map = new HashMap();
  }

  public void save() throws IOException{
    save(configFile);
  }

  public void save(StringBuffer stringBuffer, String s, String s1){
    stringBuffer.append(s);
    stringBuffer.append('=');
    s1 = ServerUtil.writeString(s1);
    s1 = s1.substring(1,s1.length()-1);
    stringBuffer.append(s1);
  }

  public void save(String s) throws IOException{
    File file = ServerUtil.getFile(s);
    HashMap hashMap = new HashMap();
    Properties properties = new Properties(prop);
    StringBuffer stringBuffer = new StringBuffer();
    String s2 = System.getProperty("line.separator");
    if(file.exists()){
      BufferedReader bufferedReader = new BufferedReader(new FileReader(file));
      String s1;
      while((s1 = bufferedReader.readLine()) != null){
        s1 = s1.trim();
        try {
          if (s1.length()>0 && s1.charAt(0) != '#') {
            String s3 = s1.substring(0,s1.indexOf('=')).trim();
            String s5 = properties.getProperty(s3);
            if(s5 != null)
              save(stringBuffer, s3, s5);
              hashMap.put(s3,s3);
              while((s3 = (String)map.get(s3)) != null){
                stringBuffer.append(s2);
                String s6 = properties.getProperty(s3);
                save(stringBuffer,s3,s6);
                hashMap.put(s3,s3);
              }
          } else {
            stringBuffer.append(s1);
          }
          stringBuffer.append(s2);
        } catch (RuntimeException ex) {
          //Log.info("Config.save","Line:"+s1);
          throw ex;
        }
      }
      bufferedReader.close();
    }
    for (Enumeration enumeration = properties.propertyNames();enumeration.hasMoreElements();) {
      String s4 = (String)enumeration.nextElement();
      if(!hashMap.containsKey(s4)){
        String s7 = properties.getProperty(s4);
        save(stringBuffer, s4, s7);
        stringBuffer.append(s2);
      }
    }

    FileWriter fileWriter = new FileWriter(file);
    fileWriter.write(stringBuffer.toString());
    fileWriter.close();
    configFile = s;

  }































}
