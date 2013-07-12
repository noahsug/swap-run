{Level} = require "../coffee/level.coffee"
{LevelFactory} = require "../coffee/level_factory.coffee"

describe "A level", ->
  level = spawned = undefined
  dt = .05

  tick = (num=1) ->
    for i in [1..num]
      level.update dt

  beforeEach ->
    level = LevelFactory.createLevel 1
    spawned = []
    level.on "spawn", (enemy) ->
      spawned.push enemy

  it "has a number", ->
    expect(level.getNumber()).toBe 1

  it "has a title", ->
    expect(level.getTitle()).toBeDefined()

  it "spawns enemies after a certain amount of time", ->
    tick 1 / dt
    expect(spawned.length).toBeGreaterThan 0
    expect(spawned[0].getPos()).toBeDefined()
