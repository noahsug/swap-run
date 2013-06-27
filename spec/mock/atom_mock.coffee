exports.atom =

  width: 100
  height: 150

  context:
    setAlpha: ->
    fillRect: ->
    fillText: ->
    clearRect: ->

  Game: class Game

  input:
    down_: {}
    pressed_: {}
    released_: {}

    down: (action) -> @down_[action]
    pressed: (action) -> @pressed_[action]
    released: (action) -> @released_[action]

    press: (action) ->
      @pressed_[action] = true
      @down_[action] = true
      @released_[action] = false

    hold: (action) ->
      @pressed_[action] = false
      @down_[action] = true
      @released_[action] = false

    release: (action) ->
      @pressed_[action] = false
      @down_[action] = false
      @released_[action] = true

    reset: ->
      @pressed_ = {}
      @down_ = {}
      @released_ = {}
