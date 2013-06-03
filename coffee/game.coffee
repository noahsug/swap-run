exports.Game = class Game extends atom.Game
  @SPEED = 300

  constructor: ->
    super
    atom.input.bind atom.key.LEFT_ARROW, 'left'
    atom.input.bind atom.key.A, 'left'

    atom.input.bind atom.key.RIGHT_ARROW, 'right'
    atom.input.bind atom.key.D, 'right'

    @leftWidth_ = atom.width / 2

  update: (dt) ->
    if atom.input.down 'left'
      @leftWidth_ -= Game.SPEED * dt
    if atom.input.down 'right'
      @leftWidth_ += Game.SPEED * dt

    @leftWidth_ = util.bound @leftWidth_, 0, atom.width

  draw: ->
    atom.context.fillStyle = 'black'
    atom.context.fillRect 0, 0, atom.width, atom.height
    atom.context.fillStyle = 'white'
    atom.context.fillRect 0, 0, @leftWidth_, atom.height
