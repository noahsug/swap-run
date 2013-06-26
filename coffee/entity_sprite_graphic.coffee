{EntityGraphic} = require "../coffee/entity_graphic.coffee"

exports.EntitySpriteGraphic = class EntitySpriteGraphic extends EntityGraphic

  constructor: (@spriteMap_) ->

  setEntity: (@entity_) ->
    return unless @isLoaded_()
    @spriteMap_.use @entity_.getDirection()

  draw: (context) ->
    return unless @isLoaded_()
    x = @entity_.getPos().x - @spriteMap_.sprite.frameW / 2
    y = @entity_.getPos().y - @spriteMap_.sprite.frameH / 2
    @spriteMap_.draw context, x, y

  update: ->
    return unless @isLoaded_()
    if @spriteMap_.activeLoop isnt @entity_.getDirection()
      @spriteMap_.use @entity_.getDirection()
      if @entity_.isMoving() and not @entity_.startedMoving()
        @spriteMap_.start()
    if not @entity_.isMoving()
      @spriteMap_.stop()
      @spriteMap_.reset()
    if @entity_.startedMoving()
      @spriteMap_.start()

  isLoaded_: ->
    @spriteMap_.baseImage?
