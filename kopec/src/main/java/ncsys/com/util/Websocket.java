package ncsys.com.util;

import java.io.IOException;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;

import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonWriter;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

/**
 * @Package Name : ncsys.com.util
 * @Class Name : Websocket.java
 * @Description : 파일 명세
 * @Modification Information
 * @
 * @  수정일              수정자                수정내용
 * @ -------     --------    ---------------------------
 * @ 2019. 9. 23.      강문철      최초 생성
 *
 *  @author 공통컴포넌트 개발팀 강문철
 *  @since 2019. 9. 23.
 *  @version 1.0
 *
 */


@ServerEndpoint("/websocket")
public class Websocket {

	static List<Session> socketSessions = Collections.synchronizedList(new ArrayList<>());



	/**
	 * <pre>
	 * 1. 개요 : 웹
	 * 2. 처리내용 :
	 * </pre>
	 * @Methoed Name : handleOpen
	 * @Author : moonchel kang
	 * @Date : 2019. 9. 23.
	 *
	 *
	 */
	@OnOpen
	public void handleOpen(Session session){
		socketSessions.add(session);
		System.out.println("client is now connected ...");
	}


	@OnMessage
	public void handleMessage(String message, Session session) throws IOException{
		String username = (String)session.getUserProperties().get("username");

		if(username == null){
			session.getUserProperties().put("username", message);
			session.getBasicRemote().sendText(buildJsonData("System","you are noew connected as " + message));
			return;
		}

		Iterator<Session> iterator = socketSessions.iterator();
		while(iterator.hasNext()){
			iterator.next().getBasicRemote().sendText(buildJsonData(username, message));
		}

		System.out.println("receive form client : "+ message);
		String replymessage = "echo "+message;
		System.out.println("send to client : "+ replymessage);

	}

	@OnClose
	public void handleClose(Session session){
		socketSessions.remove(session);
		System.out.println("client is now disconnected ...");
	}

	@OnError
	public void handleError(Throwable t){
		t.printStackTrace();
	}


	public String buildJsonData(String username, String message){
		JsonObject jsonObject = Json.createObjectBuilder().add("message", username+" : "+message).build();
		StringWriter stringwriter = new StringWriter();
		try(JsonWriter jsonWriter = Json.createWriter(stringwriter)){
			jsonWriter.write(jsonObject);
		} catch (Exception e) {
			// TODO: handle exception
		}

		return stringwriter.toString();
	}






}
