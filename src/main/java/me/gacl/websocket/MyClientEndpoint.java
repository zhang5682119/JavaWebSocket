package me.gacl.websocket;
import java.io.IOException;

import javax.websocket.ClientEndpoint;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;

@ClientEndpoint
public class MyClientEndpoint {

    @OnOpen
    public void onOpen(Session session) {
        System.out.println("Connected to endpoint: " + session.getBasicRemote());
        try {
            Client.session=session;
            String name = "[\"SUBSCRIBE\\nid:sub-0\\ndestination:/topic/dice/bhb\\n\\n\\u0000\"]";
            System.out.println("Sending message to endpoint: " + name);
            session.getBasicRemote().sendText(name);
        } catch (IOException ex) {
            ex.printStackTrace();
        }
    }

    @OnMessage
    public void processMessage(String message) {
        System.out.println("Received message in client: " + message);
        WriteDB.write(message);
    }

    @OnClose
    public  void onClose(Session session) {
       Client.main(null);

    }

    @OnError
    public void processError(Throwable t) {
        t.printStackTrace();
    }


}