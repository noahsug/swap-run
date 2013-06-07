exports.keybindings =
  configure: ->
    atom.input.bind atom.key.LEFT_ARROW, 'left'
    atom.input.bind atom.key.A, 'left'

    atom.input.bind atom.key.RIGHT_ARROW, 'right'
    atom.input.bind atom.key.D, 'right'

    atom.input.bind atom.key.UP_ARROW, 'up'
    atom.input.bind atom.key.W, 'up'

    atom.input.bind atom.key.DOWN_ARROW, 'down'
    atom.input.bind atom.key.S, 'down'
