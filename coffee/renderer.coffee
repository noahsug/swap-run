{SpriteMap} = require "../spec/mock/sprite_map_mock.coffee"

exports.Renderer = class Renderer
  constructor: ->
    @prevGameState = 'started'

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
    atom.context.fillStyle = '2E2E2E'
    atom.context.fillRect 0, 0, atom.width, atom.height

  drawEntities_: ->
    @game_.getPlayer().draw atom.context
    for enemy in @game_.getEnemies()
      enemy.draw atom.context

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
