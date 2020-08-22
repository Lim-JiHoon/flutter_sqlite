import 'dart:async';

import 'package:flutter_sqlite/models/dog_model.dart';
import 'package:flutter_sqlite/services/dog_helper.dart';

class DogBloc {
  DogBloc() {
    getDogs();
  }
  final _dogsController = StreamController<List<Dog>>.broadcast();
  get dogStream => _dogsController.stream;

  dispose() {
    _dogsController.close();
  }

  getDogs() async {
    List<Dog> dogs = await DogHelper().select();
    _dogsController.sink.add(dogs);
  }

  insertDogs(Dog dog) async {
    await DogHelper().insert(dog);
    getDogs();
  }

  updateDogs(int id, Dog dog) async {
    await DogHelper().update(id, dog);
    getDogs();
  }

  deleteDogs(int id) async {
    await DogHelper().delete(id);
    getDogs();
  }

  deleteAllDogs() async {
    await DogHelper().deleteAll();
    getDogs();
  }
}
