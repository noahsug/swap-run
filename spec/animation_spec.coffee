{Animation} = require "../coffee/animation.coffee"

describe 'An animation', ->
  animation = undefined

  beforeEach ->
    animation = new Animation

  it 'can vary a variable over a period of time', ->
    animation.vary('x').from(1).to(10).forDuration(3)
    animation.start()
    expect(animation.get 'x').toBe 1
    animation.update(1)
    expect(animation.get 'x').toBe 4
    animation.update(1)
    expect(animation.get 'x').toBe 7
    animation.update(1)
    expect(animation.get 'x').toBe 10
    animation.update(1)
    expect(animation.get 'x').toBe 10

  it 'stops updating a variable once it reaches the end value', ->
    animation.vary('x').from(1).to(10).forDuration(3)
    animation.start()
    animation.update(100)
    expect(animation.get 'x').toBe 10

  it 'has a default start value of 0', ->
    animation.vary('alpha').to(1).forDuration(2)
    animation.start()
    animation.update(1)
    expect(animation.get 'alpha').toBe .5

  it 'finished after all variables have been varied for their duration', ->
    animation.vary('alpha').to(1).forDuration(1)
    animation.start()
    animation.update(1)
    expect(animation.isFinished()).toBe true

  it 'reports being finished if it was never started', ->
    animation.vary('alpha').from(0).to(1).forDuration(2)
    animation.update 1
    expect(animation.isFinished()).toBe true

    animation.start()
    expect(animation.isFinished()).toBe false
