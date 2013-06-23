{Position} = require "../coffee/position.coffee"
{atom} = require "../spec/mock/atom_mock.coffee"
{util} = require "../coffee/util.coffee"

exports.Entity = class Entity

  constructor: (@type_) ->
    @pos_ = { x: 0, y: 0 }
    @radius_ = 10
    @active_ = true
    @setSpeed 200

  getType: -> @type_

  setPos: (pos) ->
    @pos_.x = pos.x
    @pos_.y = pos.y

  getPos: ->
    Position.clone @pos_

  setRadius: (@radius_) ->
  getRadius: -> @radius_

  setSpeed: (@speed_) ->
  getSpeed: -> @speed_

  setKnowledge: (@knowledge_) ->
    @moveBehavior_?.setKnowledge @knowledge_

  setMoveBehavior: (@moveBehavior_) ->
    @moveBehavior_.setMovingEntity this
    @moveBehavior_.setKnowledge @knowledge_

  getDirection: ->
    if not @velocityVector_ || @velocityVector_.x == @velocityVector_.y == 0
      'down'
    else if Math.abs(@velocityVector_.y) > Math.abs(@velocityVector_.x)
      if @velocityVector_.y > 0 then 'down' else 'up'
    else
      if @velocityVector_.x > 0 then 'right' else 'left'

  isActive: -> @active_
  die: -> @active_ = false

  update: (dt) ->
    if @moveBehavior_
      @move_ dt

  move_: (dt) ->
    @velocityVector_ = @moveBehavior_.getVelocityVector()
    @updatePosition_ dt

  updatePosition_:  (dt) ->
    @pos_.x += @velocityVector_.x * @speed_ * dt
    @pos_.y += @velocityVector_.y * @speed_ * dt
