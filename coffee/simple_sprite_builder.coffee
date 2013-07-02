{SpriteBuilder} = require "../coffee/sprite_builder.coffee"

exports.SimpleSpriteBuilder = class SimpleSpriteBuilder extends SpriteBuilder

  animationRows_:
    'right': 1
    'left': 1
    'right-still': 2
    'left-still': 2
    'up': 4
    'up-still': 5
    'down': 7
    'down-still': 8

  addAnimations_: ->
    super()
    @setAnimationRows_()
    @flipLeftAnimations_()

  setAnimationRows_: ->
    startingIndex = if @options_.hasDeath then 1 else 0
    for animationName in @getAnimationNames_()
      row = startingIndex + @animationRows_[animationName]
      @animations_[animationName].startRow = row
      @animations_[animationName].endRow = row

  flipLeftAnimations_: ->
    for animationName in ['left', 'left-still']
      @animations_[animationName].flipped = { horizontal: true }
