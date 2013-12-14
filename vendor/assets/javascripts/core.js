/* -------------------- Check Browser --------------------- */
function browser() {
	
	var isOpera = !!(window.opera && window.opera.version);  // Opera 8.0+
	var isFirefox = testCSS('MozBoxSizing');                 // FF 0.8+
	var isSafari = Object.prototype.toString.call(window.HTMLElement).indexOf('Constructor') > 0;
	    // At least Safari 3+: "[object HTMLElementConstructor]"
	var isChrome = !isSafari && testCSS('WebkitTransform');  // Chrome 1+
	//var isIE = /*@cc_on!@*/false || testCSS('msTransform');  // At least IE6

	function testCSS(prop) {
	    return prop in document.documentElement.style;
	}
	
	if (isOpera) {
		
		return false;
		
	}else if (isSafari || isChrome) {
		
		return true;
		
	} else {
		
		return false;
		
	}
	
}

/* ---------- Main Menu Open/Close ---------- */
jQuery(document).ready(function($){
	
	var startFunctions = true;
	
	$('#main-menu-toggle').click(function(){
		
		if($(this).hasClass('open')){
			
			$(this).removeClass('open').addClass('close');
			
			var span = $('#content').attr('class');
			var spanNum = parseInt(span.replace( /^\D+/g, ''));
			var newSpanNum = spanNum + 1;
			var newSpan = 'span' + newSpanNum;
			
			$('#content').removeClass('span'+spanNum);
			$('#content').addClass(newSpan);
			$('#content').addClass('full-radius');
			$('#sidebar-left').hide();
			
		} else {
			
			$(this).removeClass('close').addClass('open');
			
			var span = $('#content').attr('class');
			var spanNum = parseInt(span.replace( /^\D+/g, ''));
			var newSpanNum = spanNum - 1;
			var newSpan = 'span' + newSpanNum;
	
			$('#sidebar-left').fadeIn();
			$('#content').removeClass('span'+spanNum);
			$('#content').removeClass('full-radius');
			$('#content').addClass(newSpan);
			
		}				
		
	});
	
});	

/* ---------- Sidebar Open/Close ---------- */
jQuery(document).ready(function($){
	
	var startFunctions = true;
	
	$('#widgets-area-button').click(function(){
		
		if($(this).hasClass('open')){
			
			$(this).removeClass('open').addClass('close');
			
			var span = $('#content').attr('class');
			var spanNum = parseInt(span.replace( /^\D+/g, ''));
			var newSpanNum = spanNum - 2;
			var newSpan = 'span' + newSpanNum;
			
			$('#content').removeClass('span'+spanNum);
			$('#content').addClass(newSpan);
			$('#widgets-area').fadeIn();

			if(startFunctions) {
				widget_area_functions();
				startFunctions = false;
			}
			
		} else {
			
			$(this).removeClass('close').addClass('open');
			
			var span = $('#content').attr('class');
			var spanNum = parseInt(span.replace( /^\D+/g, ''));
			var newSpanNum = spanNum + 2;
			var newSpan = 'span' + newSpanNum;
	
			$('#widgets-area').fadeOut();
			$('#content').removeClass('span'+spanNum);
			$('#content').addClass(newSpan);
			
		}				
		
	});
	
	$('#close-widgets-area').click(function(){
		
		var span = $('#content').attr('class');
		var spanNum = parseInt(span.replace( /^\D+/g, ''));
		var newSpanNum = spanNum + 2;
		var newSpan = 'span' + newSpanNum;

		$('#widgets-area').fadeOut();
		$('#content').removeClass('span'+spanNum);
		$('#content').addClass(newSpan);
		
		if($('#widgets-area-button').hasClass('open')){
			
			$('#widgets-area-button').removeClass('open').addClass('close');
			
		} else {
			
			$('#widgets-area-button').removeClass('close').addClass('open');
			
		}
				
	});
	
});

/* ---------- IE8 list style hack (:nth-child(odd)) ---------- */
jQuery(document).ready(function($){
	
	if($('.messagesList').width()) {
		
		if(jQuery.browser.version.substring(0, 2) == "8.") {

			$('ul.messagesList li:nth-child(2n+1)').addClass('odd');
			
		}
		
	}
	
});

/* -------------------- Buttons 3D Style --------------------- */
jQuery(document).ready(function($){
	
	$(':button').each(function(){
		
		
		if($(this).hasClass('btn3d')) {
			
			if($(this).parent().hasClass('input-append')) {
				
				//do nothing

			} else {
						
				var inner = $(this).html();
				
				if(browser()) {
			
					$(this).html('<span>' + inner + '</span>')
				
				}	
			
			}
			
		}
		
	});
		
});

/* ---------- Check Retina ---------- */
function retina(){
	
	retinaMode = (window.devicePixelRatio > 1);
	
	return retinaMode;
	
}

/* ---------- Chart ---------- */
function chart(){
	
	if($('.verticalChart')) {
		
		$('.singleBar').each(function(){
			
			var percent = $(this).find('.value span').html();
			
			$(this).find('.value').animate({height:percent}, 2000, function() {
			    
				$(this).find('span').fadeIn();
			 
			});
			
		});
		
	}
	
}

jQuery(document).ready(function($){
	
	/* ---------- Add class .active to current link  ---------- */
	$('ul.main-menu li a').each(function(){
		
			if($($(this))[0].href==String(window.location)) {
				
				$(this).parent().addClass('active');
				
			}
	
	});
	
	$('ul.main-menu li ul li a').each(function(){
		
			if($($(this))[0].href==String(window.location)) {
				
				$(this).parent().addClass('active');
				$(this).parent().parent().parent().addClass('active');
				$(this).parent().parent().show();
				
			}
	
	});

	/* ---------- Submenu  ---------- */

	$('.dropmenu').click(function(e){

		e.preventDefault();

		$(this).parent().find('ul').slideToggle();

	});

});

/* ---------- Login Form Functions ---------- */

jQuery(document).ready(function($){

	$("#username").focus(function() {

		$(this).parent(".input-prepend").addClass("input-prepend-focus");

	});

	$("#username").focusout(function() {

		$(this).parent(".input-prepend").removeClass("input-prepend-focus");

	});

	$("#password").focus(function() {

		$(this).parent(".input-prepend").addClass("input-prepend-focus");

	});

	$("#password").focusout(function() {

		$(this).parent(".input-prepend").removeClass("input-prepend-focus");

	});

});