class Thing {
  Thing(this._sprite) : _hotspot = null, _onClick = null;

  void _update(num timestep) {
    _sprite._update(timestep);
  }

  void _draw(CanvasRenderingContext2D context) {
    // TODO: pass through the timestep to allow animated sprites to be locked to
    // a particular frame-rate.
    _sprite._draw(context);
  }

  bool _is_hit(int x, int y) => _hotspot !== null && _hotspot.is_hit(x, y);

  int get _x() => _sprite._x;
  void set _x(int x) {
    _sprite._x = x;
    _hotspot._x = x;
  }

  int get _y() => _sprite._y;
  void set _y(int y) {
    _sprite._y = y;
    _hotspot._y = y;
  }

  Map<String, Dynamic> _toJSON() {
    Map<String, Dynamic> attributes = new Map();
    attributes['sprite'] = _sprite._toJSON();
    attributes['hotspot'] = _hotspot == null ? null : _hotspot._toJSON();
    attributes['onClick'] = _onClick == null ? null : _onClick._toJSON();
    return attributes;
  }

  Sprite _sprite;
  HotSpot _hotspot;
  Behaviour _onClick;
}