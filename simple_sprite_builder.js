// Generated by CoffeeScript 1.6.2
(function() {
  var SimpleSpriteBuilder, SpriteBuilder, _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  SpriteBuilder = require("../coffee/sprite_builder.coffee").SpriteBuilder;

  exports.SimpleSpriteBuilder = SimpleSpriteBuilder = (function(_super) {
    __extends(SimpleSpriteBuilder, _super);

    function SimpleSpriteBuilder() {
      _ref = SimpleSpriteBuilder.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    SimpleSpriteBuilder.prototype.animationRows_ = {
      'right': 1,
      'left': 1,
      'right-still': 2,
      'left-still': 2,
      'up': 4,
      'up-still': 5,
      'down': 7,
      'down-still': 8
    };

    SimpleSpriteBuilder.prototype.addAnimations_ = function() {
      SimpleSpriteBuilder.__super__.addAnimations_.call(this);
      this.setAnimationRows_();
      return this.flipLeftAnimations_();
    };

    SimpleSpriteBuilder.prototype.setAnimationRows_ = function() {
      var animationName, row, startingIndex, _i, _len, _ref1, _results;

      startingIndex = this.options_.hasDeath ? 1 : 0;
      _ref1 = this.getAnimationNames_();
      _results = [];
      for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
        animationName = _ref1[_i];
        row = startingIndex + this.animationRows_[animationName];
        this.animations_[animationName].startRow = row;
        _results.push(this.animations_[animationName].endRow = row);
      }
      return _results;
    };

    SimpleSpriteBuilder.prototype.flipLeftAnimations_ = function() {
      var animationName, _i, _len, _ref1, _results;

      _ref1 = ['left', 'left-still'];
      _results = [];
      for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
        animationName = _ref1[_i];
        _results.push(this.animations_[animationName].flipped = {
          horizontal: true
        });
      }
      return _results;
    };

    return SimpleSpriteBuilder;

  })(SpriteBuilder);

}).call(this);

/*
//@ sourceMappingURL=simple_sprite_builder.map
*/
