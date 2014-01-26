@app = 
    
  setup: ->
    $("html").removeClass("loading").addClass("loaded")
    window.app.menu.setup()
    window.app.portfolio.setup()

$(document).on "ready page:load", @app.setup

$(document).on 'page:change', ->
  if window.ga
    window.ga 'send', 'pageview'
