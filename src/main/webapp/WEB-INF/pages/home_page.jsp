	<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="<c:url value="/resources/css/pure-min.css"/>">
    <link href="<c:url value="/resources/css/jquery-ui.min.css"/>" rel="stylesheet">
    <link href="<c:url value="/resources/css/bootstrap.min.css"/>" rel="stylesheet">
    <link href="<c:url value="/resources/css/datepicker.css"/>" rel="stylesheet">
    <link href="<c:url value="/resources/css/font-awesome.min.css"/>" rel="stylesheet">
    <link href="<c:url value="/resources/css/style.css"/>" rel="stylesheet">
    <link href="<c:url value="/resources/css/jquery-confirm.min.css"/>" rel="stylesheet">
    <link href="<c:url value="/resources/css/sticky-footer-navbar.css"/>" rel="stylesheet">
    
<html>
<body>

	<sec:authorize access="hasRole('ROLE_USER')">
		<script>
		
		var welcomeurl = '<c:url value="/login"/>';
			function formSubmit() {
				
				$.confirm({
				    title: 'Logging-out !!!',
				    content: 'Do you really want to Log-out ?',
				    autoClose: 'cancel|3000',
				    keyboardEnabled: true,
				    confirm: function(){
				    	document.getElementById("logoutForm").submit();
				    },
				    cancel:function(){
				        //alert('canceled');
				    }
				});
			}
		</script>
