{EnemySpawner} = require "../coffee/enemy_spawner.coffee"
{MoveBehavior} = require "../coffee/move_behavior.coffee"
{atom} = require "../spec/mock/atom_mock.coffee"

describe "An enemy spawner", ->
  enemy = moveBehavior = spawned = spawner = undefined
  dt = .05

  beforeEach ->
    spawner = new EnemySpawner
    moveBehavior = new MoveBehavior
    spawned = []
    spawner.on "spawn", (enemy) ->
      spawned.push enemy
      enemy.setMoveBehavior moveBehavior

  tick = (num=1) ->
    for i in [1..num]
      spawner.update dt

  isInsidelevel = (enemy) ->
    -enemy.getRadius() < enemy.getPos().x < atom.width + enemy.getRadius() and
        -enemy.getRadius() < enemy.getPos().y < atom.height + enemy.getRadius()

  it "spawns enemies after a certain period of time", ->
    spawner.update 2
    expect(spawned.length).toBeGreaterThan 0

  it "spawns 4 enemies after 3 seconds", ->
    tick 3 / dt
    expect(spawned.length).toBe 4

  it "can spawn multiple enemies at once", ->
    spawner.update 2
    expect(spawned.length).toBe 3

  it "spawns enemies just outside the displayed level", ->
    tick 3 / dt
    for enemy in spawned
      expect(isInsidelevel enemy).toBe false

  it "spawns enemies randomly around the level", ->
    tick 3 / dt
    for i in [0..spawned.length - 2]
      for j in [i + 1..spawned.length - 1]
        expect(spawned[i].getPos()).not.toEqual spawned[j].getPos()
