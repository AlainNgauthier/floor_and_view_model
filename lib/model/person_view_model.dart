import 'package:floor_stream_app/bd/app_database.dart';
import 'package:floor_stream_app/dao/person_dao.dart';
import 'package:flutter/material.dart';
import 'person.dart';
// import 'app_database.dart';

class PersonViewModel extends ChangeNotifier {
  final AppDatabase database;
  late final PersonDao personDao;

  PersonViewModel(this.database) {
    personDao = database.personDao;
  }

  Stream<List<Person>> get persons => personDao.findAllPersons();

  Future<void> addPerson(String name, int age) async {
    final person = Person(123, name, age);
    await personDao.insertPerson(person);
    notifyListeners();
  }
}
