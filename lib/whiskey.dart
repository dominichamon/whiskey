library whiskey;

import 'dart:async';
import 'dart:html';
import 'dart:json' as JSON;

part 'src/animated_sprite.dart';
part 'src/application.dart';
part 'src/behaviour.dart';
part 'src/behaviours/changebehaviour.dart';
part 'src/behaviours/movethingby.dart';
part 'src/behaviours/movethingto.dart';
part 'src/behaviours/sequence.dart';
part 'src/hotspot.dart';
part 'src/page.dart';
part 'src/scene.dart';
part 'src/sprite.dart';
part 'src/thing.dart';
part 'src/words.dart';

Application _application = new Application();
Scene _scene = null;

void loadScene(int width, int height, String json) {
  assert(_scene == null);
  Map<String, dynamic> sceneJSON = JSON.parse(json);
  _scene = new Scene._fromJSON(width, height, sceneJSON);
}

String saveScene() => JSON.stringify(_scene._toJSON());

Scene scene() => _scene;

void setApplication(Application a) {
  assert(a != null);
  _application = a;
}

void run() {
  window.requestAnimationFrame((num timestep) {
      _frame(timestep);
  });
}

void _createScene(int width, int height) {
  assert(_scene == null);
  _scene = new Scene(width, height);
}

void _frame(num timestep) {
  _application.preRenderCallback(_scene._context);
  _scene._frame(timestep);
  _application.postRenderCallback(_scene._context);
  window.requestAnimationFrame(_frame);
}

String createTestSceneJSON() {
  _createScene(800, 600);
  final robot_sheet = new Thing(new Sprite('data/robot2.png', 0, 0));
 
  final robot = new Thing(
      new AnimatedSprite('data/robot2.png', 50, 50, 200, 200, true));
  robot._hotspot = new HotSpot(
      robot._x, robot._y, robot._x + 200, robot._y + 200);
  robot._onClick = new Sequence(
      [new MoveThingBy(200, 0), new MoveThingBy(-200, 0)],
      200);

  var robot_page = new Page();
  robot_page._add(robot_sheet);
  robot_page._add(robot);

  var alien_page = new Page();
  alien_page._add(new Thing(new Sprite('data/alien.jpg', 60, 60)));
  alien_page._addWords(new Words(0, 0, 55, 'Hello World!', '14 px sans-serif'));

  _scene._add(robot_page);
  _scene._add(alien_page);

  String sceneJSON = saveScene();
  _scene = null;
  return sceneJSON;
}
