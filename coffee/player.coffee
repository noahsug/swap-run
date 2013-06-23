{Entity} = require "../coffee/entity.coffee"
{atom} = require "../spec/mock/atom_mock.coffee"
{util} = require "../coffee/util.coffee"

exports.Player = class Player extends Entity
  update: (dt) ->
    if atom.input.pressed 'swap'
      @swapPositionsWithNearestEnemy_()
    else super dt
    @restrictPosition_()

  swapPositionsWithNearestEnemy_: ->
    origPlayerPos = @getPos()
    nearestEnemy = @knowledge_.getNearestEnemyTo @getPos()
    if nearestEnemy
      @setPos nearestEnemy.getPos()
      nearestEnemy.setPos origPlayerPos

  restrictPosition_: ->
    @pos_.x = util.bound @pos_.x, @getRadius(), atom.width - @getRadius()
    @pos_.y = util.bound @pos_.y, @getRadius(), atom.height - @getRadius()
