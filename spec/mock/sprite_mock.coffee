exports.Sprite = class Sprite

  constructor: ->
    @load()

  draw: ->

  frameNumberToRowCol: (num) ->
    { row: 0, col: num }

  setFrame: (@frame_) ->
  getFrameNum: -> @frame_

  load: ->
    @frameW = 10
    @frameH = 10

  unload: ->
    @frameW = null
