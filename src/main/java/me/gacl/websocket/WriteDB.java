package me.gacl.websocket;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class WriteDB {

    static String driver = "com.mysql.jdbc.Driver";
    static  String url = "jdbc:mysql://39.106.21.162:3306/test?useUnicode=true&characterEncoding=utf-8";
    static String user = "root";
    static String password = "root";

    public static void write(String txtMsg){
        try {
            String s=txtMsg.substring(txtMsg.indexOf("{"),txtMsg.indexOf("}")+1);
            int index1=s.indexOf("charges");
            int index2=s.indexOf("bhbBetQty");
            int index3=s.indexOf("bcbOutputQty");

            String charges= (s.substring(index1+"charges".length()+3,index2-3));
            String bhbBetQty=(s.substring(index2+"bhbBetQty".length()+3,index3-3));
            String bcbOutputQty=(s.substring(index3+"bcbOutputQty".length()+3,s.length()-1));

            //{\"charges\":14876.38434747431166203945751,\"bhbBetQty\":1111667.9207,\"bcbOutputQty\":11116679.2070}
            Class.forName(driver);
            Connection conn = DriverManager.getConnection(url, user, password);
            Statement statement = conn.createStatement();
            String sql = "INSERT INTO websocket(bhbBetQty,bcbOutputQty,charges) VALUES ("+bhbBetQty+","+bcbOutputQty+","
                    +charges+")";
            System.out.println(sql);
            statement.executeUpdate(sql);
            statement.close();
            conn.close();
        }  catch (Exception e) {
            e.printStackTrace();
        }
    }

}
