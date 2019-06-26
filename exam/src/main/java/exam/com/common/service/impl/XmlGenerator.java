package exam.com.common.service.impl;

import java.io.ByteArrayOutputStream;
import java.io.File;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.terracotta.agent.repkg.de.schlichtherle.io.FileOutputStream;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

public class XmlGenerator {
	private Document doc;
	private Transformer transformer = null;
	

	public XmlGenerator(){
		DocumentBuilderFactory docFactory = DocumentBuilderFactory.newInstance();
		DocumentBuilder docBuilder = null;
		try {
			docBuilder = docFactory.newDocumentBuilder();
		} catch (ParserConfigurationException e) {
			e.printStackTrace();
		}
		
		doc = docBuilder.newDocument();
		TransformerFactory transformerFactory = TransformerFactory.newInstance();
		try {
			transformer = transformerFactory.newTransformer();
		} catch (TransformerConfigurationException e) {
			e.printStackTrace();
		}
		
		transformer.setOutputProperty(OutputKeys.ENCODING, "UTF-8");
		//transformer.setOutputProperty(OutputKeys.ENCODING, "euc-kr");
		transformer.setOutputProperty(OutputKeys.INDENT, "yes");
	}
	
	public void addRootElement(String elementName){
		Element root = doc.createElement(elementName);
		doc.appendChild(root);
	}
	
	public Element addElementCDATA(String parentElementName, int index, String delementName, String elementValue){
		NodeList nodeList = doc.getElementsByTagName(parentElementName);
		if(nodeList == null || nodeList.getLength() == 0) return null;
		
		Element element = doc.createElement(delementName);
		element.appendChild(doc.createCDATASection(elementValue));
		nodeList.item(index).appendChild(element);
		
		return element;
	}
	
	public Element addElementCDATA(String parentElementName, int index, String delementName){
		NodeList nodeList = doc.getElementsByTagName(parentElementName);
		if(nodeList == null || nodeList.getLength() == 0) return null;
		
		Element element = doc.createElement(delementName);
		nodeList.item(index).appendChild(element);
		
		return element;
	}
	
	public Element addElement(String parentElementName, int index, String delementName, String elementValue){
		NodeList nodeList = doc.getElementsByTagName(parentElementName);
		if(nodeList == null || nodeList.getLength() == 0) return null;
		
		Element element = doc.createElement(delementName);
		element.appendChild(doc.createTextNode(elementValue));
		nodeList.item(index).appendChild(element);
		
		return element;
	}
	
	public Element addElement(String parentElementName, int index, String delementName){
		NodeList nodeList = doc.getElementsByTagName(parentElementName);
		if(nodeList == null || nodeList.getLength() == 0) return null;
		
		Element element = doc.createElement(delementName);
		nodeList.item(index).appendChild(element);
		
		return element;
	}
	
	public Element addElementCDATA(Element parentElement, String delementName, String elementValue){
		
		Element element = doc.createElement(delementName);
		element.appendChild(doc.createCDATASection(elementValue));
		parentElement.appendChild(element);
		
		return element;
	}
	
	public Element addElementCDATA(Element parentElement, String delementName){
		Element element = doc.createElement(delementName);
		parentElement.appendChild(element);
		
		return element;
	}
	
	public Element addElement(Element parentElement, String delementName, String elementValue){
		Element element = doc.createElement(delementName);
		element.appendChild(doc.createTextNode(elementValue));
		parentElement.appendChild(element);
		
		return element;
	}
	
	public Element addElement(Element parentElement, String delementName){
		
		Element element = doc.createElement(delementName);
		parentElement.appendChild(element);
		
		return element;
	}
	
	
	
	
	
	
	public boolean addAttribute(String elementName, int index, String attributeName, String attributeValue){
		NodeList nodeList = doc.getElementsByTagName(elementName);
		if(nodeList == null) return false;
		
		Element element = (Element) nodeList.item(index);
		element.setAttribute(attributeName, attributeValue);
		
		return true;
	}
	
	public boolean addAttribute(Element element, String attributeName, String attributeValue) {
		
		element.setAttribute(attributeName, attributeValue);
		
		return true;
	}
	
	public boolean addAttribute(NodeList nodeList, String attributeName, String attributeValue) {
		for (int i = 0; i < nodeList.getLength(); i++) {
			((Element)nodeList.item(i)).setAttribute(attributeName, attributeValue);
		}
		
		return true;
	}
	
	
	
	
	
	
	
	
	private void generator(StreamResult result) throws TransformerException {
		DOMSource source = new DOMSource(doc);
		transformer.transform(source, result);
	}
	
	public boolean generator(String fileName){
		try {
			StreamResult result = new StreamResult(new FileOutputStream(new File(fileName)));
			generator(result);
			
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		
		return true;
	}
	
	public boolean print(){
		try {
			StreamResult result = new StreamResult(System.out);
			generator(result);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		
		return true;
	}
	
	
	public String toString(){
		try {
			ByteArrayOutputStream os = new ByteArrayOutputStream();
			
			StreamResult result = new StreamResult(os);
			generator(result);
			
			return new String(os.toByteArray());
		} catch (Exception e) {
			// TODO: handle exception
			
			System.out.println(e);
			e.printStackTrace();
		}
		return null;
	}
}
