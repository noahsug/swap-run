{EntitySpriteGraphic} = require "../coffee/entity_sprite_graphic.coffee"
{Factory} = require "../coffee/factory.coffee"
{SpriteBuilder} = require "../coffee/sprite_builder.coffee"
{SimpleSpriteBuilder} = require "../coffee/simple_sprite_builder.coffee"
{SpriteMap} = require "../spec/mock/sprite_map_mock.coffee"

exports.EntitySpriteFactory = class EntitySpriteFactory extends Factory
  @create: (type) -> Factory.create this, type

  constructor: ->
    @spriteBuilder_ = new SpriteBuilder
    @simpleSpriteBuilder_ = new SimpleSpriteBuilder

  creationMethods_:
    'player': ->
      @createIPCSprite_ 'bald_female.png'

    'enemy': ->
      @createIPCSprite_ 'purple_female.png'

    'bat': ->
      spriteMap = @simpleSpriteBuilder_.build 'bat.png', { frameH: 96 }
      graphic = new EntitySpriteGraphic spriteMap
      graphic.setOffset x: 0, y: -14
      graphic

    'ogre': ->
      spriteMap = @simpleSpriteBuilder_.build 'ogre.png', {
          'still': { endCol: 1 }
          'up': { endCol: 4 }
          frameW: 96, frameH: 96, interval: 150 }
      graphic = new EntitySpriteGraphic spriteMap
      graphic.setOffset x: 0, y: -23
      graphic

    'spectre': ->
      spriteMap = @simpleSpriteBuilder_.build 'spectre.png', {
          'moving': { endCol: 3 }
          'up': {}
          'still': { endCol: 1 }
          'up-still': {}
        frameW: 68, frameH: 68, interval: 150 }
      graphic = new EntitySpriteGraphic spriteMap
      graphic.setOffset x: -2, y: -16
      graphic

    'skeleton': ->
      spriteMap = @simpleSpriteBuilder_.build 'skeleton.png', {
          'right-still': { endCol: 1 }
          'left-still': { endCol: 1 }
          'still': { endCol: 2 }
        frameW: 96, frameH: 96, interval: 125 }
      graphic = new EntitySpriteGraphic spriteMap
      graphic.setOffset x: 0, y: -20
      graphic

    'deathknight': ->
      spriteMap = @simpleSpriteBuilder_.build 'deathknight.png', {
          'moving': { endCol: 3 }
          'still': { endCol: 1 }
          frameW: 84, frameH: 84, interval: 125 }
      graphic = new EntitySpriteGraphic spriteMap
      graphic.setOffset x: 0, y: -17
      graphic

  createIPCSprite_: (fileName) ->
    spriteMap = @spriteBuilder_.build fileName, {
        'right': { row: 11, startCol: 1, endCol: 8 }
        'left': { row: 9, startCol: 1, endCol: 8 }
        'up': { row: 8, startCol: 1, endCol: 8 }
        'down': { row: 10, startCol: 1, endCol: 8 }
        'right-still': { row: 11, endCol: 0 }
        'left-still': { row: 9, endCol: 0 }
        'up-still': { row: 8, endCol: 0 }
        'down-still': { row: 10, endCol: 0 }
        'death': { row: 20, endCol: 4 }
        frameW: 64, frameH: 64, interval: 75 }
    graphic = new EntitySpriteGraphic spriteMap
    graphic.setWidth 22
    graphic.setOffset x: 0, y: -28
    graphic
