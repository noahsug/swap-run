{SpriteBuilder} = require "../coffee/sprite_builder.coffee"

exports.SimpleSpriteBuilder = class SimpleSpriteBuilder extends SpriteBuilder

  animationRows_:
    'right': 1
    'left': 1
    'up': 4
    'down': 7
    'right-still': 2
    'left-still': 2
    'up-still': 5
    'down-still': 6

  addAnimations_: ->
    super()
    startingIndex = if @options_.hasDeath then 1 else 0
    for animationName in @getAnimationNames_()
      row = startingIndex + @animationRows_[animationName]
      @animations_[animationName].startRow = row
      @animations_[animationName].endRow = row
