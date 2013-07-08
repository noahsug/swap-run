// Generated by CoffeeScript 1.6.2
(function() {
  var BackgroundGraphic, Factory, Graphic, GraphicFactory, Sprite, _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    __slice = [].slice;

  Graphic = require("../coffee/graphic.coffee").Graphic;

  BackgroundGraphic = require("../coffee/background_graphic.coffee").BackgroundGraphic;

  Factory = require("../coffee/factory.coffee").Factory;

  Sprite = require("../spec/mock/sprite_mock.coffee").Sprite;

  exports.GraphicFactory = GraphicFactory = (function(_super) {
    __extends(GraphicFactory, _super);

    function GraphicFactory() {
      _ref = GraphicFactory.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    GraphicFactory.create = function(type) {
      return Factory.create(this, type);
    };

    GraphicFactory.getImagesToPreload = function() {
      return GraphicFactory.getImagePaths('sand_tile.png', 'death.png');
    };

    GraphicFactory.getImagePaths = function() {
      var fileName, fileNames, _i, _len, _results;

      fileNames = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      _results = [];
      for (_i = 0, _len = fileNames.length; _i < _len; _i++) {
        fileName = fileNames[_i];
        _results.push(GraphicFactory.getImagePath(fileName));
      }
      return _results;
    };

    GraphicFactory.getImagePath = function(fileName) {
      return "../assets/" + fileName;
    };

    GraphicFactory.prototype.creationMethods_ = {
      "background": function() {
        var background, sprite;

        sprite = new Sprite(GraphicFactory.getImagePath('sand_tile.png'), {
          frameW: 96,
          frameH: 96
        });
        background = new BackgroundGraphic(sprite);
        background.setFrameOccurrenceRatios([4, 2, 128, 0, 16, 8]);
        return background;
      },
      "death": function() {
        var sprite;

        sprite = new Sprite(GraphicFactory.getImagePath('death.png'), {
          frameW: 48,
          frameH: 48,
          interval: 75
        });
        return new Graphic(sprite);
      }
    };

    return GraphicFactory;

  })(Factory);

}).call(this);

/*
//@ sourceMappingURL=graphic_factory.map
*/
