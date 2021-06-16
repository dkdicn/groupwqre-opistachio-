package com.spring.chatting.websockethandler;

import java.util.*;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.spring.groupware.member.model.MemberVO;


// === #177. (웹채팅관련8) === //
public class WebsocketEchoHandler extends TextWebSocketHandler {
	
	// === 웹소켓서버에 연결한 클라이언트 사용자들을 저장하는 리스트 ===
    private List<WebSocketSession> connectedUsers = new ArrayList<>(); 
    
	
	// init-method(@PostConstruct)
	public void init() throws Exception {
		
	}

	
	@Override
    public void afterConnectionEstablished(WebSocketSession wsession) 
    	throws Exception {
		// >>> 파라미터 WebSocketSession wsession 은  웹소켓서버에 접속한 클라이언트 사용자임. <<<
		connectedUsers.add(wsession);
		System.out.println("====> 웹채팅확인용 : " + wsession.getId() + "님이 접속했습니다.");    
        System.out.println("====> 웹채팅확인용 : " + "연결 컴퓨터명 : " + wsession.getRemoteAddress().getHostName());       
        System.out.println("====> 웹채팅확인용 : " + "연결 컴퓨터명 : " + wsession.getRemoteAddress().getAddress().getHostName());
        System.out.println("====> 웹채팅확인용 : " + "연결 IP : " + wsession.getRemoteAddress().getAddress().getHostAddress()); 
	
        String connectingUserName = "「";
        
        for (WebSocketSession webSocketSession : connectedUsers) {
       	 	 Map<String, Object> map = webSocketSession.getAttributes();

	    	 MemberVO loginuser = (MemberVO)map.get("loginuser");  
	
       	     connectingUserName += loginuser.getMbr_name()+" "; 
       }
       connectingUserName += "」";
       

       
       for (WebSocketSession webSocketSession : connectedUsers) {
	      	webSocketSession.sendMessage(new TextMessage(connectingUserName));
	   }

  }


	@Override
    protected void handleTextMessage(WebSocketSession wsession, TextMessage message) 
    	throws Exception {
    	
  
    	 Map<String, Object> map = wsession.getAttributes();
    	 MemberVO loginuser = (MemberVO)map.get("loginuser");  

    	 System.out.println("====> 웹채팅확인용 : 로그인ID : " + loginuser.getMbr_id());
    	
         MessageVO messageVO = MessageVO.convertMessage(message.getPayload());
       
        String hostAddress = "";
 
        for (WebSocketSession webSocketSession : connectedUsers) {
            if (messageVO.getType().equals("all")) { 
            	// 채팅할 대상이 "전체" 일 경우
                if (!wsession.getId().equals(webSocketSession.getId())) { 
                    webSocketSession.sendMessage(
                            new TextMessage("&nbsp;[<span style='font-weight:bold; cursor:pointer;' class='loginuserName'>" +loginuser.getMbr_name()+"&nbsp;"+ loginuser.getRank_detail()+"&nbsp;"+ loginuser.getDept_detail()+ "</span>]</br>" + " ▶ " + messageVO.getMessage()));  
                }
            } 
            else { // 채팅할 대상이 "전체"가 아닌 특정대상(지금은 귓속말대상 IP address 임) 일 경우 
            	hostAddress = webSocketSession.getRemoteAddress().getAddress().getHostAddress();
                
            	if (messageVO.getTo().equals(hostAddress)) { 
   
                    webSocketSession.sendMessage(
                            new TextMessage(
                                    "<span style='color:red; font-weight: bold;'>"
                                    +"&nbsp;[<span style='font-weight:bold; cursor:pointer;' class='loginuserName'>" +loginuser.getMbr_name()+ "</span>]" + "▶ " + messageVO.getMessage()
                                    +"</span>") 
                    );
                    break; 
                }
            }
        }
 
        
        System.out.println("====> 웹채팅확인용 : 웹세션ID " + wsession.getId() + "의 메시지 : " + message.getPayload() );
        // ====> 웹채팅확인용 : 웹세션ID 23의 메시지 : {"message":"채팅방에 <span style='color: red;'>입장</span>했습니다","type":"all","to":"all"}
    }
	
	
	// === 클라이언트가 웹소켓서버와의 연결을 끊을때 작업 처리하기 ===
    /*
       afterConnectionClosed(WebSocketSession session, CloseStatus status) 메소드는 
             클라이언트가 연결을 끊었을 때 
             즉, WebSocket 연결이 닫혔을 때(채팅페이지가 닫히거나 채팅페이지에서 다른 페이지로 이동되는 경우) 자동으로 호출되어지는(실행되어지는) 메소드이다.
    */
    @Override
    public void afterConnectionClosed(WebSocketSession wsession, CloseStatus status) 
    	throws Exception {
    	 // 파라미터 WebSocketSession wsession 은 연결을 끊은 웹소켓 클라이언트임.
	     // 파라미터 CloseStatus 은 웹소켓 클라이언트의 연결 상태.
    	
    	Map<String, Object> map = wsession.getAttributes();
    	MemberVO loginuser = (MemberVO)map.get("loginuser");
    	
    	connectedUsers.remove(wsession);
    	// 웹소켓 서버에 연결되어진 클라이언트 목록에서 연결은 끊은 클라이언트는 삭제시킨다.
   	 
        for (WebSocketSession webSocketSession : connectedUsers) {
        	
        	// 퇴장했다라는 메시지를 자기자신을 뺀 나머지 모든 사용자들에게 메시지를 보내도록 한다.
        	if (!wsession.getId().equals(webSocketSession.getId())) { 
                webSocketSession.sendMessage(
                	new TextMessage(wsession.getRemoteAddress().getAddress().getHostAddress() +" [<span style='font-weight:bold;'>" +loginuser.getMbr_name()+ "</span>]" + "님이 <span style='color: red;'>퇴장</span>했습니다.")
                ); 
            }
        }
       
        System.out.println("====> 웹채팅확인용 : 웹세션ID " + wsession.getId() + "이 퇴장했습니다.");
        
        
        ///// ===== 접속을 끊을시 접속자명단을 알려주기 위한 것 시작 ===== /////
        String connectingUserName = "「";
        
        for (WebSocketSession webSocketSession : connectedUsers) {
        	 Map<String, Object> map2 = webSocketSession.getAttributes();
	    	 MemberVO loginuser2 = (MemberVO)map2.get("loginuser");  
	    	 // "loginuser" 은 HttpSession에 저장된 키 값으로 로그인 되어진 사용자이다.
	
        	 connectingUserName += loginuser2.getMbr_name()+" "; 
        }
        
        connectingUserName += "」";
        
        for (WebSocketSession webSocketSession : connectedUsers) {
        	 webSocketSession.sendMessage(new TextMessage(connectingUserName));
        }
        ///// ===== 접속해제시 접속자명단을 알려주기 위한 것 끝 ===== /////
    }	
	
	
}
