exports.EntityGraphic = class EntityGraphic

  setEntity: (@entity_) ->

  draw: (context) ->

  update: ->

  getPos: ->
    {
      x: @entity_.getPos().x - @getWidth() / 2 + @getOffset().x,
      y: @entity_.getPos().y - @getHeight() / 2 + @getOffset().y
    }

  getOffset: ->
    @offset_ ? { x: 0, y: 0 }

  setOffset: (@offset_) ->

  setWidth: (@width_) ->

  getWidth: ->
    @width_ ? @entity_.getRadius() * 2

  setHeight: (@height_) ->

  getHeight: ->
    @height_ ? @entity_.getRadius() * 2
