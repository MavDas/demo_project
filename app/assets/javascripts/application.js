// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require dataTables/jquery.dataTables
//= require foundation
//= require sweetalert2
//= require sweet-alert2-rails
//= require_tree .

$(function(){ $(document).foundation(); });
$(document).foundation('offcanvas', 'reflow');

$(document).ready(function(){
	$('#users-table').dataTable({
		"aLengthMenu": [[5,10,15,20,-1], [5,10,15,20,"All"]],
		"iDisplayLength": 5
	});
	//sPaginationType: "simple"
	bJQueryUI: true
});

$(document).ready(function(){
	$('#roles-table').dataTable({
		"aLengthMenu": [[5,10,15,20,-1], [5,10,15,20,"All"]],
		"iDisplayLength": 5
	});
	//sPaginationType: "simple"
	bJQueryUI: true
});

$(document).ready(function(){
	$('#items-table').dataTable({
		"aLengthMenu": [[5,10,15,20,-1], [5,10,15,20,"All"]],
		"iDisplayLength": 5
	});
	//sPaginationType: "simple"
	bJQueryUI: true
});
