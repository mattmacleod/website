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
    $.ajax
      url: url
      success: (data) ->
        values = window.app.content.process_content_for_overlay data
        console.log values
        $('#page-overlay').html values.content

  open_blog_post: (url) ->
    @load_url_in_overlay url

  process_content_for_overlay: (content) ->

    # Create an HTML document
    doc = document.implementation.createHTMLDocument ''
    doc.open 'replace'
    doc.write content
    doc.close()

    # Extract the interesting bits we're concerned with
    content_tree = $(doc)
    title = content_tree.find("title").html()
    content = content_tree.find("#structure-content").html()
    return {
      title: title
      content: content
    }
