import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notepad/models/notepad_model.dart';
import 'package:notepad/providers/notepad_provider.dart';
import 'package:notepad/screens/add_notepad_screeen.dart';
import 'package:notepad/screens/list_notepad_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if(!Hive.isAdapterRegistered(NotePadModelAdapter().typeId)){
    Hive.registerAdapter(NotePadModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>NotePadProvider(),),
      ],
      child: MaterialApp(
        title: 'Private Notes',
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        home:  ListNotePadScreen(),
      ),
    );
  }
}


