


$(document).ready(function(){
	$("#itemName_1").focus();
});

$(document).load(function(){
	$("#itemName_1").focus();
});

/**
 * Site : http:www.smarttutorials.net
 * @author muni
 */
	
$(function() {
            $('input:text:first').focus();
            var $inp = $('input:text');
            $inp.bind('keydown', function(e) {
                //var key = (e.keyCode ? e.keyCode : e.charCode);
                var key = e.which;
                if (key == 13) {
                    e.preventDefault();
                    var nxtIdx = $inp.index(this) + 1;
                    $(":input:text:eq(" + nxtIdx + ")").focus();
                }
            });
        });

$(document).on('keydown', function ( e ) {
    // You may replace `c` with whatever key you want
    if ( (e.metaKey || e.ctrlKey) && ( String.fromCharCode(e.which) === '1' || String.fromCharCode(e.which) === '1' ) ) {
        console.log( "You pressed CTRL + 1" );
        $("#tax").focus();
    }else  if ( (e.metaKey || e.ctrlKey) && ( String.fromCharCode(e.which) === '2' || String.fromCharCode(e.which) === '2' ) ) {
        console.log( "You pressed CTRL + 2" );
        $("#mobileNo").focus();
    }else  if ( (e.metaKey || e.ctrlKey) && ( String.fromCharCode(e.which) === '3' || String.fromCharCode(e.which) === '3' ) ) {
        console.log( "You pressed CTRL + 3" );
        $("#submitPage").click();
    }
   });

//adds extra table rows
var i=$('table tr').length;
var nextPointer = 4;
$(".addmore").on('click',function(){
	html = '<tr>';
	html += '<td><input class="case" type="checkbox"/></td>';
	html += '<td><input type="text"  disabled="disabled" data-type="productCode" name="itemNo[]" id="itemNo_'+i+'" class="form-control autocomplete_txt" autocomplete="off"></td>';
	html += '<td><input type="text" style="text-align: center;color: black;"  tabindex="'+nextPointer++ +'" data-type="productName" name="itemName[]" id="itemName_'+i+'" class="form-control autocomplete_txt" autocomplete="off"></td>';
	html += '<td><input type="text" onfocus="this.select();" tabindex="'+nextPointer++ +'" name="price[]" id="price_'+i+'" style="text-align:center; background-color:black; font-stretch: wider;color: red;font-size-adjust: none;font-style: oblique;" class="form-control changesNo" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;"></td>';
	html += '<td><input type="text" onfocus="this.select();" tabindex="'+nextPointer++ +'" name="quantity[]" id="quantity_'+i+'" style="text-align:center;background-color:black; font-stretch: wider;color: yellow;font-size-adjust: none;font-style: oblique;" class="form-control changesNo" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;"></td>';
	html += '<td><input type="text" disabled="disabled" onfocus="this.select();" name="total[]" id="total_'+i+'" class="form-control totalLinePrice" autocomplete="off" onkeypress="return IsNumeric(event);" ondrop="return false;" onpaste="return false;"></td>';
	html += '</tr>';
	$('table').append(html);
	i++;
});

 

//to check all checkboxes
$(document).on('change','#check_all',function(){
	$('input[class=case]:checkbox').prop("checked", $(this).is(':checked'));
});

//deletes the selected table rows
$(".delete").on('click', function() {
	$('.case:checkbox:checked').parents("tr").remove();
	$('#check_all').prop("checked", false); 
	calculateTotal();
});


var prices = ["1|BABIES|",
              "2|PANT SHIRT|",	
              "3|DRAWER SHIRT|",
              "4|JEANS|",
              "6|T.SHIRT",
              "7|WESTERN",
              "8|FROCK",
              "9|CHUDI",
              "10|MIDI",
              "11|CHUDI MATERIAL",
              "12|TOPS",
              "13|LEGGINGS",
              "14|BRA",
              "16|GENTS BRIEF",
              "17|NIGHT SUIT",
              "18|BANIAN",
              "19|PANTIES",
              "20|DRAWER",
              "21|KERCHIEF",
              "22|SIMMI",
              "23|SWEATER",
              "24|SCARF",
              "25|CAP",
              "26|P.CORT",
              "28|GIFT BOX",
              "30|LUNGI",
              "32|TITES",
              "33|ORNI"
];

//autocomplete script
$(document).on('focus','.autocomplete_txt',function(){
	type = $(this).data('type');
	
	if(type =='productCode' )autoTypeNo=0;
	if(type =='productName' )autoTypeNo=1; 	
	
	$(this).autocomplete({
		source: function( request, response ) {	 
			 var array = $.map(prices, function (item) {
                 var code = item.split("|");
                 return {
                     label: code[autoTypeNo],
                     value: code[autoTypeNo],
                     data : item
                 }
             });
             //call the filter here
             response($.ui.autocomplete.filter(array, request.term));
		},
		autoFocus: true,	      	
		minLength: 1,
		select: function( event, ui ) {
			var names = ui.item.data.split("|");						
			id_arr = $(this).attr('id');
	  		id = id_arr.split("_");
			$('#itemNo_'+id[1]).val(names[0]);
			$('#itemName_'+id[1]).val(names[1]);
			$('#quantity_'+id[1]).val(1);
			$('#price_'+id[1]).val(names[2]);
			$('#total_'+id[1]).val( 1*names[2] );
			calculateTotal();
		}		      	
	});
});

