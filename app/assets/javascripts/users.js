$(function(){

	$(".user-approved").change(function(){
		var approval = $(this).is(':checked'); 
		var url = $(this).attr('data-url');
		if (this.checked){
			alert("Checked");
			$.ajax({
				url: url,
				type: 'PATCH',
				data: {"approved": approval}	
			});
		}
		else{
			alert("Unchecked");
			$.ajax({
				url: url,
				type: 'PATCH',
				data: {"approved": approval}	
			});
		}
		
	});
});