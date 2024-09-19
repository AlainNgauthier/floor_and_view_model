import 'dart:async';
import 'package:floor/floor.dart';
import 'package:floor_stream_app/dao/person_dao.dart';
import 'package:floor_stream_app/model/person.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 1, entities: [Person])
abstract class AppDatabase extends FloorDatabase {
  PersonDao get personDao;
}
