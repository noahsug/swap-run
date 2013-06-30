{SimpleSpriteBuilder} = require "../coffee/simple_sprite_builder.coffee"

describe 'A simple sprite builder', ->
  builder = undefined

  beforeEach ->
    builder = new SimpleSpriteBuilder

  it 'can build a sprite with the correct animations', ->
    animations = {
        'moving': { endCol: 3 }
        'up': {}
        'still': { endCol: 1 }
        'up-still': {} }
    sprite = builder.build 'poop.png', animations

    expect(sprite.animations['right']).toEqual {
        startRow: 1, endRow: 1, endCol: 3 }

    expect(sprite.animations['left']).toEqual {
        startRow: 1, endRow: 1, endCol: 3, flipped: { horizontal: true } }

    expect(sprite.animations['up']).toEqual {
        startRow: 4, endRow: 4, endCol: undefined }

    expect(sprite.animations['down']).toEqual {
        startRow: 7, endRow: 7, endCol: 3 }

    expect(sprite.animations['right-still']).toEqual {
        startRow: 2, endRow: 2, endCol: 1 }

    expect(sprite.animations['left-still']).toEqual {
        startRow: 2, endRow: 2, endCol: 1, flipped: { horizontal: true } }

    expect(sprite.animations['up-still']).toEqual { startRow: 5, endRow: 5 }

    expect(sprite.animations['down-still']).toEqual {
        startRow: 6, endRow: 6, endCol: 1 }
