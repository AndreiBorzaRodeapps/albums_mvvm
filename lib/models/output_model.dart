import 'dart:async';

class Output<T> {
  final Stream<T> stream;

  Output(this.stream);
}
