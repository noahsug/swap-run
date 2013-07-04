{Entity} = require "../coffee/entity.coffee"
{EntityFactory} = require "../coffee/entity_factory.coffee"
{GameInfo} = require "../coffee/game_info.coffee"
{Position} = require "../coffee/position.coffee"
{Player} = require "../coffee/player.coffee"
{TrackingMoveBehavior} = require "../coffee/tracking_move_behavior.coffee"
{atom} = require "../spec/mock/atom_mock.coffee"
{jasmine_env} = require "../spec/jasmine_env.coffee"

describe "A player", ->
  player = enemy = gameInfo = dt = undefined

  beforeEach ->
    jasmine_env.init this
    player = new Player()
    player = EntityFactory.create 'player'
    player.setPos x: 50, y: 100
    dt = .025

    enemy = new Entity()
    enemy.setPos x: 20, y: 40

    gameInfo = new GameInfo
    gameInfo.setEnemies [enemy]
    gameInfo.setPlayer player
    player.setKnowledge gameInfo
    enemy.setKnowledge gameInfo

  tick = (num=1) ->
    for i in [1..num]
      enemy.update dt
      player.update dt

  it "swaps positions with the nearest enemy when the swap key is pressed", ->
    atom.input.press 'swap'
    enemyPos = enemy.getPos()
    playerPos = player.getPos()
    tick()
    expect(player.getPos()).toEqual enemyPos
    expect(enemy.getPos()).toEqual playerPos

  it "can't swap positions after it has died", ->
    player.die()
    atom.input.press 'swap'
    playerPos = player.getPos()
    tick()
    expect(player.getPos()).toEqual playerPos

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
    expect(player.getPos().y).toBeLessThanOrEqualTo atom.height

  it "swapping with an enemy resets part the enemy's reaction time", ->
    dt = 1
    enemy.setMoveBehavior new TrackingMoveBehavior
    enemy.setReactionTime 10
    enemy.setSpeed 1
    enemy.setPos x: 0, y: 100

    tick 9
    atom.input.press 'swap'
    tick()
    atom.input.release 'swap'

    enemyPos = enemy.getPos()
    tick 10
    expect(enemy.getPos()).toEqual enemyPos
