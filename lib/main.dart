import 'package:floor_stream_app/bd/app_database.dart';
import 'package:floor_stream_app/model/person.dart';
import 'package:floor_stream_app/model/person_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  runApp(MyApp(database));
}

class MyApp extends StatelessWidget {
  final AppDatabase database;
  MyApp(this.database);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PersonViewModel(database),
      child: MaterialApp(
        home: PersonScreen(),
      ),
    );
  }
}

class PersonScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<PersonViewModel>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Person List')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: ageController,
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final name = nameController.text;
              final age = int.tryParse(ageController.text);
              if (name.isNotEmpty && age != null) {
                viewModel.addPerson(name, age);
              }
            },
            child: Text('Add'),
          ),
          Expanded(
            child: StreamBuilder<List<Person>>(
              stream: viewModel.persons,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No persons found'));
                } else {
                  final persons = snapshot.data!;
                  return ListView.builder(
                    itemCount: persons.length,
                    itemBuilder: (context, index) {
                      final person = persons[index];
                      return ListTile(
                        title: Text(person.name),
                        subtitle: Text('Age: ${person.age}'),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
