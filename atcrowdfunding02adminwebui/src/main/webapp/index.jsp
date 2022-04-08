<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" pageEncoding="utf-8" %>
<html>
  <head>
    <meta charset="UTF-8">
    <title>$Title$</title>
    <base href="http://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/">
    <script type="text/javascript" src="jquery/jquery-2.1.1.min.js"></script>
    <script type="text/javascript">
        $(function () {



            $("#btn4").click(function () {
              var student= {
                "stuId": 1 ,
                "stuName" : "刘云山" ,
                "address": {
                  "city":  "gao " ,
                  "provicnce" :"taiwanwan ",
                  "street" : "csda dsa"
                },
                "map" :{
                  "k1" : " v1" ,
                  "k2" : " v2",
                  "k3" : "v3"
                },
                "subjectList" : [
                  {"subjectName":"java",
                    "subjectScore": 100 } ,
                  {"subjectName":"SSM",
                    "subjectScore": 99 }
                ]
              };
              var requestBody = JSON.stringify(student);


              $.ajax({
                "url":"send/compose/object.json",
                "type":"post",
                "data": requestBody,
                "contentType" :"application/json;charset=UTF-8",
                "dataType" : "json",
                "success" : function (response) {
                  alert(response);
                },
                "error": function (response) {
                  alert(response);
                }
              })
          })

          var array = [5,8,12];
          var requestBody = JSON.stringify(array);

          $("#btn2").click(function () {
            $.ajax({
              "url":"send/array/two.html",
              "type":"post",
              "data": {
                array:[5,8,12]
              },
              "dataType" : "text",
              "success" : function (response) {
                alert(response)
              },
              "error": function (response) {
                alert(response)
              }
            })
          })


          $("#btn1").click(function () {
            $.ajax({
              "url":"send/array/one.html",
              "type":"post",
              "data": {
                array:[5,8,12]
              },
              "dataType" : "text",
              "success" : function (response) {
                alert(response)
              },
              "error": function (response) {
                alert(response)
              }
            })
          })
        })
    </script>
  </head>
  <body>
  <a href="${pageContext.request.contextPath}/test/ssm.html">测试SSM整合环境</a>
  首页
  <br>
  <br>
  <br>
  <button id="btn1">send [5,8,12]  </button>

  <br>
  <br>
  <br>
  <button id="btn2">send [5,8,12]  </button>
  <br>
  <br>
  <br>
  <button id="btn3">send [5,8,12]  </button>  <br>
  <br>
  <br>
  <button id="btn4">send复杂数据  </button>
  </body>
</html>
