{EntityGraphic} = require "../coffee/entity_graphic.coffee"

exports.EntitySpriteGraphic = class EntitySpriteGraphic extends EntityGraphic

  constructor: (@spriteMap_) ->

  setEntity: (@entity_) ->
    return unless @isLoaded_()
    @spriteMap_.start @getDesiredAnimation_()

  draw: (context) ->
    return unless @isLoaded_()
    x = @entity_.getPos().x - @spriteMap_.sprite.frameW / 2
    y = @entity_.getPos().y - @spriteMap_.sprite.frameH / 2
    @spriteMap_.draw context, x, y

  update: ->
    return unless @isLoaded_()
    desiredAnimation = @getDesiredAnimation_()
    if @spriteMap_.activeLoop isnt desiredAnimation
      @spriteMap_.start desiredAnimation

  isLoaded_: ->
    @spriteMap_.baseImage?

  getDesiredAnimation_: ->
    stillSuffix = if @entity_.isMoving() then '' else '-still'
    @entity_.getDirection() + stillSuffix
