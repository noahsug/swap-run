{EntitySpriteGraphic} = require "../coffee/entity_sprite_graphic.coffee"
{SpriteMap} = require "../spec/mock/sprite_map_mock.coffee"

exports.SpriteFactory = class SpriteFactory
  @instance_ = new SpriteFactory

  @create = (type) ->
    @instance_.create type

  create: (@type_) ->
    if @type_ of @creationMethods_
      spriteMap = @creationMethods_[@type_].apply(this)
      new EntitySpriteGraphic spriteMap
    else
      throw "sprite of type '#{@type_}' was not found"

  creationMethods_:
    "player": ->
      new SpriteMap '../assets/bald_female.png', {
        'up':
          startRow: 8
          endRow: 8
          endCol: 8
        'left':
          startRow: 9
          endRow: 9
          endCol: 8
        'down':
          startRow: 10
          endRow: 10
          endCol: 8
        'right':
          startRow: 11
          endRow: 11
          endCol: 8
        }, {
          frameW: 64
          frameH: 64
        }

    "enemy": ->
      new SpriteMap '../assets/purple_female.png', {
        'up':
          startRow: 8
          endRow: 8
          endCol: 8
        'left':
          startRow: 9
          endRow: 9
          endCol: 8
        'down':
          startRow: 10
          endRow: 10
          endCol: 8
        'right':
          startRow: 11
          endRow: 11
          endCol: 8
        }, {
          frameW: 64
          frameH: 64
        }
