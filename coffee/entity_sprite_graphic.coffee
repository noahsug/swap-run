{EntityGraphic} = require "../coffee/entity_graphic.coffee"

exports.EntitySpriteGraphic = class EntitySpriteGraphic extends EntityGraphic
  constructor: (@spriteMap_) ->

  setEntity: (@entity_) ->
    @update()

  getWidth: ->
    if @width_?
      @width_
    else if @isLoaded_()
      @spriteMap_.sprite.frameW
    else
      super()

  getHeight: ->
    if @height_?
      @height_
    else if @isLoaded_()
      @spriteMap_.sprite.frameH
    else
      super()

  getOffset: ->
    super()

  draw: (context) ->
    return unless @isLoaded_()
    pos = @getPos()
    pos = @adjustPosForModifiedWidthOrHeight_ pos
    @spriteMap_.draw context, pos.x, pos.y

  adjustPosForModifiedWidthOrHeight_: (pos) ->
    x = pos.x
    y = pos.y
    if @width_?
      x -= (@spriteMap_.sprite.frameW - @width_) / 2
    if @height_?
      y -= (@spriteMap_.sprite.frameH - @height_) / 2
    { x, y }

  update: ->
    return unless @isLoaded_()
    desiredAnimation = @getDesiredAnimation_()
    if @spriteMap_.activeLoop isnt desiredAnimation
      if desiredAnimation is 'death'
        @spriteMap_.use desiredAnimation
        @spriteMap_.runOnce()
      else
        @spriteMap_.start desiredAnimation

  isLoaded_: ->
    @spriteMap_.baseImage?

  getDesiredAnimation_: ->
    return 'death' unless @entity_.isActive()
    stillSuffix = if @entity_.isMoving() then '' else '-still'
    @entity_.getDirection() + stillSuffix
