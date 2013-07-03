exports.Graphic = class Graphic
  constructor: (@sprite_) ->
    @pos_ = { x: 0, y: 0 }
    @animating_ = false

  setPos: (@pos_) ->

  draw: (ctx) ->
    return unless @isLoaded_()
    x = @pos_.x - @sprite_.frameW / 2
    y = @pos_.y - @sprite_.frameH / 2
    @sprite_.draw ctx, x, y

  getFrame: ->
    @sprite_.getFrame().col

  runOnce: ->
    return unless @isLoaded_()
    @animating_ = true
    @sprite_.runLoop -> @loopDone_ = true

  isAnimating: ->
    @animating_

  isLoaded_: ->
    @sprite_.frameW?
