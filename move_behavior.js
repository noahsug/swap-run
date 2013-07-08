// Generated by CoffeeScript 1.6.2
(function() {
  var MoveBehavior, util;

  util = require("../coffee/util.coffee").util;

  exports.MoveBehavior = MoveBehavior = (function() {
    function MoveBehavior() {
      this.velocityVector_ = {
        x: 0,
        y: 0
      };
    }

    MoveBehavior.prototype.setMovingEntity = function(movingEntity_) {
      this.movingEntity_ = movingEntity_;
    };

    MoveBehavior.prototype.setKnowledge = function(knowledge_) {
      this.knowledge_ = knowledge_;
    };

    MoveBehavior.prototype.getVelocityVector = function() {
      this.determineVelocityVector_();
      this.normalizeVelocityVector_();
      return this.velocityVector_;
    };

    MoveBehavior.prototype.determineVelocityVector_ = function() {};

    MoveBehavior.prototype.normalizeVelocityVector_ = function() {
      var slope, xVelocity, _ref;

      if ((this.velocityVector_.x === (_ref = this.velocityVector_.y) && _ref === 0)) {
        return;
      }
      slope = Math.abs(this.velocityVector_.y / this.velocityVector_.x);
      if (slope === Infinity) {
        return this.velocityVector_.y = util.sign(this.velocityVector_.y);
      } else {
        xVelocity = 1 / Math.sqrt(1 + Math.pow(slope, 2));
        this.velocityVector_.x = xVelocity * util.sign(this.velocityVector_.x);
        return this.velocityVector_.y = slope * xVelocity * util.sign(this.velocityVector_.y);
      }
    };

    return MoveBehavior;

  })();

}).call(this);

/*
//@ sourceMappingURL=move_behavior.map
*/
