{GraphicFactory} = require "../coffee/graphic_factory.coffee"

exports.Renderer = class Renderer
  constructor: ->
    @backgroundGraphic_ = GraphicFactory.create 'background'

  draw: (@game_) ->
    switch @game_.getState()
      when 'playing'
        @drawPlayScreen_()
      when 'lost'
        @drawScoreScreen_()

  drawPlayScreen_: ->
    @drawBackground_()
    @drawEntities_()

  drawBackground_: ->
    atom.context.clearRect 0, 0, atom.width, atom.height
    @backgroundGraphic_.fill atom.context, 0, 0, atom.width, atom.height

  drawEntities_: ->
    for entity in @game_.getEntities().sort @entityYCoordSort_
      entity.draw atom.context

  entityYCoordSort_: (e1, e2) ->
    e1.getPos().y > e2.getPos().y

  drawScoreScreen_: ->
    @drawPlayScreen_()
    atom.context.setAlpha .75
    atom.context.fillStyle = 'black'
    atom.context.fillRect 0, 0, atom.width, atom.height
    atom.context.setAlpha 1
    atom.context.fillStyle = 'white'
    @drawScore_()

  drawScore_: ->
    atom.context.textAlign = "center"
    atom.context.font = "100px helvetica"
    atom.context.fillText "score: #{@game_.getScore()}", atom.width / 2, atom.height / 2
