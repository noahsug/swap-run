{EnemySpawner} = require "../coffee/enemy_spawner.coffee"
{atom} = require "../spec/mock/atom_mock.coffee"

describe "An enemy spawner", ->
  enemy = spawned = spawner = undefined
  dt = .05

  beforeEach ->
    spawner = new EnemySpawner
    spawned = []
    spawner.on "spawn", (enemy) ->
      spawned.push enemy

  tick = (num=1) ->
    for i in [1..num]
      spawner.update dt

  isInsidelevel = (enemy) ->
    -enemy.getRadius() < enemy.getPos().x < atom.width + enemy.getRadius() and
        -enemy.getRadius() < enemy.getPos().y < atom.height + enemy.getRadius()

  it "spawns enemies based on spawn requests", ->
    spawner.setSpawnRequests [{ time: 0, spawn: [{ type: 'bat', rate: 1 }]}]
    tick 3.5 / dt
    expect(spawned.length).toBe 4

  it "spawns enemies after 1 update when a new spawn request is set", ->
    spawner.setSpawnRequests [{ time: 0, spawn: [{ type: 'bat', rate: 1 }]}]
    tick()
    expect(spawned.length).toBe 1

  it "can spawn multiple types of enemies spawning", ->
    toSpawn = [{ type: 'bat', rate: 1 }, { type: 'enemy', rate: .5 }]
    spawner.setSpawnRequests [{ time: 0, spawn: toSpawn }]
    tick 3.6 / dt

    bats = (e for e in spawned when e.getType() is 'bat')
    enemies = (e for e in spawned when e.getType() is 'enemy')
    expect(bats.length).toBe 4
    expect(enemies.length).toBe 8

  it "can spawn multiple enemies on one update", ->
    spawner.setSpawnRequests [{ time: 0, spawn: [{ type: 'bat', rate: 1 }]}]
    spawner.update 3.5
    expect(spawned.length).toBe 4

  it "can change which enemies spawn at different times", ->
    spawner.setSpawnRequests [
      { time: 0, spawn: [{ type: 'bat', rate: 1 }]},
      { time: 1.5, spawn: [{ type: 'enemy', rate: .5 }]}]
    tick 3.6 / dt

    bats = (e for e in spawned when e.getType() is 'bat')
    enemies = (e for e in spawned when e.getType() is 'enemy')
    expect(bats.length).toBe 2
    expect(enemies.length).toBe 5

  it "can spawn enemies immediately", ->
    spawner.setSpawnRequests [{
      time: 0,
      spawnImmediately: { type: 'bat', quantity: 2 }}]
    tick()
    expect(spawned.length).toBe 2

  it "is done when no spawn requests remain", ->
    spawner.setSpawnRequests [
      { time: 0, spawn: [{ type: 'bat', rate: 1 }]},
      { time: 2.5 } ]
    expect(spawner.isDoneSpawningEnemies()).toBe false
    tick 3.5 / dt
    expect(spawned.length).toBe 3
    expect(spawner.isDoneSpawningEnemies()).toBe true

  it "can have different spawn requests set", ->
    spawner.setSpawnRequests [
      { time: 0, spawn: [{ type: 'bat', rate: 1 }]},
      { time: 2.5 } ]
    tick 3.5 / dt
    spawned = []
    spawner.setSpawnRequests [
      { time: 0, spawn: [{ type: 'enemy', rate: .5 }]},
      { time: 2.6 } ]
    tick 3.6 / dt
    expect(spawned.length).toBe 6

  it "spawns enemies just outside the displayed level", ->
    spawner.setSpawnRequests [{ time: 0, spawn: [{ type: 'bat', rate: 1 }]}]
    tick 3 / dt
    for enemy in spawned
      expect(isInsidelevel enemy).toBe false

  it "spawns enemies randomly around the level", ->
    spawner.setSpawnRequests [{ time: 0, spawn: [{ type: 'bat', rate: 1 }]}]
    tick 3 / dt
    for i in [0..spawned.length - 2]
      for j in [i + 1..spawned.length - 1]
        expect(spawned[i].getPos()).not.toEqual spawned[j].getPos()
