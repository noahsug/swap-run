{Entity} = require "../coffee/entity.coffee"
{GameInfo} = require "../coffee/game_info.coffee"

describe 'Game info', ->
  gameInfo = undefined

  beforeEach ->
    gameInfo = new GameInfo

  addEnemy = ->
    enemy = new Entity
    enemy.setRadius 10
    gameInfo.addEnemy enemy
    return enemy

  addEnemyAtPos = (pos) ->
    enemy = addEnemy()
    enemy.setPos pos
    return enemy

  it "can return the nearest enemy to a position", ->
    farEnemy = addEnemyAtPos x: 5, y: 5
    closeEnemy = addEnemyAtPos x: 55, y: 98
    expect(gameInfo.getNearestEnemyTo x: 50, y: 100).toBe closeEnemy

  it "can return a list of active enemies", ->
    enemy1 = addEnemy()
    enemy2 = addEnemy()
    enemy3 = addEnemy()
    enemy4 = addEnemy()
    enemy2.die()
    enemy4.die()

    activeEnemies = gameInfo.getActiveEnemies()
    expect(activeEnemies).toContain enemy1
    expect(activeEnemies).not.toContain enemy2
    expect(activeEnemies).toContain enemy3
    expect(activeEnemies).not.toContain enemy4

  it "can return a list of collided entities", ->
    enemy1 = addEnemyAtPos x: 10, y: 10
    enemy2 = addEnemyAtPos x: 10, y: 30
    enemy3 = addEnemyAtPos x: 10, y: 49
    enemy4 = addEnemyAtPos x: 90, y: 100

    collidedEnemies = gameInfo.getCollidedEntities()
    expect(collidedEnemies).not.toContain enemy1
    expect(collidedEnemies).toContain enemy2
    expect(collidedEnemies).toContain enemy3
    expect(collidedEnemies).not.toContain enemy4

  it "can have 3-way collisions", ->
    enemy1 = addEnemyAtPos x: 10, y: 10
    enemy2 = addEnemyAtPos x: 10, y: 29
    enemy3 = addEnemyAtPos x: 29, y: 10

    collidedEnemies = gameInfo.getCollidedEntities()
    expect(collidedEnemies).toContain enemy1
    expect(collidedEnemies).toContain enemy2
    expect(collidedEnemies).toContain enemy3
