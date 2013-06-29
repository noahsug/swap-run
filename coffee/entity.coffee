{EntityGraphic} = require "../coffee/entity_graphic.coffee"
{Position} = require "../coffee/position.coffee"
{atom} = require "../spec/mock/atom_mock.coffee"
{util} = require "../coffee/util.coffee"

exports.Entity = class Entity

  constructor: (@type_) ->
    @pos_ = { x: 0, y: 0 }
    @radius_ = 10
    @setSpeed 200
    @active_ = true
    @wasMoving_ = false
    @currentDirection_ = 'down'
    @graphic_ = new EntityGraphic
    @reactionTime_ = 0
    @timeUntilNextReaction_ = 0

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

  setReactionTime: (@reactionTime_) ->
    if @timeUntilNextReaction_ > @reactionTime_
      @timeUntilNextReaction_ = @reactionTime_

  setKnowledge: (@knowledge_) ->
    @moveBehavior_?.setKnowledge @knowledge_

  setMoveBehavior: (@moveBehavior_) ->
    @moveBehavior_.setMovingEntity this
    @moveBehavior_.setKnowledge @knowledge_

  getDirection: ->
    @currentDirection_

  isMoving: ->
    @velocityVector_? and (@velocityVector_.x != 0 or @velocityVector_.y != 0)

  startedMoving: ->
    @isMoving() and not @wasMoving_

  stoppedMoving: ->
    @wasMoving_ and not @isMoving()

  isActive: -> @active_
  die: -> @active_ = false

  update: (dt) ->
    if @moveBehavior_
      @wasMoving_ = @isMoving()
      @move_ dt
      @updateDirection_()
    @graphic_.update()

  setGraphic: (@graphic_) ->
    @graphic_.setEntity this

  draw: (context) ->
    @graphic_.draw context

  move_: (dt) ->
    if @canChangeMovement_ dt
      @velocityVector_ = @moveBehavior_.getVelocityVector()
    @updatePosition_ dt

  canChangeMovement_: (dt) ->
    return true if @reactionTime_ < dt
    if @timeUntilNextReaction_ < dt
      @timeUntilNextReaction_ = (@timeUntilNextReaction_ - dt) + @reactionTime_
      true
    else
      @timeUntilNextReaction_ -= dt
      false

  updatePosition_:  (dt) ->
    @pos_.x += @velocityVector_.x * @speed_ * dt
    @pos_.y += @velocityVector_.y * @speed_ * dt

  updateDirection_: ->
    return unless @isMoving()
    if Math.abs(@velocityVector_.y) > Math.abs(@velocityVector_.x)
      @currentDirection_ = if @velocityVector_.y > 0 then 'down' else 'up'
    else
      @currentDirection_ = if @velocityVector_.x > 0 then 'right' else 'left'
