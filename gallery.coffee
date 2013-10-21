class window.Gallery

  displays: []
  thumbnails: []
  currentIndex: -1

  onReachEnd: null
  onReachBeginning: null

  constructor: (@thubmailsListing, @displayListing, @thumbnailsElement, @displayElement, @thumbsDisplayed = 3) ->
    @_createThumbnails()
    @_createDisplay()

  _createThumbnails: ->
    $.each @thubmailsListing, (index, url) =>
      clickHandler = $.proxy @display, @, index
      thumbnail = new Thumbnail url, clickHandler
      thumbnail.element.appendTo @thumbnailsElement
      @thumbnails.push thumbnail
      return
    return

  _createDisplay: ->
    $.each @displayListing, (index, url) =>
      li = $('<li></li>')
      img = $('<img>').attr 'src', url
      img.appendTo li
      li.appendTo @displayElement
      @displays.push li
      return
    return

  _getPositionAt: (index, elementList) ->
    height = 0
    $.each elementList, (i, item) ->
      element = if item.element then item.element else item
      height += element.height() if i < index
      return
    return height

  previous: ->
    @display Math.max @currentIndex - 1, 0
    return

  next: ->
    @display Math.min @currentIndex + 1, @thumbnails.length - 1
    return

  display: (index) ->
    return if index is @currentIndex
    @thumbnailsElement.animate scrollTop: "#{Math.max @_getPositionAt(index - @thumbsDisplayed + 1, @thumbnails), 0}px"
    @displayElement.animate scrollTop: "#{@_getPositionAt index, @displays}px"
    @thumbnails[@currentIndex].setSelected false if @currentIndex >= 0
    @thumbnails[index].setSelected true
    @currentIndex = index
    @onReachBeginning index is 0 if @onReachBeginning isnt null
    @onReachEnd index is @thumbnails.length - 1 if  @onReachEnd isnt null
    return

# represents a single thumbnail
class Thumbnail

  element: null

  constructor: (@thumbUrl, clickHandler) ->
    li = $('<li></li>')
    img = $('<img>').attr 'src', @thumbUrl
    img.appendTo li
    li.click clickHandler
    @element = li

  setSelected: (value) ->
    if value
      @element.addClass 'selected'
    else
      @element.removeClass 'selected'
    return