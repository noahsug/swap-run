{Entity} = require "../coffee/entity.coffee"
{GameInfo} = require "../coffee/game_info.coffee"
{Renderer} = require "../coffee/renderer.coffee"

describe "A renderer", ->
  callCount = renderer = gameInfo = undefined

  beforeEach ->
    gameInfo = new GameInfo
    renderer = new Renderer gameInfo
    callCount = 0

  addEntityAtPos = (pos) ->
    entity = new Entity
    entity.setPos pos
    gameInfo.addEnemy entity
    entity.draw = -> entity.drawCallOrder = callCount++
    entity

  it "draws entities in ascending order by y-coordinate", ->
    entity1 = addEntityAtPos x: 49, y: 82
    entity2 = addEntityAtPos x: 32, y: 0
    entity3 = addEntityAtPos x: 0, y: 33
    entity4 = addEntityAtPos x: 98, y: 24
    renderer.draw()
    expect(entity2.drawCallOrder).toBeLessThan entity4.drawCallOrder
    expect(entity4.drawCallOrder).toBeLessThan entity3.drawCallOrder
    expect(entity3.drawCallOrder).toBeLessThan entity1.drawCallOrder
