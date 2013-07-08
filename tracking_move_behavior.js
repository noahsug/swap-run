// Generated by CoffeeScript 1.6.2
(function() {
  var MoveBehavior, TrackingMoveBehavior, _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  MoveBehavior = require("../coffee/move_behavior.coffee").MoveBehavior;

  exports.TrackingMoveBehavior = TrackingMoveBehavior = (function(_super) {
    __extends(TrackingMoveBehavior, _super);

    function TrackingMoveBehavior() {
      _ref = TrackingMoveBehavior.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    TrackingMoveBehavior.prototype.determineVelocityVector_ = function() {
      var target;

      this.velocityVector_.x = this.velocityVector_.y = 0;
      target = this.knowledge_.getPlayer();
      if (!(target && target.isActive())) {
        return;
      }
      this.velocityVector_.x = target.getPos().x - this.movingEntity_.getPos().x;
      return this.velocityVector_.y = target.getPos().y - this.movingEntity_.getPos().y;
    };

    return TrackingMoveBehavior;

  })(MoveBehavior);

}).call(this);

/*
//@ sourceMappingURL=tracking_move_behavior.map
*/