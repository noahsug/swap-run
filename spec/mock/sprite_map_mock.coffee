{Sprite} = require "../../spec/mock/sprite_mock.coffee"

exports.SpriteMap = class SpriteMap
  constructor: (@path, @animations, @options)  ->
    @finishLoading()
    @frame_ = 0
    @runningOnce_ = false
    @sprite = new Sprite

  draw: (context, x, y) ->
    @throwIfNotLoaded()

  use: (@activeLoop) ->
    @throwIfNotLoaded()
    @animating_ = false
    @runningOnce_ = false
    @frame_ = 0

  start: (@activeLoop=@activeLoop) ->
    @throwIfNotLoaded()
    @animating_ = true
    @runningOnce_ = false
    @frame_ = Math.floor(Math.random() * 10)

  runOnce: (@activeLoop=@activeLoop) ->
    @throwIfNotLoaded()
    @runningOnce_ = true
    @animating_ = true
    @frame_ = Math.floor(Math.random() * 10)

  stop: ->
    @animating_ = false
    @runningOnce_ = false

  reset: ->
    @frame_ = 0

  getFrame: ->
    @frame_

  isAnimating: ->
    @animating_

  isRunningOnce: ->
    @runningOnce_

  isFinishedLoading: ->
    @baseImage?

  finishLoading: ->
    @baseImage = 'loaded'

  unload: ->
    @baseImage = null

  throwIfNotLoaded: ->
    throw 'not loaded' unless @isFinishedLoading()
