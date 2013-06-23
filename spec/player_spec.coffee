{Entity} = require "../coffee/entity.coffee"
{Player} = require "../coffee/player.coffee"
{Knowledge} = require "../coffee/knowledge.coffee"
{MockGameInfo} = require "../spec/mock/mock_game_info.coffee"
{atom} = require "../spec/mock/atom_mock.coffee"

describe "A player", ->
  player = enemy = gameInfo = undefined

  beforeEach ->
    atom.input.reset()
    player = new Player()
    enemy = new Entity()
    player.setPos x: 50, y: 100
    enemy.setPos x: 20, y: 35
    player.setKnowledge createKnowledge()

  createKnowledge = ->
    gameInfo = new MockGameInfo
    gameInfo.setEnemies [enemy]
    knowledge = new Knowledge
    knowledge.setGameInfo gameInfo
    return knowledge

  it "swaps positions with the nearest enemy when the swap key is pressed", ->
    atom.input.press 'swap'
    enemyPos = enemy.getPos()
    playerPos = player.getPos()
    player.update()
    expect(player.getPos()).toEqual enemyPos
    expect(enemy.getPos()).toEqual playerPos

  it "stops swapping positions after the initial swap button press", ->
    atom.input.hold 'swap'
    enemyPos = enemy.getPos()
    playerPos = player.getPos()
    player.update()
    expect(player.getPos()).toEqual playerPos
    expect(enemy.getPos()).toEqual enemyPos

  it "does nothing when trying to swap but there are no enemies", ->
    gameInfo.setEnemies []
    atom.input.press 'swap'
    enemyPos = enemy.getPos()
    playerPos = player.getPos()
    player.update()
    expect(player.getPos()).toEqual playerPos
    expect(enemy.getPos()).toEqual enemyPos

  it "has its position bound to the size of the world", ->
    player.setPos x: 0, y: 0
    player.update 1
    expect(player.getPos()).toEqual x: player.getRadius(), y: player.getRadius()
