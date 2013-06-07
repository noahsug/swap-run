{util} = require "../coffee/util.coffee"
{Position} = require "../coffee/position.coffee"
{atom} = require "../spec/mock/atom_mock.coffee"

exports.Entity = class Entity
  constructor: ->
    @pos_ = { x: 0, y: 0 }
    @radius_ = 1
    @setSpeed 100

  setPos: (pos) ->
    @pos_.x = pos.x
    @pos_.y = pos.y

  getPos: ->
    Position.clone @pos_

  setRadius: (@radius_) ->
  getRadius: -> @radius_

  setSpeed: (@speed_) ->
    @diagSpeed_ = @speed_ / Math.SQRT2

  getSpeed: -> @speed_

  isMovingDiagonally_: ->
    (atom.input.down('left') or atom.input.down('right')) and
        (atom.input.down('down') or atom.input.down('up'))

  update: (dt) ->
    speed = if @isMovingDiagonally_() then @diagSpeed_ else @speed_
    distanceToMove = speed * dt
    if atom.input.down 'left'
      @pos_.x -= distanceToMove
    if atom.input.down 'right'
      @pos_.x += distanceToMove
    if atom.input.down 'up'
      @pos_.y -= distanceToMove
    if atom.input.down 'down'
      @pos_.y += distanceToMove

    @pos_.x = util.bound @pos_.x, 0, atom.width
    @pos_.y = util.bound @pos_.y, 0, atom.height
