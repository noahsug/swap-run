{Entity} = require "../coffee/entity.coffee"
{EntitySpriteGraphic} = require "../coffee/entity_sprite_graphic.coffee"
{UserInputMoveBehavior} = require "../coffee/user_input_move_behavior.coffee"
{SpriteMap} = require "../spec/mock/sprite_map_mock.coffee"
{atom} = require "../spec/mock/atom_mock.coffee"

describe 'An entity sprite graphic', ->
  graphic = entity = spriteMap = undefined

  beforeEach ->
    spriteMap = new SpriteMap
    entity = new Entity
    entity.setPos x: 45, y: 55
    entity.setMoveBehavior new UserInputMoveBehavior

    graphic = new EntitySpriteGraphic spriteMap
    graphic.setEntity entity

  tick = ->
    entity.update .05
    graphic.update()

  it "is drawn centered at the entity's current location", ->
    spyOn spriteMap, 'draw'
    graphic.draw 'context'
    x = entity.getPos().x - spriteMap.sprite.frameW / 2
    y = entity.getPos().y - spriteMap.sprite.frameH / 2
    expect(spriteMap.draw).toHaveBeenCalledWith('context', x, y)

  it "initially shows the still-moving frame for the entity's direction", ->
    expect(spriteMap.activeLoop).toBe entity.getDirection()
    expect(spriteMap.getFrame()).toBe 0
    expect(spriteMap.isAnimating()).toBe false

  it "loops through the walking animation for the entity's current direction", ->
    atom.input.press 'right'
    tick()
    expect(spriteMap.activeLoop).toBe 'right'
    expect(spriteMap.isAnimating()).toBe true

  it "shows the still frame for the entity's direction when the entity stops moving", ->
    atom.input.press 'right'
    tick()
    atom.input.release 'right'
    tick()
    expect(spriteMap.getFrame()).toBe 0
    expect(spriteMap.isAnimating()).toBe false

  it "changes to the corresponding animation when the entity changes direction", ->
    atom.input.press 'up'
    tick()
    expect(spriteMap.activeLoop).toBe 'up'
    expect(spriteMap.isAnimating()).toBe true

    atom.input.press 'right'
    tick()
    expect(spriteMap.activeLoop).toBe 'right'
    expect(spriteMap.isAnimating()).toBe true

    atom.input.release 'right'
    tick()
    expect(spriteMap.activeLoop).toBe 'up'
    expect(spriteMap.isAnimating()).toBe true

    atom.input.release 'up'
    atom.input.press 'left'
    tick()
    expect(spriteMap.activeLoop).toBe 'left'
    expect(spriteMap.isAnimating()).toBe true

    atom.input.release 'left'
    atom.input.press 'down'
    tick()
    expect(spriteMap.activeLoop).toBe 'down'
    expect(spriteMap.isAnimating()).toBe true

  it "doesn't throw an error when trying to draw before the sprite is loaded", ->
    graphic.setEntity entity
    spriteMap.unload()
    tick()
    atom.input.press 'up'
    tick()
    atom.input.press 'right'
    tick()
    graphic.draw()
