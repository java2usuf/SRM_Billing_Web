<%--
  Created by IntelliJ IDEA.
  User: myousuff
  Date: 7/12/16
  Time: 8:32 AM
  To change this template use File | Settings | File Templates.
--%>
<%@taglib prefix="sec"
          uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script src="<c:url value="/resources/js/jquery-1.11.2.min.js"/>"></script>
<script src="<c:url value="/resources/js/jquery-ui.min.js"/>"></script>
<script src="<c:url value="/resources/js/zebra_datepicker.js"/>"></script>


<link href="<c:url value="/resources/css/Zebra_DatePicker_default.css"/>" rel="stylesheet">




<script>
  $(document).ready(function() {

    // assuming the controls you want to attach the plugin to
    // have the "datepicker" class set
    $('#datepicker-example1').Zebra_DatePicker();

  });
</script>
<html>
<head>
  <c:url value="/report" var="reportURL" />

  <form action="<c:url value="${reportURL}"/>" method="GET" id="logoutForm">

    <input id="datepicker-example1" type="text" name="dateSelected"/>

    <input type="submit" value="Go"/>

  </form>


</head>
<body>




</body>
</html>
