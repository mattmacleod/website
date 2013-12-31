window.app = 
		
	setup: ->
		$("html").removeClass("loading").addClass("loaded")

$(document).on "ready", app.setup
