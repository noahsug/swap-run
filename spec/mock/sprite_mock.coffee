exports.Sprite = class Sprite

  @preloadImages: (images) ->
    @preloadedImages ?= []
    @preloadedImages.push images...

  constructor: ->
    @load()
    @interval = 125

  draw: ->

  runLoop: ->

  frameNumberToRowCol: (num) ->
    { row: 0, col: num }

  setFrame: (@frame_) ->
  getFrameNum: -> @frame_

  load: ->
    @frameW = 20
    @frameH = 20

  unload: ->
    @frameW = null
