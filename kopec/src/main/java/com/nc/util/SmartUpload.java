package com.nc.util;

import java.io.*;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Hashtable;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class SmartUpload {

    public final void init(ServletConfig config) throws ServletException {
        this.config = config;
    }

    protected final ServletConfig getServletConfig() {
        return config;
    }

    public SmartUpload() {
        m_totalBytes = 0;
        m_currentIndex = 0;
        m_startData = 0;
        m_endData = 0;
        m_boundary = new String();
        m_totalMaxFileSize = 0L;
        m_maxFileSize = 0L;
        m_deniedFilesList = new Hashtable();
        m_allowedFilesList = new Hashtable();
        m_denyPhysicalPath = false;
        m_contentDisposition = new String();
        m_files = new CoolFiles();
        m_formRequest = new Request();
    }

    public void service(HttpServletRequest request, HttpServletResponse response)
        throws IOException, ServletException
    {
        m_request = request;
        m_response = response;
    }

    public void upload()
        throws IOException, ServletException
    {
        int totalRead = 0;
        int readBytes = 0;
        long totalFileSize = 0L;
        boolean found = false;
        String dataHeader = new String();
        String fieldName = new String();
        String fileName = new String();
        String fileExt = new String();
        String filePathName = new String();
        String contentType = new String();
        String contentDisp = new String();
        String typeMIME = new String();
        String subTypeMIME = new String();
        boolean isFile = false;
        m_totalBytes = m_request.getContentLength();
        m_binArray = new byte[m_totalBytes];
        for(; totalRead < m_totalBytes; totalRead += readBytes)
            try
            {
                readBytes = m_request.getInputStream().read(m_binArray, totalRead, m_totalBytes - totalRead);
            }
            catch(Exception exception) { }

        for(; !found && m_currentIndex < m_totalBytes; m_currentIndex++)
            if(m_binArray[m_currentIndex] == 13)
                found = true;
            else
                m_boundary = m_boundary + (char)m_binArray[m_currentIndex];

        if(m_currentIndex == 1)
            return;
        m_currentIndex++;
        do
        {
            if(m_currentIndex >= m_totalBytes)
                break;
            dataHeader = getDataHeader();
            m_currentIndex = m_currentIndex + 2;
            isFile = dataHeader.indexOf("filename") > 0;
            fieldName = getDataFieldValue(dataHeader, "name");
            if(isFile)
            {
                filePathName = getDataFieldValue(dataHeader, "filename");
                fileName = getFileName(filePathName);
                fileExt = getFileExt(fileName);
                contentType = getContentType(dataHeader);
                contentDisp = getContentDisp(dataHeader);
                typeMIME = getTypeMIME(contentType);
                subTypeMIME = getSubTypeMIME(contentType);
            }
            getDataSection();
            if(isFile && filePathName != null && fileExt != null)
            {
                if(m_deniedFilesList.containsValue(fileExt))
                    throw new SecurityException("The extension of the file is denied to be uploaded (1015).");
                if(!m_allowedFilesList.isEmpty() && !m_allowedFilesList.containsValue(fileExt))
                    throw new SecurityException("The extension of the file is not allowed to be uploaded (1010).");
                if(m_maxFileSize > (long)0 && (long)((m_endData - m_startData) + 1) > m_maxFileSize)
                    throw new SecurityException(String.valueOf((new StringBuffer("Size exceeded for this file : ")).append(fileName).append(" (1105).")));
                totalFileSize += (m_endData - m_startData) + 1;
                if(m_totalMaxFileSize > (long)0 && totalFileSize > m_totalMaxFileSize)
                    throw new SecurityException("Total File Size exceeded (1110).");
            }
            if(isFile)
            {
                CoolFile newFile = new CoolFile();
                newFile.setParent(this);
                newFile.setFieldName(fieldName);
                newFile.setFileName(fileName);
                newFile.setFileExt(fileExt);
                newFile.setFilePathName(filePathName);
                newFile.setIsMissing(filePathName.length() == 0);
                newFile.setContentType(contentType);
                newFile.setContentDisp(contentDisp);
                newFile.setTypeMIME(typeMIME);
                newFile.setSubTypeMIME(subTypeMIME);
                if(contentType.indexOf("application/x-macbinary") > 0)
                    m_startData = m_startData + 128;
                newFile.setSize((m_endData - m_startData) + 1);
                newFile.setStartData(m_startData);
                newFile.setEndData(m_endData);
                m_files.addFile(newFile);
            } else
            {
                String value = new String(m_binArray, m_startData, (m_endData - m_startData) + 1);
                m_formRequest.putParameter(fieldName, value);
            }
            if((char)m_binArray[m_currentIndex + 1] == '-')
                break;
            m_currentIndex = m_currentIndex + 2;
        } while(true);
    }

    public int save(String destPathName)
        throws SmartUploadException, IOException, ServletException
    {
        int count = 0;
        if(destPathName == null)
            destPathName = config.getServletContext().getRealPath("/");
        if(destPathName.indexOf("/") != -1)
        {
            if(destPathName.charAt(destPathName.length() - 1) != '/')
                destPathName = String.valueOf(destPathName).concat("/");
        } else
        if(destPathName.charAt(destPathName.length() - 1) != '\\')
            destPathName = String.valueOf(destPathName).concat("\\");
        for(int i = 0; i < m_files.getCount(); i++)
            if(!m_files.getFile(i).isMissing())
            {
                m_files.getFile(i).saveAs(destPathName + m_files.getFile(i).getFileName());
                count++;
            }

        return count;
    }

    public int getSize()
    {
        return m_totalBytes;
    }

    public byte getBinaryData(int index)
    {
        byte retval;
        try
        {
            retval = m_binArray[index];
        }
        catch(Exception e)
        {
            throw new ArrayIndexOutOfBoundsException("Index out of range (1005).");
        }
        return retval;
    }

    public CoolFiles getFiles()
    {
        return m_files;
    }

    public Request getRequest()
    {
        return m_formRequest;
    }

    public void downloadFile(String sourceFilePathName)
        throws IOException, ServletException
    {
        downloadFile(sourceFilePathName, null, null);
    }

    public void downloadFile(String sourceFilePathName, String contentType, String destFileName)
        throws IOException, ServletException
    {
        downloadFile(sourceFilePathName, contentType, destFileName, 65000);
    }

    public void downloadFile(String sourceFilePathName, String contentType, String destFileName, int blockSize)
        throws IOException, ServletException
    {
        if(sourceFilePathName == null)
            throw new IllegalArgumentException(String.valueOf((new StringBuffer("File '")).append(sourceFilePathName).append("' not found (1040).")));
        if(config.getServletContext().getRealPath(sourceFilePathName) != null)
            sourceFilePathName = config.getServletContext().getRealPath(sourceFilePathName);
        File file = new File(sourceFilePathName);
        FileInputStream fileIn = new FileInputStream(file);
        long fileLen = file.length();
        int readBytes = 0;
        int totalRead = 0;
        
        byte b[] = new byte[blockSize];
        if(contentType == null)
            m_response.setContentType("application/x-msdownload");
        else
        if(contentType.length() == 0)
            m_response.setContentType("application/x-msdownload");
        else
            m_response.setContentType(contentType);
        m_response.setContentLength((int)fileLen);
        if(destFileName == null)
            m_response.addHeader("Content-Disposition", "attachment; filename=".concat(String.valueOf(getFileName(sourceFilePathName))));
        else
        if(destFileName.length() == 0)
            m_response.addHeader("Content-Disposition", "attachment;");
        else
            m_response.addHeader("Content-Disposition", "attachment; filename=".concat(String.valueOf(destFileName)));
        while((long)totalRead < fileLen) 
        {
            readBytes = fileIn.read(b, 0, blockSize);
            totalRead += readBytes;
           
            m_response.getOutputStream().write(b, 0, readBytes);
        }
        m_response.flushBuffer();
        fileIn.close();
    }

    public void downloadField(ResultSet rs, String columnName, String contentType, String destFileName)
        throws SQLException, IOException, ServletException
    {
        if(rs == null)
            throw new IllegalArgumentException("The RecordSet cannot be null (1045).");
        if(columnName == null)
            throw new IllegalArgumentException("The columnName cannot be null (1050).");
        if(columnName.length() == 0)
            throw new IllegalArgumentException("The columnName cannot be empty (1055).");
        byte b[] = rs.getBytes(columnName);
        if(contentType == null)
            m_response.setContentType("application/x-msdownload");
        else
        if(contentType.length() == 0)
            m_response.setContentType("application/x-msdownload");
        else
            m_response.setContentType(contentType);
        m_response.setContentLength(b.length);
        if(destFileName == null)
            m_response.addHeader("Content-Disposition", "attachment;");
        else
        if(destFileName.length() == 0)
            m_response.addHeader("Content-Disposition", "attachment;");
        else
            m_response.addHeader("Content-Disposition", "attachment; filename=".concat(String.valueOf(destFileName)));
        m_response.getOutputStream().write(b, 0, b.length);
    }

    public void fieldToFile(ResultSet rs, String columnName, String destFilePathName)
        throws SQLException, SmartUploadException, IOException, ServletException
    {
        try
        {
            if(config.getServletContext().getRealPath(destFilePathName) != null)
                destFilePathName = config.getServletContext().getRealPath(destFilePathName);
            InputStream is_data = rs.getBinaryStream(columnName);
            FileOutputStream file = new FileOutputStream(destFilePathName);
            int c;
            while((c = is_data.read()) != -1) 
                file.write(c);
            file.close();
        }
        catch(Exception e)
        {
            throw new SmartUploadException("Unable to save file from the DataBase (1020).");
        }
    }

    private String getDataFieldValue(String dataHeader, String fieldName)
    {
        String token = new String();
        String value = new String();
        int pos = 0;
        int i = 0;
        int start = 0;
        int end = 0;
        token = String.valueOf((new StringBuffer(String.valueOf(fieldName))).append("=").append('"'));
        pos = dataHeader.indexOf(token);
        if(pos > 0)
        {
            i = pos + token.length();
            start = i;
            token = "\"";
            end = dataHeader.indexOf(token, i);
            if(start > 0 && end > 0)
                value = dataHeader.substring(start, end);
        }
        return value;
    }

    private String getFileExt(String fileName)
    {
        String token = new String();
        String value = new String();
        int pos = 0;
        int i = 0;
        int start = 0;
        int end = 0;
        if(fileName == null)
        {
            return null;
        } else
        {
            start = fileName.lastIndexOf('.') + 1;
            end = fileName.length();
            value = fileName.substring(start, end);
            return value;
        }
    }

    private String getContentType(String dataHeader)
    {
        String token = new String();
        String value = new String();
        int start = 0;
        int end = 0;
        token = "Content-Type:";
        start = dataHeader.indexOf(token) + token.length();
        if(start != -1)
        {
            end = dataHeader.length();
            value = dataHeader.substring(start, end);
        }
        return value;
    }

    private String getTypeMIME(String ContentType)
    {
        String value = new String();
        int pos = 0;
        pos = ContentType.indexOf("/");
        if(pos != -1)
            return ContentType.substring(1, pos);
        else
            return ContentType;
    }

    private String getSubTypeMIME(String ContentType)
    {
        String value = new String();
        int start = 0;
        int end = 0;
        start = ContentType.indexOf("/") + 1;
        if(start != -1)
        {
            end = ContentType.length();
            return ContentType.substring(start, end);
        } else
        {
            return ContentType;
        }
    }

    private String getContentDisp(String dataHeader)
    {
        String value = new String();
        int start = 0;
        int end = 0;
        start = dataHeader.indexOf(":") + 1;
        end = dataHeader.indexOf(";");
        value = dataHeader.substring(start, end);
        return value;
    }

    private void getDataSection()
    {
        boolean found = false;
        String dataHeader = new String();
        int searchPos = m_currentIndex;
        int keyPos = 0;
        int boundaryLen = m_boundary.length();
        m_startData = m_currentIndex;
        m_endData = 0;
        do
        {
            if(searchPos >= m_totalBytes)
                break;
            if(m_binArray[searchPos] == (byte)m_boundary.charAt(keyPos))
            {
                if(keyPos == boundaryLen - 1)
                {
                    m_endData = ((searchPos - boundaryLen) + 1) - 3;
                    break;
                }
                searchPos++;
                keyPos++;
            } else
            {
                searchPos++;
                keyPos = 0;
            }
        } while(true);
        m_currentIndex = m_endData + boundaryLen + 3;
    }

    private String getDataHeader()
    {
        int start = m_currentIndex;
        int end = 0;
        int len = 0;
        boolean found = false;
        while(!found) 
            if(m_binArray[m_currentIndex] == 13 && m_binArray[m_currentIndex + 2] == 13)
            {
                found = true;
                end = m_currentIndex - 1;
                m_currentIndex = m_currentIndex + 2;
            } else
            {
                m_currentIndex++;
            }
        String dataHeader = new String(m_binArray, start, (end - start) + 1);
        return dataHeader;
    }

    private String getFileName(String filePathName)
    {
        String token = new String();
        String value = new String();
        int pos = 0;
        int i = 0;
        int start = 0;
        int end = 0;
        pos = filePathName.lastIndexOf('/');
        if(pos != -1)
            return filePathName.substring(pos + 1, filePathName.length());
        pos = filePathName.lastIndexOf('\\');
        if(pos != -1)
            return filePathName.substring(pos + 1, filePathName.length());
        else
            return filePathName;
    }

    public void setDeniedFilesList(String deniedFilesList)
        throws SQLException, IOException, ServletException
    {
        int pos = 1;
        int cpt = 0;
        String ext = "";
        if(deniedFilesList != null)
        {
            for(int i = 0; i < deniedFilesList.length(); i++)
            {
                ext = ext + deniedFilesList.charAt(i);
                if(deniedFilesList.charAt(i) == ',')
                {
                    ext = ext.substring(0, ext.length() - 1);
                    m_deniedFilesList.put(new Integer(pos), ext);
                    ext = "";
                    pos++;
                }
                if(i + 1 == deniedFilesList.length() && ext != "")
                {
                    m_deniedFilesList.put(new Integer(pos), ext);
                    ext = "";
                    pos++;
                }
            }

        } else
        {
            m_deniedFilesList = null;
        }
    }

    public void setAllowedFilesList(String allowedFilesList)
    {
        int pos = 1;
        int cpt = 0;
        String ext = "";
        if(allowedFilesList != null)
        {
            for(int i = 0; i < allowedFilesList.length(); i++)
            {
                ext = ext + allowedFilesList.charAt(i);
                if(allowedFilesList.charAt(i) == ',')
                {
                    ext = ext.substring(0, ext.length() - 1);
                    m_allowedFilesList.put(new Integer(pos), ext);
                    ext = "";
                    pos++;
                }
                if(i + 1 == allowedFilesList.length() && ext != "")
                {
                    m_allowedFilesList.put(new Integer(pos), ext);
                    ext = "";
                    pos++;
                }
            }

        } else
        {
            m_allowedFilesList = null;
        }
    }

    public void setDenyPhysicalPath(boolean deny)
    {
        m_denyPhysicalPath = deny;
    }

    public void setContentDisposition(String contentDisposition)
    {
        m_contentDisposition = contentDisposition;
    }

    public void setTotalMaxFileSize(long totalMaxFileSize)
    {
        m_totalMaxFileSize = totalMaxFileSize;
    }

    public void setMaxFileSize(long maxFileSize)
    {
        m_maxFileSize = maxFileSize;
    }

    protected String getPhysicalPath(String path)
        throws IOException
    {
        if(path == null)
            throw new IllegalArgumentException("There is no specified destination file (1140).");
        if(path.length() == 0)
            throw new IllegalArgumentException("There is no specified destination file (1140).");
        
        
        if(config.getServletContext().getRealPath(path) == null && m_denyPhysicalPath)
            throw new IllegalArgumentException("Physical path is denied (1125).");
        if(config.getServletContext().getRealPath(path) == null && !m_denyPhysicalPath)
            return path;
        else
            return config.getServletContext().getRealPath(path);
    }

    public void uploadInFile(String destFilePathName)
        throws SmartUploadException, IOException
    {
        int intsize = 0;
        int pos = 0;
        int readBytes = 0;
        if(destFilePathName == null)
            throw new IllegalArgumentException("There is no specified destination file (1025).");
        if(destFilePathName.length() == 0)
            throw new IllegalArgumentException("There is no specified destination file (1025).");
        if(config.getServletContext().getRealPath(destFilePathName) == null && m_denyPhysicalPath)
            throw new SecurityException("Physical path is denied (1035).");
        intsize = m_request.getContentLength();
        m_binArray = new byte[intsize];
        for(; pos < intsize; pos += readBytes)
            try
            {
                readBytes = m_request.getInputStream().read(m_binArray, pos, intsize - pos);
            }
            catch(Exception exception) { }

        if(config.getServletContext().getRealPath(destFilePathName) != null)
            destFilePathName = config.getServletContext().getRealPath(destFilePathName);
        try
        {
            File file = new File(destFilePathName);
            file.createNewFile();
            FileOutputStream fileOut = new FileOutputStream(file);
            fileOut.write(m_binArray);
            fileOut.close();
        }
        catch(Exception e)
        {
            throw new SmartUploadException("The Form cannot be saved in the specified file (1030).");
        }
    }

    protected byte m_binArray[];
    protected HttpServletRequest m_request;
    protected HttpServletResponse m_response;
    private int m_totalBytes;
    private int m_currentIndex;
    private int m_startData;
    private int m_endData;
    private String m_boundary;
    private long m_totalMaxFileSize;
    private long m_maxFileSize;
    private Hashtable m_deniedFilesList;
    private Hashtable m_allowedFilesList;
    private boolean m_denyPhysicalPath;
    private String m_contentDisposition;
    private CoolFiles m_files;
    private Request m_formRequest;
    private ServletConfig config;
}