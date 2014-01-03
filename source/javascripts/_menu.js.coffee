@app.menu =

  setup: ->

    menu = $('#structure-header .menu')
    menu.off('click').on 'click', ->
      menu.toggleClass 'menu-visible'

    $("a[href='#panel-contact']").on 'click', (e) ->      
      $("#structure-content").addClass("fade")
      window.setTimeout ->
        $(window).on "scroll", ->
          $("#structure-content").removeClass "fade"
        $("body").on "touchstart", ->
          $("#structure-content").removeClass "fade"
      , 500
