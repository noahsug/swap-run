// Generated by CoffeeScript 1.6.2
(function() {
  var GraphicFactory, SpriteBuilder, SpriteMap;

  GraphicFactory = require("../coffee/graphic_factory.coffee").GraphicFactory;

  SpriteMap = require("../spec/mock/sprite_map_mock.coffee").SpriteMap;

  exports.SpriteBuilder = SpriteBuilder = (function() {
    function SpriteBuilder() {}

    SpriteBuilder.prototype.build = function(imgName_, options_) {
      this.imgName_ = imgName_;
      this.options_ = options_ != null ? options_ : {};
      this.addAnimations_();
      this.addSpriteOptions_();
      return this.buildSpriteMap_();
    };

    SpriteBuilder.prototype.addAnimations_ = function() {
      var animationName, _i, _len, _ref, _results;

      this.animations_ = {};
      _ref = this.getAnimationNames_();
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        animationName = _ref[_i];
        _results.push(this.addAnimation_(animationName));
      }
      return _results;
    };

    SpriteBuilder.prototype.addAnimation_ = function(name) {
      var option, _ref, _ref1;

      option = this.getOptionForAnimation_(name);
      if (!option) {
        return;
      }
      return this.animations_[name] = {
        startRow: (_ref = option.startRow) != null ? _ref : option.row,
        endRow: (_ref1 = option.endRow) != null ? _ref1 : option.row,
        startCol: option.startCol,
        endCol: option.endCol,
        flipped: option.flipped
      };
    };

    SpriteBuilder.prototype.getAnimationNames_ = function() {
      return ['right', 'left', 'up', 'down', 'right-still', 'left-still', 'up-still', 'down-still', 'death'];
    };

    SpriteBuilder.prototype.getOptionForAnimation_ = function(animationName) {
      var _ref, _ref1;

      if (!(animationName in this.options_)) {
        if (animationName.indexOf('-still') === -1) {
          return (_ref = this.options_['moving']) != null ? _ref : {};
        } else {
          return (_ref1 = this.options_['still']) != null ? _ref1 : {};
        }
      } else {
        return this.options_[animationName];
      }
    };

    SpriteBuilder.prototype.addSpriteOptions_ = function() {
      var _ref, _ref1, _ref2;

      return this.spriteOptions_ = {
        frameW: (_ref = this.options_.frameW) != null ? _ref : 64,
        frameH: (_ref1 = this.options_.frameH) != null ? _ref1 : 64,
        interval: (_ref2 = this.options_.interval) != null ? _ref2 : 100
      };
    };

    SpriteBuilder.prototype.buildSpriteMap_ = function() {
      var filePath;

      filePath = GraphicFactory.getImagePath(this.imgName_);
      return new SpriteMap(filePath, this.animations_, this.spriteOptions_);
    };

    return SpriteBuilder;

  })();

}).call(this);

/*
//@ sourceMappingURL=sprite_builder.map
*/
