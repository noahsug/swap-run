{GraphicFactory} = require "../coffee/graphic_factory.coffee"
{SpriteMap} = require "../spec/mock/sprite_map_mock.coffee"

exports.SpriteBuilder = class SpriteBuilder
  build: (@imgName_, @options_={}) ->
    @addAnimations_()
    @addSpriteOptions_()
    @buildSpriteMap_()

  addAnimations_: ->
    @animations_ = {}
    for animationName in @getAnimationNames_()
      @addAnimation_ animationName

  addAnimation_: (name) ->
    option = @getOptionForAnimation_ name
    return unless option
    @animations_[name] =
      startRow: option.startRow ? option.row
      endRow: option.endRow ? option.row
      startCol: option.startCol
      endCol: option.endCol
      flipped: option.flipped

  getAnimationNames_: ->
    ['right', 'left', 'up', 'down',
        'right-still', 'left-still', 'up-still', 'down-still', 'death']

  getOptionForAnimation_: (animationName) ->
    if not (animationName of @options_)
      if animationName.indexOf('-still') is -1
        @options_['moving'] ? {}
      else
        @options_['still'] ? {}
    else
      @options_[animationName]

  addSpriteOptions_: ->
    @spriteOptions_ =
      frameW: @options_.frameW ? 64
      frameH: @options_.frameH ? 64
      interval: @options_.interval ? 100

  buildSpriteMap_: ->
    filePath = GraphicFactory.getImagePath @imgName_
    new SpriteMap filePath, @animations_, @spriteOptions_
