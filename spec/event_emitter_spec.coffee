{EventEmitter} = require "../coffee/event_emitter.coffee"

describe "An event emitter", ->
  emitter = undefined

  beforeEach ->
    emitter = new EventEmitter

  it "emits events to registered listeners", ->
    onEat = jasmine.createSpy 'onEat'
    emitter.on 'eat', onEat
    emitter.emit 'eat', 'burgers'
    expect(onEat).toHaveBeenCalledWith 'burgers'

  it "doesn't emit events to non-registered listeners", ->
    onEat = jasmine.createSpy 'onEat'
    emitter.on 'eat', onEat
    emitter.emit 'cook', 'burgers'
    expect(onEat).not.toHaveBeenCalledWith 'burgers'
