// Generated by CoffeeScript 1.6.2
(function() {
  var GameInfo, util,
    __slice = [].slice;

  util = require("../coffee/util.coffee").util;

  exports.GameInfo = GameInfo = (function() {
    function GameInfo() {
      this.init_();
    }

    GameInfo.prototype.init_ = function() {
      this.enemies_ = [];
      this.state_ = 'playing';
      return this.score_ = 0;
    };

    GameInfo.prototype.reset = function() {
      return this.init_();
    };

    GameInfo.prototype.setState = function(state_) {
      this.state_ = state_;
    };

    GameInfo.prototype.getState = function() {
      return this.state_;
    };

    GameInfo.prototype.getScore = function() {
      return this.score_;
    };

    GameInfo.prototype.setScore = function(score_) {
      this.score_ = score_;
    };

    GameInfo.prototype.addScore = function(amount) {
      return this.score_ += amount;
    };

    GameInfo.prototype.setPlayer = function(player_) {
      this.player_ = player_;
    };

    GameInfo.prototype.getPlayer = function() {
      return this.player_;
    };

    GameInfo.prototype.setEnemies = function(enemies_) {
      this.enemies_ = enemies_;
    };

    GameInfo.prototype.getEnemies = function() {
      return this.enemies_;
    };

    GameInfo.prototype.addEnemy = function(enemy) {
      return this.enemies_.push(enemy);
    };

    GameInfo.prototype.getEntities = function() {
      if (this.player_) {
        return [this.player_].concat(__slice.call(this.enemies_));
      } else {
        return this.enemies_;
      }
    };

    GameInfo.prototype.getNearestEnemyTo = function(pos) {
      var distanceSquared, enemy, maxDistanceSquared, nearestEnemy, _i, _len, _ref;

      maxDistanceSquared = Infinity;
      nearestEnemy = null;
      _ref = this.getEnemies();
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        enemy = _ref[_i];
        distanceSquared = util.distanceSquared(enemy.getPos(), pos);
        if (distanceSquared < maxDistanceSquared) {
          maxDistanceSquared = distanceSquared;
          nearestEnemy = enemy;
        }
      }
      return nearestEnemy;
    };

    GameInfo.prototype.getActiveEnemies = function() {
      var e, _i, _len, _ref, _results;

      _ref = this.enemies_;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        e = _ref[_i];
        if (e.isActive()) {
          _results.push(e);
        }
      }
      return _results;
    };

    GameInfo.prototype.getCollidedEntities = function() {
      var collided, e, entities, entity1, entity2, i, j, _i, _j, _k, _len, _ref, _ref1, _ref2, _results;

      entities = this.getEntities();
      collided = [];
      for (i = _i = 0, _ref = entities.length - 2; _i <= _ref; i = _i += 1) {
        entity1 = entities[i];
        for (j = _j = _ref1 = i + 1, _ref2 = entities.length - 1; _j <= _ref2; j = _j += 1) {
          entity2 = entities[j];
          if (this.entitiesCollide_(entity1, entity2)) {
            collided[i] = entity1;
            collided[j] = entity2;
          }
        }
      }
      _results = [];
      for (_k = 0, _len = collided.length; _k < _len; _k++) {
        e = collided[_k];
        if (e != null) {
          _results.push(e);
        }
      }
      return _results;
    };

    GameInfo.prototype.entitiesCollide_ = function(entity1, entity2) {
      var distance;

      distance = util.distance(entity1.getPos(), entity2.getPos());
      return distance < entity1.getRadius() + entity2.getRadius();
    };

    return GameInfo;

  })();

}).call(this);

/*
//@ sourceMappingURL=game_info.map
*/