//price change
$(document).on('change keyup blur','.changesNo',function(){
	id_arr = $(this).attr('id');
	id = id_arr.split("_");
	quantity = $('#quantity_'+id[1]).val();
	price = $('#price_'+id[1]).val();
	if( quantity!='' && price !='' ) $('#total_'+id[1]).val( (parseFloat(price)*parseFloat(quantity)).toFixed(2) );	
	calculateTotal();
});

$(document).on('change keyup blur','#tax',function(){
	calculateTotal();
});

//total price calculation 
function calculateTotal(){
	subTotal = 0 ; total = 0; 
	$('.totalLinePrice').each(function(){
		if($(this).val() != '' )subTotal += parseFloat( $(this).val() );
	});
	$('#subTotal').val( subTotal.toFixed(2) );
	tax = $('#tax').val();
	if(tax != '' && typeof(tax) != "undefined" ){
		taxAmount = subTotal * ( parseFloat(tax) /100 );
		$('#taxAmount').val(taxAmount.toFixed(2));
		total = subTotal - taxAmount;
	}else{
		$('#taxAmount').val(0);
		total = subTotal;
	}
	$('#totalAftertax').val( total.toFixed(2) );
	calculateAmountDue();
}

$(document).on('change keyup blur','#amountPaid',function(){
	calculateAmountDue();
});

//due amount calculation
function calculateAmountDue(){
	amountPaid = $('#amountPaid').val();
	total = $('#totalAftertax').val();
	if(amountPaid != '' && typeof(amountPaid) != "undefined" ){
		amountDue = parseFloat(total) - parseFloat( amountPaid );
		$('.amountDue').val( amountDue.toFixed(2) );
	}else{
		total = parseFloat(total).toFixed(2);
		$('.amountDue').val( total);
	}
}


//It restrict the non-numbers
var specialKeys = new Array();
specialKeys.push(8,46,37,39); //Backspace
function IsNumeric(e) {
    var keyCode = e.which ? e.which : e.keyCode;
    console.log( keyCode );
    var ret = ((keyCode >= 48 && keyCode <= 57) || specialKeys.indexOf(keyCode) != -1);
    return ret;
}

//datepicker
$(function () {
	$.fn.datepicker.defaults.format = "dd-mm-yyyy";
    $('#invoiceDate').datepicker({
        startDate: '-3d',
        autoclose: true,
        clearBtn: true,
        todayHighlight: true
    });
});

var serverResponse = "";

$('.alertClass').on('click', function () {
	$.confirm({
	    title: 'Thank You !!!',
	    content: 'Prining is in Progress !!!.<br/> '+ serverResponse +" <br> <br> The Page will be refreshed in 5 Sec",
	    autoClose: 'confirm|6000',
	    keyboardEnabled: true,
	    confirm: function(){
	    	location.reload(true);
	    },
	    cancel:function(){
	        //alert('canceled');
	    }
	});
});

$('.submitClass').on('click', function () {
	$.confirm({
	    keyboardEnabled: true,
	    content: '<br><b><h2>Print &#2970;&#3014;&#2991;&#3021;&#2991;&#2994;&#3006;&#2990;&#3006; ? </h2></b> </br>',
	    cancel: function(){
	    	
	    },
	    confirm: function(){
	    	params= {
	    			'subTotal':   $('input[name="subTotal"]').val(),
	    		    'disacountAmount':   $('input[name="disacountAmount"]').val(),   
	    		    'discountPercent':   $('input[name="discountPercent"]').val(),
	    		    'totalAfterAmount':   $('input[name="totalAfterAmount"]').val(),  
	    		    'mobile':   $('input[name="mobile"]').val(), 
	    		    'itemNo': $('input[name="itemNo[]"]').map(function() {
		    		       return $(this).val(); }).get().join(),
	    		    'itemName': $('input[name="itemName[]"]').map(function() {
		    		       return $(this).val(); }).get().join(),
	    		    'price': $('input[name="price[]"]').map(function() {
		    		       return $(this).val(); }).get().join(),
	    		    'quantity': $('input[name="quantity[]"]').map(function() {
		    		       return $(this).val(); }).get().join(),
	    		    'total': $('input[name="total[]"]').map(function() {
		    		       return $(this).val(); }).get().join(),		    		       
	    		        
	    		    'noCacheRandom' : 1+ Math.random() };
	    		     
	    	
	    	$.get( "save", params ,function(data, textStatus)
        {
                //alert("Response from server: " + data);
	    		serverResponse = data;
                $(".alertClass").click();
        });

	    		  
	    		  
	    },
	    confirmButton: '\u0b86\u0bae\u0bcd',
	    cancelButton: '\u0b87\u0bb2\u0bcd\u0bb2\u0bc8 !!',
	    confirmButtonClass: 'btn-info',
	    cancelButtonClass: 'btn-danger',
	    theme: 'black',
	    closeAnimation: 'rotatey',
	    animationBounce: 2.5,
	    animationSpeed: 2000,
	    autoClose: 'cancel|6000',
	    title: 'Alert',
	    title: false
	});
});




