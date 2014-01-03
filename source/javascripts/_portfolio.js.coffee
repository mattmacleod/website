@app.portfolio =

  setup: ->
    intro_panel = $('#fest-portfolio-page .portfolio-intro')
    galleries   = $(".portfolio-gallery")

    return if Modernizr.touch

    $(window).off("scroll").on "scroll", ->
      pos = $(window).scrollTop()
      window_height = $(window).height()

      # Offset the intro image
      $('#fest-portfolio-page .portfolio-intro').css "background-position", "0 -#{ pos/3 }px"

      # If the galleries are in view, offset by up to 10% divided by the amount that they're in view...
      galleries.each ->
        gallery = $(this)
        gallery_top    = gallery[0].offsetTop
        gallery_height = gallery.height()

        # Do nothing unless the gallery is visible
        return unless ((gallery_top + gallery_height) > pos) && (gallery_top < (pos + window_height))

        max_offset = gallery_height / 3

        # Current distance from the top of the page as percentage
        gallery_position = (gallery_top + gallery_height - pos) / window_height

        # Translate to an offset
        offset_amount = (gallery_position * max_offset) - (max_offset/2) 

        console.log "#{gallery_position} => #{offset_amount}"
        gallery.find("img").css "-webkit-transform", "scale(1.5) translateY(#{ offset_amount }px)"
