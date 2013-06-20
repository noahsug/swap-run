{EnemySpawner} = require "../coffee/enemy_spawner.coffee"

describe "An enemy spawner", ->
  enemy = spawned = spawner = undefined

  beforeEach ->
    spawner = new EnemySpawner
    spawned = []
    spawner.on "spawn", (enemy) ->
      spawned.push enemy

  tick = (num=1) ->
    for i in [1..num]
      spawner.update .05

  it "spawns enemies after a certain period of time", ->
    spawner.update 2
    expect(spawned.length).toBeGreaterThan 0

  it "spawns 4 enemies after 3 seconds", ->
    tick 3 / .05
    expect(spawned.length).toBe 4

  it "can spawn multiple enemies at once", ->
    spawner.update 2
    expect(spawned.length).toBe 3
