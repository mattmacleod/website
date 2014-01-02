@app = 
    
  setup: ->
    $("html").removeClass("loading").addClass("loaded")
    window.app.content.setup()

$(document).on "ready", app.setup
