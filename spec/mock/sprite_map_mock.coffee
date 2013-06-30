exports.SpriteMap = class SpriteMap
  constructor: (@path, @animations, @options)  ->
    @finishLoading()
    @frame_ = 0

  draw: (context, x, y) ->
    @throwIfNotLoaded()

  sprite:
    frameW: 16
    frameH: 20

  use: (@activeLoop) ->
    @throwIfNotLoaded()
    @animating_ = false
    @frame_ = 0

  start: (@activeLoop=@activeLoop) ->
    @throwIfNotLoaded()
    @animating_ = true
    @frame_ = Math.floor(Math.random() * 10)

  stop: ->
    @animating_ = false

  reset: ->
    @frame_ = 0

  getFrame: ->
    @frame_

  isAnimating: ->
    @animating_

  isFinishedLoading: ->
    @baseImage?

  finishLoading: ->
    @baseImage = 'loaded'

  unload: ->
    @baseImage = null

  throwIfNotLoaded: ->
    throw 'not loaded' unless @isFinishedLoading()
