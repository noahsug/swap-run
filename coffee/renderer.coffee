{Sprite} = require "../spec/mock/sprite_mock.coffee"
{SpriteMap} = require "../spec/mock/sprite_map_mock.coffee"

exports.Renderer = class Renderer
  constructor: ->
    @loadedAllSprites_ = false
    @spriteMap_ = new SpriteMap '../assets/femaleleatherpreview_0.png', {
      'up':
        startRow: 8
        endRow: 8
        endCol: 8
      'left':
        startRow: 9
        endRow: 9
        endCol: 8
      }, {
        frameW: 64
        frameH: 64
        postInitCallback: =>
          @spriteMap_.use 'up'
          @spriteMap_.start()
          @loadedAllSprites_ = true
      }

  draw: (@game_) ->
    switch @game_.getState()
      when 'playing'
        @drawPlayScreen_()
      when 'lost'
        @drawScoreScreen_()

  drawPlayScreen_: ->
    @drawBackground_()
    @drawPlayer_()
    @drawEnemies_()

  drawBackground_: ->
    atom.context.fillStyle = '2E2E2E'
    atom.context.fillRect 0, 0, atom.width, atom.height

  drawPlayer_: ->
    player = @game_.getPlayer()
    x = player.getPos().x - @spriteMap_.sprite.frameW / 2
    y = player.getPos().y - @spriteMap_.sprite.frameH / 2
    if @loadedAllSprites_
      @spriteMap_.draw atom.context, x, y

  drawEnemies_: ->
    atom.context.fillStyle = 'red'
    for enemy in @game_.getEnemies()
      @drawEntity_ enemy

  drawEntity_: (entity) ->
    x = entity.getPos().x
    y = entity.getPos().y
    atom.context.beginPath()
    atom.context.arc x, y, entity.getRadius(), 0, 2 * Math.PI
    atom.context.closePath()
    atom.context.fill()

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
