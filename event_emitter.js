// Generated by CoffeeScript 1.6.2
(function() {
  var EventEmitter,
    __slice = [].slice;

  exports.EventEmitter = EventEmitter = (function() {
    function EventEmitter() {
      this.eventCallbacks_ = {};
    }

    EventEmitter.prototype.on = function(event, callback) {
      var _base, _ref;

      return ((_ref = (_base = this.eventCallbacks_)[event]) != null ? _ref : _base[event] = []).push(callback);
    };

    EventEmitter.prototype.emit = function() {
      var args, callback, event, _i, _len, _ref, _results;

      event = arguments[0], args = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
      if (!(event in this.eventCallbacks_)) {
        return;
      }
      _ref = this.eventCallbacks_[event];
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        callback = _ref[_i];
        _results.push(callback.apply(null, args));
      }
      return _results;
    };

    return EventEmitter;

  })();

}).call(this);

/*
//@ sourceMappingURL=event_emitter.map
*/
