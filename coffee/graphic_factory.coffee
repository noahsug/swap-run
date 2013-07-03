{Graphic} = require "../coffee/graphic.coffee"
{BackgroundGraphic} = require "../coffee/background_graphic.coffee"
{Factory} = require "../coffee/factory.coffee"
{Sprite} = require "../spec/mock/sprite_mock.coffee"

exports.GraphicFactory = class GraphicFactory extends Factory
  @create = (type) -> Factory.create this, type

  creationMethods_:
    "background": ->
      sprite = new Sprite '../assets/sand_tile.png', {
        frameW: 96
        frameH: 96
      }
      background = new BackgroundGraphic sprite
      background.setFrameOccurrenceRatios [4, 2, 128, 0, 16, 8]
      background

    "death": ->
      sprite = new Sprite '../assets/death.png', {
        frameW: 48
        frameH: 48
        interval: 75
      }
      new Graphic sprite
