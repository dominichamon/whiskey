part of whiskey;

// TODO(dominic): Allow scaling of sprite.
class Sprite {
  Sprite(String filename, this._x, this._y)
      : _image = new ImageElement(src: filename),
        _loaded = false {
    _image.onLoad.listen((e) => _onImageLoaded(e.target as ImageElement));
  }

  factory Sprite._fromJSON(Map<String, dynamic> json) {
    switch (json['type']) {
      case 'sprite': return new Sprite(json['filename'], json['x'], json['y']);
      case 'animated_sprite':
        return new AnimatedSprite(json['filename'], json['x'], json['y'],
            json['framewidth'], json['frameheight'], json['loop']);
    }
    assert(false);
  }

  void _onImageLoaded(ImageElement e) {
    assert(!_loaded);
    print('Sprite.loaded ${e.src}');
    _loaded = true;
  }

  void _update(num timestep) {}

  void _draw(CanvasRenderingContext2D ctx) {
    if (!_loaded) return;

    ctx.drawImageScaled(_image, _scene._scaleWidth(_x), _scene._scaleHeight(_y),
                        _scene._scaleWidth(_image.width),
                        _scene._scaleHeight(_image.height));
  }

  Map<String, dynamic> _toJSON() {
    Map<String, dynamic> attributes = new Map();
    attributes['x'] = _x;
    attributes['y'] = _y;
    attributes['filename'] = _image.src;
    attributes['type'] = 'sprite';
    return attributes;
  }

  int _x;
  int _y;
  ImageElement _image;
  bool _loaded;
}
