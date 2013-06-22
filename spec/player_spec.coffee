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
    player.setKnowledge createKnowledge()

  createKnowledge = ->
    gameInfo = new MockGameInfo
    gameInfo.setEnemies [enemy]
    knowledge = new Knowledge
    knowledge.setGameInfo gameInfo
    return knowledge

  it "can swap positions with the nearest enemy when the swap key is pressed", ->
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

  it "swapping does nothing when there are no enemies", ->
    gameInfo.setEnemies []
    atom.input.press 'swap'
    enemyPos = enemy.getPos()
    playerPos = player.getPos()
    player.update()
    expect(player.getPos()).toEqual playerPos
    expect(enemy.getPos()).toEqual enemyPos
