{MoveBehavior} = require "../coffee/move_behavior.coffee"
{atom} = require "../spec/mock/atom_mock.coffee"

exports.UserInputMoveBehavior = class UserInputMoveBehavior extends MoveBehavior

  determineVelocityVector_: ->
    @velocityVector_.x = @velocityVector_.y = 0
    if atom.input.down 'left'
      @velocityVector_.x -= 1
    if atom.input.down 'right'
      @velocityVector_.x += 1
    if atom.input.down 'up'
      @velocityVector_.y -= 1
    if atom.input.down 'down'
      @velocityVector_.y += 1
