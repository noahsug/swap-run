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

  setMoveBehavior_: (@moveBehavior_) ->

  isActive: -> @active_
  die: -> @active_ = false

  update: (dt) ->
    @move_ dt

  move_: (dt) ->
    @velocityVector_ = @moveBehavior_.getVelocityVector()
    @updatePosition_ dt

  updatePosition_:  (dt) ->
    @pos_.x += @velocityVector_.x * @speed_ * dt
    @pos_.y += @velocityVector_.y * @speed_ * dt
    @pos_.x = util.bound @pos_.x, 0, atom.width
    @pos_.y = util.bound @pos_.y, 0, atom.height
