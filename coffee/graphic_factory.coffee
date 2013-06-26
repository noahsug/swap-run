{BackgroundGraphic} = require "../coffee/background_graphic.coffee"
{Sprite} = require "../spec/mock/sprite_mock.coffee"

exports.GraphicFactory = class GraphicFactory
  @instance_ = new GraphicFactory

  @create = (type) ->
    @instance_.create type

  create: (@type_) ->
    if @type_ of @creationMethods_
      @creationMethods_[@type_].apply(this)
    else
      throw "graphic of type '#{@type_}' was not found"

  creationMethods_:
    "background": ->
      sprite = new Sprite '../assets/sand_tile.png', {
        frameW: 96
        frameH: 96
      }
      background = new BackgroundGraphic sprite
      background.setFrameOccurrenceRatios [4, 2, 128, 0, 16, 8]
      background
