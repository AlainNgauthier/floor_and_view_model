import 'package:floor/floor.dart';
import 'package:floor_stream_app/model/person.dart';

@dao
abstract class PersonDao {
  @Query('SELECT * FROM Person')
  Stream<List<Person>> findAllPersons();

  @insert
  Future<void> insertPerson(Person person);
}
