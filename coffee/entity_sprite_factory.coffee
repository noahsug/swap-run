{EntitySpriteGraphic} = require "../coffee/entity_sprite_graphic.coffee"
{SpriteMap} = require "../spec/mock/sprite_map_mock.coffee"

exports.EntitySpriteFactory = class EntitySpriteFactory
  @instance_ = new EntitySpriteFactory

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
            startCol: 1
            endCol: 8
          'left':
            startRow: 9
            endRow: 9
            startCol: 1
            endCol: 8
          'down':
            startRow: 10
            endRow: 10
            startCol: 1
            endCol: 8
          'right':
            startRow: 11
            endRow: 11
            startCol: 1
            endCol: 8
          'up-still':
            startRow: 8
            endRow: 8
            endCol: 0
          'left-still':
            startRow: 9
            endRow: 9
            endCol: 0
          'down-still':
            startRow: 10
            endRow: 10
            endCol: 0
          'right-still':
            startRow: 11
            endRow: 11
            endCol: 0
          }, {
            frameW: 64
            frameH: 64
            interval: 75
      }

    "enemy": ->
      new SpriteMap '../assets/purple_female.png', {
        'up':
          startRow: 8
          endRow: 8
          startCol: 1
          endCol: 8
        'right':
          startRow: 11
          endRow: 11
          startCol: 1
          endCol: 8
        'left':
          startRow: 9
          endRow: 9
          startCol: 1
          endCol: 8
        'down':
          startRow: 10
          endRow: 10
          startCol: 1
          endCol: 8
        'up-still':
          startRow: 8
          endRow: 8
          endCol: 0
        'left-still':
          startRow: 9
          endRow: 9
          endCol: 0
        'down-still':
          startRow: 10
          endRow: 10
          endCol: 0
        'right-still':
          startRow: 11
          endRow: 11
          endCol: 0
        }, {
          frameW: 64
          frameH: 64
          interval: 75
        }

    "bat": ->
      new SpriteMap '../assets/bat.png', {
        'up':
          startRow: 3
          endRow: 3
        'left':
          startRow: 0
          endRow: 0
        'down':
          startRow: 6
          endRow: 6
        'right':
          startRow: 0
          endRow: 0
        'up-still':
          startRow: 3
          endRow: 3
        'left-still':
          startRow: 0
          endRow: 0
        'down-still':
          startRow: 6
          endRow: 6
        'right-still':
          startRow: 0
          endRow: 0
        }, {
          frameW: 64
          frameH: 96
          interval: 100
        }
