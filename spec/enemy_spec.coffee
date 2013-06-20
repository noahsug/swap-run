{Enemy} = require "../coffee/enemy.coffee"
{Entity} = require "../coffee/entity.coffee"
{jasmine_env} = require "../spec/jasmine_env.coffee"
{util} = require "../coffee/util.coffee"

describe "An enemy", ->
  enemy = target = undefined

  beforeEach ->
    jasmine_env.init this
    enemy = new Enemy()
    target = new Entity()
    enemy.setTarget target
    enemy.setSpeed 5

  it "moves towards its target", ->
    enemy.setPos x: 32, y: 96
    target.setPos x: 54, y: 3
    distance = util.distance enemy.getPos(), target.getPos()
    enemy.update(2)
    newDistance = util.distance enemy.getPos(), target.getPos()
    expect(distance - newDistance).toAlmostBe 10.0
