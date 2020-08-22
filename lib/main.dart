import 'package:flutter/material.dart';
import 'package:flutter_sqlite/bloc/dog_bloc.dart';
import 'models/dog_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DogBloc _bloc = DogBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
              child: Column(
            children: [
              OutlineButton(
                child: Text('insert'),
                onPressed: () {
                  _bloc.insertDogs(Dog(id: 1, name: 'rrrrr', age: 11));
                },
              ),
              OutlineButton(
                child: Text('Select'),
                onPressed: () {},
              ),
              OutlineButton(
                child: Text('DeleteAll'),
                onPressed: () {
                  _bloc.deleteAllDogs();
                },
              ),
              Expanded(
                child: StreamBuilder(
                  stream: _bloc.dogStream,
                  builder: (context, AsyncSnapshot<List<Dog>> snapshot) {
                    return snapshot.hasData
                        ? ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              Dog dog = snapshot.data[index];
                              return ListTile(
                                onTap: () {
                                  _bloc.updateDogs(dog.id,
                                      Dog(id: dog.id, name: 'ㅋㅋㅋ', age: 11));
                                },
                                onLongPress: (){
                                  _bloc.deleteDogs(dog.id);
                                },
                                title: Text(dog.id.toString()),
                                leading: Text(dog.name),
                                trailing: Text(dog.age.toString()),
                              );
                            },
                          )
                        : Center(
                            child: Text('no data'),
                          );
                  },
                ),
              )
            ],
          )
              //child: Text('akk'.change('a', 'b')).addContainer(),
              ),
        ),
      ),
    );
  }
}

extension StringExtension on String {
  get firstLetterToUpperCase {
    if (this != null)
      return this[0].toUpperCase() + this.substring(1);
    else
      return null;
  }

  change(String main, String want) {
    if (this != null) {
      return this.replaceAll(main, want);
    } else {
      return '';
    }
  }
}

extension ExtendedText on Widget {
  addContainer() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      color: Colors.yellow,
      child: this,
    );
  }
}
