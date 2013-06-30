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

    animation = { startRow: 1, endRow: 1, startCol: undefined, endCol: 3 }
    expect(sprite.animations['right']).toEqual animation
    expect(sprite.animations['left']).toEqual animation

    animation = { startRow: 4, endRow: 4, startCol: undefined, endCol: undefined }
    expect(sprite.animations['up']).toEqual animation

    animation = { startRow: 7, endRow: 7, startCol: undefined, endCol: 3 }
    expect(sprite.animations['down']).toEqual animation

    animation = { startRow: 2, endRow: 2, startCol: undefined, endCol: 1 }
    expect(sprite.animations['right-still']).toEqual animation
    expect(sprite.animations['left-still']).toEqual animation

    animation = { startRow: 5, endRow: 5, startCol: undefined, endCol: undefined }
    expect(sprite.animations['up-still']).toEqual animation

    animation = { startRow: 6, endRow: 6, startCol: undefined, endCol: 1 }
    expect(sprite.animations['down-still']).toEqual animation
