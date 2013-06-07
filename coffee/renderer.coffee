exports.Renderer = class Renderer

  draw: (@player_) ->
    @drawBackground_()
    @drawPlayer_()

  drawBackground_: ->
    atom.context.fillStyle = 'black'
    atom.context.fillRect 0, 0, atom.width, atom.height

  drawPlayer_: ->
    radius = @scale_ @player_.getRadius()
    x = @player_.getPos().x
    y = @player_.getPos().y
    atom.context.beginPath()
    atom.context.arc x, y, radius, 0, 2 * Math.PI
    atom.context.closePath()
    atom.context.fillStyle = 'white'
    atom.context.fill()

  scale_: (value) ->
    value * (atom.width + atom.height) / 100
