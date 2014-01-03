@app.menu =

  setup: ->

    menu = $('#structure-header .menu')
    menu.off('click').on 'click', ->
      menu.toggleClass 'menu-visible'
