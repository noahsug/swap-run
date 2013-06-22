{Entity} = require "../coffee/entity.coffee"
{Knowledge} = require "../coffee/knowledge.coffee"
{MockGameInfo} = require "../spec/mock/mock_game_info.coffee"

describe "Game knowledge", ->
  enemies = mockGameInfo = knowledge = undefined

  beforeEach ->
    mockGameInfo = new MockGameInfo
    enemies = []
    mockGameInfo.setEnemies enemies
    knowledge = new Knowledge
    knowledge.setGameInfo mockGameInfo

  addEnemyAtPos = (pos) ->
    enemy = new Entity
    enemy.setPos pos
    enemies.push enemy
    return enemy

  it "can return the current player", ->
    player = new Entity "player"
    mockGameInfo.setPlayer player
    expect(knowledge.getPlayer()).toBe player

  it "can return the nearest enemy", ->
    farEnemy = addEnemyAtPos x: 5, y: 5
    closeEnemy = addEnemyAtPos x: 55, y: 98
    expect(knowledge.getNearestEnemyTo x: 50, y: 100).toBe closeEnemy
