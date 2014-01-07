@app.portfolio =

  setup: ->
    @handle_scroll()
    @handle_back_to_top()

  handle_back_to_top: ->
    $("#back_to_top_link").off("click").on "click", ->
      $('html, body').scrollTo();

  handle_scroll: ->
    intro_panel = $('#fest-portfolio-page .portfolio-intro')
    galleries   = $(".portfolio-gallery")
    link        = $("#back_to_top_link")

    return if Modernizr.touch

    $(window).off("scroll resize").on "scroll resize", ->
      pos = $(window).scrollTop()
      window_height = $(window).height()

      # Offset the intro image
      $('.portfolio-intro').css "background-position", "center -#{ pos/3 }px"

      # If the galleries are in view, offset by up to 10% divided by the amount that they're in view...
      galleries.each ->
        gallery = $(this)
        gallery_top    = gallery[0].offsetTop
        gallery_height = gallery.height()

        # Do nothing unless the gallery is visible
        return unless ((gallery_top + gallery_height) > pos) && (gallery_top < (pos + window_height))

        max_offset = gallery_height / 4

        # Current distance from the top of the page as percentage
        gallery_position = (gallery_top + gallery_height - pos) / window_height

        # Translate to an offset
        offset_amount = -1 * ((gallery_position * max_offset) - (max_offset/2)) 

        gallery.find("img").css "-webkit-transform", "scale(1.34) translateY(#{ offset_amount }px)"


      if pos > 600
        link.show()
        window.setTimeout ->
          link.addClass "visible"
        , 200
      else
        link.removeClass "visible"
        window.setTimeout ->
          link.hide()
        , 200
