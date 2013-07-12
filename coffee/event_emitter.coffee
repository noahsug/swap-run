exports.EventEmitter = class EventEmitter
  constructor: ->
    @eventCallbacks_ = {}

  on: (event, callback) ->
    (@eventCallbacks_[event] ?= []).push callback

  clear: (event, callback) ->
    @eventCallbacks_[event] =
        (cb for cb in @eventCallbacks_[event] when cb isnt callback)

  emit: (event, args...) ->
    return unless event of @eventCallbacks_
    for callback in @eventCallbacks_[event]
      callback(args...)
