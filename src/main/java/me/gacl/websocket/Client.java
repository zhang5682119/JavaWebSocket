package me.gacl.websocket;
import java.net.URI;

import javax.websocket.ContainerProvider;
import javax.websocket.Session;
import javax.websocket.WebSocketContainer;

public class Client {

    static Session session;
    public static void main(String[] args) {
        try {
            WebSocketContainer container = ContainerProvider.getWebSocketContainer();
            String uri = "wss://www.xbtc.cx//endpointWisely/474/wunpwl5m/websocket";
            System.out.println("Connecting to " + uri);
            container.connectToServer(MyClientEndpoint.class, URI.create(uri));
            session.getBasicRemote().sendText("[\"SUBSCRIBE\\nid:sub-0\\ndestination:/topic/dice/bhb\\n\\n\\u0000\"]");
            java.io.BufferedReader r=new  java.io.BufferedReader(new java.io.InputStreamReader( System.in));
            while(true){
                String line=r.readLine();
                if(line.equals("quit")) break;
                session.getBasicRemote().sendText(line);
            }
        } catch ( Exception ex) {
            ex.printStackTrace();
        }
    }
}