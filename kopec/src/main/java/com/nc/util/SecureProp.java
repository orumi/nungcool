
package com.nc.util;


import java.net.URLDecoder;
import java.net.URLEncoder;
import java.security.MessageDigest;
import java.util.*;

public class SecureProp extends Properties
{
    public static final int NUMERIC_ALPHA = 1;
    public static final int ALL_ALPHA_UPPER = 2;
    private static final char UHEX_START = 65;
    private static final char LHEX_START = 97;
    long seed;
    public static Random random;


    public SecureProp(long l) 
    {
        seed = l;
    }

    public SecureProp(String s, long l)
        throws IllegalArgumentException
    {
        seed = l;
        decryptProperties(s);
    }

    public String getEncryptedString()
    {
        Enumeration enumeration = propertyNames();
        StringBuffer stringbuffer = new StringBuffer();
        for(boolean flag = false; enumeration.hasMoreElements(); flag = true)
        {
            String s = (String)enumeration.nextElement();
            String s2 = getProperty(s);
            if(flag)
                stringbuffer.append("&");
            stringbuffer.append(URLEncoder.encode(s));
            stringbuffer.append("=");
            stringbuffer.append(URLEncoder.encode(s2));
        }

        String s1 = getDigest(stringbuffer.toString());
        stringbuffer.append("&");
        stringbuffer.append(s1);
        return encrypt(2, getBytes(stringbuffer.toString()), seed);
    }

    void decryptProperties(String s)
        throws IllegalArgumentException
    {
        String s1 = getString(decrypt(2, s, seed));
        int i = s1.lastIndexOf(38);
        if(i < 0)
            throw new IllegalArgumentException("Invalid encrypted key");
        String s2 = s1.substring(i + 1);
        s1 = s1.substring(0, i);
        String s3 = getDigest(s1);
        if(!s2.equals(s3))
            throw new IllegalArgumentException("Invalid encrypted key");
        int k = s1.length();
        int l = 0;
        try
        {
            while(l < k) 
            {
                int i1 = s1.indexOf(61, l);
                int j = s1.indexOf("&", i1);
                if(j < 0)
                    j = k;
                String s4 = s1.substring(l, i1);
                String s5 = s1.substring(i1 + 1, j);
                setProperty(URLDecoder.decode(s4), URLDecoder.decode(s5));
                l = j + 1;
            }
        }
        catch(Exception exception)
        {
            throw new IllegalArgumentException(exception.getMessage());
        }
    }

    public static String encrypt(int i, byte abyte0[], long l)
    {
        byte abyte1[] = new byte[abyte0.length];
        Random random1 = new Random(l);
        random1.nextBytes(abyte1);
        for(int j = 0; j < abyte0.length; j++)
            abyte0[j] ^= abyte1[j];

        return toAlphaNumeric(i, abyte0);
    }

    public static byte[] decrypt(int i, String s, long l)
    {
        byte abyte0[] = fromAlphaNumeric(i, s);
        byte abyte1[] = new byte[abyte0.length];
        Random random1 = new Random(l);
        random1.nextBytes(abyte1);
        for(int j = 0; j < abyte0.length; j++)
            abyte0[j] ^= abyte1[j];

        return abyte0;
    }

    public static String toAlphaNumeric(int i, byte abyte0[])
    {
        byte abyte1[] = new byte[abyte0.length * 2];
        for(int j = 0; j < abyte0.length; j++)
        {
            abyte1[2 * j] = hex2Ascii(i, abyte0[j] & 0xf);
            abyte1[2 * j + 1] = hex2Ascii(i, (abyte0[j] & 0xf0) >>> 4);
        }

        return getString(abyte1);
    }

    public static byte[] fromAlphaNumeric(int i, String s)
    {
        byte abyte0[] = getBytes(s);
        byte abyte1[] = new byte[abyte0.length / 2];
        for(int j = 0; j < abyte1.length; j++)
        {
            byte byte0 = ascii2Hex(i, abyte0[2 * j]);
            byte byte1 = ascii2Hex(i, abyte0[2 * j + 1]);
            abyte1[j] = (byte)(byte0 | (byte)(byte1 << 4));
        }

        return abyte1;
    }

    public static byte[] getBytes(String s)
    {
        byte abyte0[] = null;
        abyte0 = new byte[s.length()];
        for(int i = 0; i < s.length(); i++)
            abyte0[i] = (byte)s.charAt(i);

        return abyte0;
    }

    public static String getString(byte abyte0[])
    {
        Object obj = null;
        char ac[] = new char[abyte0.length];
        for(int i = 0; i < abyte0.length; i++)
            ac[i] = (char)abyte0[i];

        return String.valueOf(ac);
    }

    public static byte hex2Ascii(int i, int j)
    {
        switch(i)
        {
        case 1: // '\001'
            return (byte)(j + (j >= 10 ? 87 : 48));
        }
        return (byte)(j + 65);
    }

    public static byte ascii2Hex(int i, byte byte0)
    {
        switch(i)
        {
        case 1: // '\001'
            if(byte0 >= 48 && byte0 <= 57)
                return (byte)(byte0 - 48);
            else
                return (byte)((byte0 - 97) + 10);
        }
        return (byte)(byte0 - 65);
    }

    public static synchronized String getRandomString(int i)
    {
        if(random == null)
            random = new Random();
        byte abyte0[] = new byte[i / 2];
        random.nextBytes(abyte0);
        return toAlphaNumeric(2, abyte0);
    }

    //비밀번호 s를 입력받아 이를 암호화시킨 값을 리턴받음.
    public static String getDigest(String s)
    {
        try
        {
            MessageDigest messagedigest = MessageDigest.getInstance("SHA");
            byte abyte0[] = messagedigest.digest(s.getBytes());
            return toAlphaNumeric(2, abyte0);
        }
        catch(Exception exception)
        {
            //Log.info("SecureProp.getDigest", "Couldn't create digest.", exception);
        }
        return s;
    }

}