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
      expect(sprite.animations[dir]).toEqual {
           startRow: 1, endRow: 1, endCol: 3 }

    for dir in ['right-still', 'left-still', 'down-still']
      expect(sprite.animations[dir]).toEqual {
          startRow: 2, endRow: 2, endCol: 1 }

    expect(sprite.animations['up']).toEqual { startRow: 1  }
    expect(sprite.animations['up-still']).toEqual { endRow: 0 }
