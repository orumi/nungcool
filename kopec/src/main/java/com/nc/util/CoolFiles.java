package com.nc.util;

import java.io.IOException;
import java.util.*;

// Referenced classes of package com.jspsmart.upload:
//            File, SmartUpload

public class CoolFiles
{

    CoolFiles()
    {
        m_files = new Hashtable();
        m_counter = 0;
    }

    protected void addFile(CoolFile newFile)
    {
        if(newFile == null)
        {
            throw new IllegalArgumentException("newFile cannot be null.");
        } else
        {
            m_files.put(new Integer(m_counter), newFile);
            m_counter++;
            return;
        }
    }

    public CoolFile getFile(int index)
    {
        if(index < 0)
            throw new IllegalArgumentException("File's index cannot be a negative value (1210).");
        CoolFile retval = (CoolFile)m_files.get(new Integer(index));
        if(retval == null)
            throw new IllegalArgumentException("Files' name is invalid or does not exist (1205).");
        else
            return retval;
    }

    public int getCount()
    {
        return m_counter;
    }

    public long getSize()
        throws IOException
    {
        long tmp = 0L;
        for(int i = 0; i < m_counter; i++)
            tmp += getFile(i).getSize();

        return tmp;
    }

    public Collection getCollection()
    {
        return m_files.values();
    }

    public Enumeration getEnumeration()
    {
        return m_files.elements();
    }

    private SmartUpload m_parent;
    private Hashtable m_files;
    private int m_counter;
}
