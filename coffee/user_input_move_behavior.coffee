{MoveBehavior} = require "../coffee/move_behavior.coffee"
{atom} = require "../spec/mock/atom_mock.coffee"

exports.UserInputMoveBehavior = class UserInputMoveBehavior extends MoveBehavior
  constructor: ->
    super()
    @history_ = [undefined, undefined]

  determineVelocityVector_: ->
    unless @movingEntity_.isActive()
      @velocityVector_.x = @velocityVector_.y = 0
    else if @inputIsPressed_()
      @setNextVelocityVector_()
    else if @wasMovingDiagonally_()
      @keepMovingDiagonally_()
    @updateHistory_()

  setNextVelocityVector_: ->
    @velocityVector_.x = @velocityVector_.y = 0
    if atom.input.down 'left'
      @velocityVector_.x -= 1
    if atom.input.down 'right'
      @velocityVector_.x += 1
    if atom.input.down 'up'
      @velocityVector_.y -= 1
    if atom.input.down 'down'
      @velocityVector_.y += 1

  inputIsPressed_: ->
    for dir in ['left', 'right', 'up', 'down']
      return true if atom.input.down dir
    return false

  wasMovingDiagonally_: ->
    return false unless @history_[1]
    @history_[1].x * @history_[1].y isnt 0

  keepMovingDiagonally_: ->
    @velocityVector_ = @history_[1]

  updateHistory_: ->
    @history_[1] = @history_[0]
    @history_[0] = { x: @velocityVector_.x, y: @velocityVector_.y }