<!--  -->


		<c:if test="${pageContext.request.userPrincipal.name != null}">
		<div class="container content" style="padding-top: 0px;">

    	<div class="row" align="right" style="padding-right: 16px;">
    	
    			<!-- For login user -->
		<c:url value="/logout" var="logoutUrl" />
		<c:url value="/save" var="saveUrl" />
		
		<form action="${logoutUrl}" method="post" id="logoutForm">
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" />
		</form>

			<a class="pure-button button-secondary" href="/report">
				Report
			</a>
    		<a class="pure-button button-secondary" href="javascript:formSubmit()">
			    Logout
			</a>
		</div>
		<form action="${saveUrl}" id="BillDetailsForm" method="post">
					<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" />
		<!--  -->
    	<div class="row">
    		<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
    			<h1 class="text-center title">Safire Tex - Tirupattur</h1>
    		</div>
    	</div>
      	<div class="row">
      		<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
      		<fieldset id='form1'>
	      			<table id="myTable" class="table table-bordered table-hover">
						<thead>
							<tr>
								<th width="2%"><input type="checkbox" class="formcontrol" id="check_all"></th>
								<!-- <th width="15%">Item No</th> -->
								<th width="38%" align="center">Name</th>
								<th width="15%" align="center">Price</th>
								<th width="15%" align="center">Quantity</th>
								<th width="15%" align="center">Total</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><input type="checkbox" class="case"></td>
								<!-- <td>
									
								</td> -->
								<input disabled="disabled"  type="hidden" autocomplete="off" class="form-control autocomplete_txt" id="itemNo_1" name="itemNo[]" 
									data-type="productCode" value="34" >
								<td><input tabindex="1" style="text-align: center;" type="text" autocomplete="off" class="form-control autocomplete_txt" 
								id="itemName_1" name="itemName[]" data-type="productName" value="Item"></td>
								<td><input tabindex="2" onfocus="this.select();" type="number" onpaste="return false;" ondrop="return false;" 
								style="text-align:center; background-color:black; font-stretch: wider;color: yellow;font-size-adjust: none;font-style: oblique;" onkeypress="return IsNumeric(event);"   autocomplete="off" class="form-control changesNo" id="price_1" name="price[]"></td>
								<td><input tabindex="3" style="text-align:center; background-color:black; font-stretch: wider;color: yellow;font-size-adjust: none;font-style: oblique;" onfocus="this.select();" type="number" onpaste="return false;" ondrop="return false;" onkeypress="return IsNumeric(event);" autocomplete="off" class="form-control changesNo" id="quantity_1" name="quantity[]"></td>
								<td><input disabled="disabled" onfocus="this.select();" type="number" onpaste="return false;" ondrop="return false;" onkeypress="return IsNumeric(event);" autocomplete="off" class="form-control totalLinePrice" id="total_1" name="total[]"></td>
							</tr>
						</tbody>
					</table>
			</fieldset>
      		</div>
      	</div>
      	<div class="row" id="totalAmountDiv">
      		<div class="col-lg-6">
      			<button type="button" class="btn btn-danger delete">- Delete</button>
      			<button type="button" id="addbut" class="btn btn-success addmore">+ Add More</button>
      			</br></br>
      			<label style="font: bolder; font-size: 100px;color: gray;font-size-adjust: none;font-stretch: wider; padding-top: 60px;">&#8377; &nbsp;</label>
      			<label for="totalLabel" style="font: bolder; font-size: 100px;color: red;font-size-adjust: none;font-stretch: wider; padding-top: 60px;">0.0</label>
      		</div>

      		<div class="col-lg-offset-1 col-lg-5">
				<fieldset class="form-inline">
					<div class="form-group">
						<label>Customer Mobile Number: &nbsp;</label>
						<div class="input-group">
							<div class="input-group-addon">&#8377;</div>
							<input type="number"  onpaste="return false;" ondrop="return false;" onkeypress="return IsNumeric(event);" name="mobile"
							placeholder="" id="mobileNo" class="form-control">
						</div>
					</div>

					<div class="form-group">
						<label>Subtotal: &nbsp;</label>
						<div class="input-group">
							<div class="input-group-addon">&#8377;</div>
							<input type="number" onpaste="return false;" ondrop="return false;" disabled="disabled" onkeypress="return IsNumeric(event);" name="subTotal"
							placeholder="Subtotal" id="subTotal" class="form-control">
						</div>
					</div>
					<div class="form-group">
						<label> %: &nbsp;</label>
						<div class="input-group">
							<div class="input-group-addon">&#8377;</div>
							<input type="number" onpaste="return false;" ondrop="return false;" onkeypress="return IsNumeric(event);" placeholder="" name="discountPercent"
							 id="tax" class="form-control">
						</div>
					</div>
					<div class="form-group">
						<label>DA : &nbsp;</label>
						<div class="input-group">
							<input type="number"  onpaste="return false;" ondrop="return false;" disabled="disabled" onkeypress="return IsNumeric(event);" name="disacountAmount"
							placeholder="" id="taxAmount" class="form-control">
							<div class="input-group-addon">%</div>
						</div>
					</div>
					<div class="form-group" style="visibility: hidden;">
						<label>Total: &nbsp;</label>
						<div class="input-group">
							<div class="input-group-addon">&#8377;</div>
							<input type="number"  onpaste="return false;" ondrop="return false;" onkeypress="return IsNumeric(event);" placeholder="Total" name="totalAfterAmount"
							 id="totalAftertax" class="form-control">
						</div>
					</div>
				</fieldset>
			
			</div>
				<div  align="center">
					<a href="#" class="btn-big-red submitClass" id="submitPage" >Print</a>
					<input type="hidden" class="alertClass">
				</div>
      		</div>
    </div>			
</c:if>
</form>

	</sec:authorize>
	
	
    <script src="<c:url value="/resources/js/jquery-1.11.2.min.js"/>"></script>
    <script src="<c:url value="/resources/js/jquery-ui.min.js"/>"></script>
    <script src="<c:url value="/resources/js/bootstrap.min.js"/>"></script>
    <script src="<c:url value="/resources/js/bootstrap-datepicker.js"/>"></script>
    <script src="<c:url value="/resources/js/ajax.js"/>"></script>	
    <script src="<c:url value="/resources/js/enter2tab.js"/>"></script>
    <script src="<c:url value="/resources/js/jquery-confirm.min.js"/>"></script>
    <script src="<c:url value="/resources/js/ie.js"/>"></script>
	    <script>
        $("fieldset").enableEnterToTab({ captureTabKey: true });
        //$("#totalAmountDiv").enableEnterToTab({ captureTabKey: true });
    </script>
	
</body>
</html>