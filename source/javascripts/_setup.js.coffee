@app = 
    
  setup: ->
    $("html").removeClass("loading").addClass("loaded")
    window.app.menu.setup()

$(document).on "ready", app.setup
