{Entity} = require "../coffee/entity.coffee"
{atom} = require "../spec/mock/atom_mock.coffee"

exports.Player = class Player extends Entity
  update: (dt) ->
    if atom.input.pressed 'swap'
      @swapPositionsWithNearestEnemy_()
    else super dt

  swapPositionsWithNearestEnemy_: ->
    origPlayerPos = @getPos()
    nearestEnemy = @knowledge_.getNearestEnemyTo @getPos()
    if nearestEnemy
      @setPos nearestEnemy.getPos()
      nearestEnemy.setPos origPlayerPos
