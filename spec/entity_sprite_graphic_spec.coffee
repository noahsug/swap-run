{Entity} = require "../coffee/entity.coffee"
{EntitySpriteGraphic} = require "../coffee/entity_sprite_graphic.coffee"
{MockMoveBehavior} = require "../spec/mock/mock_move_behavior.coffee"
{UserInputMoveBehavior} = require "../coffee/user_input_move_behavior.coffee"
{SpriteMap} = require "../spec/mock/sprite_map_mock.coffee"
{atom} = require "../spec/mock/atom_mock.coffee"

describe 'An entity sprite graphic', ->
  graphic = entity = spriteMap = moveBehavior = undefined

  beforeEach ->
    atom.input.reset()
    spriteMap = new SpriteMap
    entity = new Entity
    entity.setPos x: 45, y: 55
    entity.setMoveBehavior new UserInputMoveBehavior

    graphic = new EntitySpriteGraphic spriteMap
    graphic.setEntity entity

  tick = ->
    entity.update .05
    graphic.update()

  useMockMoveBehavior = ->
    moveBehavior = new MockMoveBehavior
    entity.setMoveBehavior moveBehavior

  it "defaults to drawing centered on the entity", ->
    spyOn spriteMap, 'draw'
    graphic.draw 'context'
    x = entity.getPos().x - spriteMap.sprite.frameW / 2
    y = entity.getPos().y - spriteMap.sprite.frameH / 2
    expect(spriteMap.draw).toHaveBeenCalledWith('context', x, y)

  it "initially shows the still-moving frame for the entity's direction", ->
    expect(spriteMap.activeLoop).toBe 'down-still'

  it "loops through the walking animation for the entity's current direction", ->
    atom.input.press 'right'
    tick()
    expect(spriteMap.activeLoop).toBe 'right'
    expect(spriteMap.isAnimating()).toBe true

  it "shows the still frame for the entity's direction when the entity stops moving", ->
    useMockMoveBehavior()
    moveBehavior.move 'right'
    tick()
    moveBehavior.stop()
    tick()
    expect(spriteMap.activeLoop).toBe 'right-still'

  it "changes to the corresponding animation when the entity changes direction", ->
    useMockMoveBehavior()
    moveBehavior.move 'up'
    tick()
    expect(spriteMap.activeLoop).toBe 'up'
    expect(spriteMap.isAnimating()).toBe true

    moveBehavior.move 'up', 'right'
    tick()
    expect(spriteMap.activeLoop).toBe 'right'
    expect(spriteMap.isAnimating()).toBe true

    moveBehavior.move 'up'
    tick()
    expect(spriteMap.activeLoop).toBe 'up'
    expect(spriteMap.isAnimating()).toBe true

    moveBehavior.move 'left'
    tick()
    expect(spriteMap.activeLoop).toBe 'left'
    expect(spriteMap.isAnimating()).toBe true

    moveBehavior.move 'down'
    tick()
    expect(spriteMap.activeLoop).toBe 'down'
    expect(spriteMap.isAnimating()).toBe true

  it "doesn't throw an error when trying to draw before the sprite is loaded", ->
    spriteMap.unload()
    tick()
    atom.input.press 'up'
    tick()
    atom.input.press 'right'
    tick()
    graphic.draw()

  it "shows the death animation when the entity dies", ->
    entity.die()
    tick()
    expect(spriteMap.activeLoop).toBe 'death'
    expect(spriteMap.isRunningOnce()).toBe true

  it "can have different frame intervals for different animations", ->
    graphic.setAnimationInterval 'death', 250

    entity.die()
    tick()
    expect(spriteMap.sprite.interval).toBe 250

    entity.active_ = true
    atom.input.press 'right'
    tick()
    expect(spriteMap.sprite.interval).toBe 125
