// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require sip/motor
//= require sivel2_gen/motor
//= require sivel2_sjr/motor
//= require cor1440_gen/motor
//= require sal7711_gen/motor
//= require chartkick
//= require_tree .

$(document).on('turbolinks:load ready page:load', function() {
	var root;
	root = typeof exports !== "undefined" && exports !== null ? 
		exports : window;
	sip_prepara_eventos_comunes(root);
	sivel2_gen_prepara_eventos_comunes(root,'antecedentes/causas');
	sivel2_sjr_prepara_eventos_comunes(root);
	cor1440_gen_prepara_eventos_comunes(root);
	sal7711_gen_prepara_eventos_comunes(root);
	sivel2_sjr_prepara_eventos_unicos(root);

	formato_fecha = 'yyyy-mm-dd'
	if ($('meta[name=formato_fecha]') != []) {
		formato_fecha = $('meta[name=formato_fecha]').attr('content')
	}
	$('[data-behaviour~=datepicker]').datepicker({
		format: formato_fecha,
		autoclose: true,
		todayHighlight: true,
		language: 'es'	
	});
});

/*jQuery.ajaxSetup({
	beforeSend: function(xhr) {
		$('#spinner').show();
	},
	// runs after AJAX requests complete, successfully or not
	complete: function(xhr, status) {
		$('#spinner').hide();
	}
}); */
