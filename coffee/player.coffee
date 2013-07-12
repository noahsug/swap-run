{Entity} = require "../coffee/entity.coffee"
{atom} = require "../spec/mock/atom_mock.coffee"
{util} = require "../coffee/util.coffee"

exports.Player = class Player extends Entity
  update: (dt) ->
    if atom.input.pressed('swap') and @isActive()
      @swapPositionsWithNearestEnemy_()
    else super dt
    @restrictPosition_()

  reset: ->
    @moveBehavior_.reset()

  swapPositionsWithNearestEnemy_: ->
    nearestEnemy = @knowledge_.getNearestEnemyTo @getPos()
    if nearestEnemy
      origPlayerPos = @getPos()
      @setPos nearestEnemy.getPos()
      nearestEnemy.setPos origPlayerPos
      nearestEnemy.makeSlowToReact()

  restrictPosition_: ->
    graphicPos = @graphic_.getPos()
    if graphicPos.x + @graphic_.getWidth() > atom.width
      @pos_.x -= graphicPos.x + @graphic_.getWidth() - atom.width
    if graphicPos.x < 0
      @pos_.x -= graphicPos.x
    if graphicPos.y + @graphic_.getHeight() > atom.height
      @pos_.y -= graphicPos.y + @graphic_.getHeight() - atom.height
    if graphicPos.y < 0
      @pos_.y -= graphicPos.y
