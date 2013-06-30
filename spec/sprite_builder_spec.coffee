{SpriteBuilder} = require "../coffee/sprite_builder.coffee"

describe 'A sprite builder', ->
  builder = undefined

  beforeEach ->
    builder = new SpriteBuilder

  it 'can build a sprite with the correct file path', ->
    sprite = builder.build 'poop.png'
    expect(sprite.path).toBe '../assets/poop.png'

  it 'can build a sprite with the correct options', ->
    options = { frameW: 68, frameH: 100, interval: 72 }
    sprite = builder.build 'poop.png', options
    expect(sprite.options).toEqual options

  it 'can build a sprite with the correct animations', ->
    animations = {
        'moving': { row: 1, endCol: 3 }
        'still': { row: 2, endCol: 1 }
        'up': { startRow: 1 }
        'up-still': { endRow: 0 } }
    sprite = builder.build 'poop.png', animations

    for dir in ['right', 'left', 'down']
      animation = { startRow: 1, endRow: 1, startCol: undefined, endCol: 3 }
      expect(sprite.animations[dir]).toEqual animation

    for dir in ['right-still', 'left-still', 'down-still']
      animation = { startRow: 2, endRow: 2, startCol: undefined, endCol: 1 }
      expect(sprite.animations[dir]).toEqual animation

    upAnimation = { startRow: 1, endRow: undefined, startCol: undefined, endCol: undefined }
    expect(sprite.animations['up']).toEqual upAnimation

    upStillAnimation = { startRow: undefined, endRow: 0, startCol: undefined, endCol: undefined }
    expect(sprite.animations['up-still']).toEqual upStillAnimation
