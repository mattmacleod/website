# Responsible for managing the loading and display of content
# like the blog and portfolio
@app.content =
  
  setup: ->

    # Always close overlay when it's clicked
    $('#structure-content').on 'click', ->
      window.app.content.hide_overlay()

    blog_listing = $('#panel-blog')
    blog_listing.on 'click', 'a', (e) ->
      console.debug()
      e.preventDefault()
      e.stopPropagation()
      window.app.content.open_blog_post this.href

  show_overlay: ->
    $('#structure-content').addClass "overlay-opened"
    overlay = $("<div id='page-overlay'/>")
    $('body').append overlay
    window.setTimeout ->
      overlay.addClass "visible"
    , 50

  hide_overlay: ->
    $('#structure-content').removeClass "overlay-opened"
    overlay = $('#page-overlay')
    overlay.removeClass "visible"
    window.setTimeout ->
      overlay.remove()
    , 300

  load_url_in_overlay: (url) ->
    window.app.content.show_overlay()
    console.log url
    $.ajax
      url: url
      success: (data) ->
        console.log "I'm here"
        console.log data
        $('#page_overlay').html data
      error: (data) ->
        console.log "error"

  open_blog_post: (url) ->
    @load_url_in_overlay url
