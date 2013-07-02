exports.Sprite = class Sprite

  constructor: ->
    @load()

  draw: ->

  frameNumberToRowCol: (num) ->
    { row: 0, col: num }

  setFrame: (@frame_) ->
  getFrameNum: -> @frame_

  load: ->
    @frameW = 20
    @frameH = 20

  unload: ->
    @frameW = null
