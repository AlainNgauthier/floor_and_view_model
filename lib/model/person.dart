import 'package:floor/floor.dart';

@entity
class Person {
  @primaryKey
  final int id;
  final String name;
  final int age;

  Person(this.id, this.name, this.age);
}
