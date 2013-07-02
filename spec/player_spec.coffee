{Entity} = require "../coffee/entity.coffee"
{EntityFactory} = require "../coffee/entity_factory.coffee"
{GameInfo} = require "../coffee/game_info.coffee"
{Position} = require "../coffee/position.coffee"
{Player} = require "../coffee/player.coffee"
{atom} = require "../spec/mock/atom_mock.coffee"

describe "A player", ->
  player = enemy = gameInfo = undefined

  beforeEach ->
    atom.input.reset()
    player = new Player()
    player = EntityFactory.create 'player'
    player.setPos x: 50, y: 100

    enemy = new Entity()
    enemy.setPos x: 20, y: 35

    gameInfo = new GameInfo
    gameInfo.setEnemies [enemy]
    player.setKnowledge gameInfo

  tick = ->
    player.update .05

  it "swaps positions with the nearest enemy when the swap key is pressed", ->
    atom.input.press 'swap'
    enemyPos = enemy.getPos()
    playerPos = player.getPos()
    tick()
    expect(player.getPos()).toEqual enemyPos
    expect(enemy.getPos()).toEqual playerPos

  it "stops swapping positions after the initial swap button press", ->
    atom.input.hold 'swap'
    enemyPos = enemy.getPos()
    playerPos = player.getPos()
    tick()
    expect(player.getPos()).toEqual playerPos
    expect(enemy.getPos()).toEqual enemyPos

  it "does nothing when trying to swap but there are no enemies", ->
    gameInfo.setEnemies []
    atom.input.press 'swap'
    enemyPos = enemy.getPos()
    playerPos = player.getPos()
    tick()
    expect(player.getPos()).toEqual playerPos
    expect(enemy.getPos()).toEqual enemyPos

  it "has its position bound to the size of the world", ->
    player.setPos x: 0, y: 0
    tick()
    expect(player.getPos().x).toBeGreaterThan 0
    expect(player.getPos().y).toBeGreaterThan 0

    player.setPos x: atom.width, y: atom.height
    tick()
    expect(player.getPos().x).toBeLessThan atom.width
    expect(player.getPos().y).toBeLessThan atom.height
