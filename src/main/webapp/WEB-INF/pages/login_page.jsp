<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page session="true"%>
<html>
<head>
<title>Login Page</title>

    <link href="<c:url value="/resources/css/res-login.css"/>" rel="stylesheet">
    <link href="<c:url value="/resources/css/bootstrap.min.css"/>" rel="stylesheet">
    <link href="<c:url value="/resources/css/font-awesome.min.css"/>" rel="stylesheet">
    
     
    
<style>
.error {
	padding: 15px;
	margin-bottom: 20px;
	border: 1px solid transparent;
	border-radius: 4px;
	color: #a94442;
	background-color: #f2dede;
	border-color: #ebccd1;
}

.msg {
	padding: 15px;
	margin-bottom: 20px;
	border: 1px solid transparent;
	border-radius: 4px;
	color: #31708f;
	background-color: #d9edf7;
	border-color: #bce8f1;
}

#login-box {
	width: 300px;
	padding: 20px;
	margin: 100px auto;
	background: #fff;
	-webkit-border-radius: 2px;
	-moz-border-radius: 2px;
	border: 1px solid #000;
}
</style>
</head>
<body onload='document.loginForm.username.focus();'>
	<div class="login-form">

		<c:if test="${not empty error}">
			<div class="error">${error}</div>
		</c:if>
		<c:if test="${not empty msg}">
			<div class="msg">${msg}</div>
		</c:if>

			<h1 class="text-center">Safire Billing App</h1>
			<div class="form-header">
				<i class="fa fa-user"></i>
			</div>
			<form name='loginForm'
			action="<c:url value='/login' />" method='POST'>
			
				<input name="username" id="username" type="text" class="form-control" placeholder="User Name" autofocus value="safire">
				<input name="password" id="password" type="password" class="form-control" placeholder="Password" value="123456"> 
				<button class="btn btn-block bt-login" type="submit">Sign in</button>
				<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" />
				
			</form>
			<br/>
			<div class="text-center well">
				<p style="color: red">Powered by : SRM Technologies </p>
			</div>
		</div>
	<script src="<c:url value="/resources/js/jquery-1.11.2.min.js"/>"></script>
	<script src='<c:url value="/resources/js/jquery.validate.min.js"/>'></script>
    <script src="<c:url value="/resources/js/bootstrap.min.js"/>"></script>
</body>
</html>