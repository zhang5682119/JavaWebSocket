<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.alibaba.fastjson.JSONObject" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.math.BigDecimal" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%!

    double sub(double d1,double d2){
    BigDecimal bd1 = new BigDecimal(Double.toString(d1));
    BigDecimal bd2 = new BigDecimal(Double.toString(d2));
    return bd1.subtract(bd2).doubleValue();
    }
    double div(double d1,double d2,int scale){
        //  当然在此之前，你要判断分母是否为0，
        //  为0你可以根据实际需求做相应的处理
        BigDecimal bd1 = new BigDecimal(Double.toString(d1));
        BigDecimal bd2 = new BigDecimal(Double.toString(d2));
        return bd1.divide(bd2,scale,BigDecimal.ROUND_HALF_UP).doubleValue();
    }
    double h1;
    double h2;
    double h3;
    double h4;
   %>
<%


    String driver = "com.mysql.jdbc.Driver";
    // URL指向要访问的数据库名test1
    String url = "jdbc:mysql://39.106.21.162:3306/test?useUnicode=true&characterEncoding=utf-8";
    // MySQL配置时的用户名
    String user = "root";
    // Java连接MySQL配置时的密码
    String password = "root";
    double bhbBetQty=0;
    double charges=0;
    double bhbBetQty2=0;
    double charges2=0;
    double bhbBetQty3=0;
    double charges3=0;
    try {


        Class.forName(driver);
        Connection conn = DriverManager.getConnection(url, user, password);
        Statement statement = conn.createStatement();
        int i=1;
        ArrayList list=new ArrayList();

            String sql = "SELECT\n" +
                    "\t*\n" +
                    "FROM\n" +
                    "\twebsocket\n" +
                    "WHERE\n" +
                    "\tid IN(\n" +
                    "\t\t(SELECT max(id) FROM websocket) ,\n" +
                    "\t\t(SELECT max(id) FROM websocket) - 1000 ,\n" +
                    "                 (SELECT max(id) FROM websocket) - 3000 ,\n" +
                    "\t\t(SELECT max(id) FROM websocket) - 5000 ,\n" +
                    "\t\t(SELECT max(id) FROM websocket) - 10000\n" +
                    "\t)\n" +
                    "\n" +
                    "order by id desc";

            ResultSet rs = statement.executeQuery(sql);
            while (rs.next()) {
                bhbBetQty = rs.getDouble(2);
                charges = rs.getDouble(4);
                HashMap hashMap=new HashMap();
                hashMap.put("bhbBetQty",bhbBetQty);
                hashMap.put("charges",charges);
                list.add(hashMap);
            }
        Double b1= ((Double)((HashMap)list.get(0)).get("bhbBetQty")) ;
        Double b2= ((Double)((HashMap)list.get(1)).get("bhbBetQty")) ;
        Double b3= ((Double)((HashMap)list.get(2)).get("bhbBetQty")) ;
        Double b4= ((Double)((HashMap)list.get(3)).get("bhbBetQty")) ;
        Double b5= ((Double)((HashMap)list.get(4)).get("bhbBetQty")) ;

        Double c1= ((Double)((HashMap)list.get(0)).get("charges")) ;
        Double c2= ((Double)((HashMap)list.get(1)).get("charges")) ;
        Double c3= ((Double)((HashMap)list.get(2)).get("charges")) ;
        Double c4= ((Double)((HashMap)list.get(3)).get("charges")) ;
        Double c5= ((Double)((HashMap)list.get(4)).get("charges")) ;

         h1=div(sub(b1.doubleValue(),b2.doubleValue()), sub(c1.doubleValue(),c2.doubleValue()),2);
         h2=div(sub(b1.doubleValue(),b3.doubleValue()), sub(c1.doubleValue(),c3.doubleValue()),2);
         h3=div(sub(b1.doubleValue(),b4.doubleValue()), sub(c1.doubleValue(),c4.doubleValue()),2);
         h4=div(sub(b1.doubleValue(),b5.doubleValue()), sub(c1.doubleValue(),c5.doubleValue()),2);
            request.setCharacterEncoding("utf-8");
            conn.close();

    }  catch (Exception e) {
        e.printStackTrace();
    }
%>

Welcome<br/>
难度越大，亏损概率越大
难度30左右为正常概率
<button onclick="send()">重新获取</button>
<hr/>
<hr/>
<div id="message">
    15分钟难度：<% out.print(h1);%>
    <br>
    30分钟难度：<% out.print(h2);%>
    <br>
    1小时难度：<% out.print(h3);%>
    <br>
    3小时难度：<% out.print(h4);%>
    <br>

</div>
</body>
<script src="https://cdn.staticfile.org/jquery/1.10.2/jquery.min.js">
</script>
<script type="text/javascript">

    //发送消息
    function send() {
        document.location.reload();
    }
    $(document).ready(function(){
        //循环执行，每隔1秒钟执行一次 1000
        var t1=window.setInterval(refreshCount, 10000);
        function refreshCount() {
           send();
        }

    });
</script>
</html>
