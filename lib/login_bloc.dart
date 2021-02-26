import 'dart:async';

class LoginBloc{
  final stateStreamController=StreamController<int>();
  StreamSink<int> get counterSink =>stateStreamController.sink;
  Stream<int> get counterStream =>stateStreamController.stream;

  final eventStreamController=StreamController<int>();
  StreamSink<int> get eventSink =>eventStreamController.sink;
  Stream<int> get eventStream =>eventStreamController.stream;
  CounterBloc(){
    eventStream.listen((event) {
      event++;
      counterSink.add(event);
    });
  }
  void dispose(){
    stateStreamController.close();
    eventStreamController.close();
  }
}