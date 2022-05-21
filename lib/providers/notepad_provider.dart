

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:notepad/models/notepad_model.dart';
import 'package:intl/intl.dart';

class NotePadProvider extends ChangeNotifier{
  TextEditingController titleTC =TextEditingController();
  TextEditingController discTC =TextEditingController();
  List<NotePadModel> filterList=[];
  List<NotePadModel> notepadList=[];
  bool isSearch=false;
  DateTime created =DateTime.now();
  DateTime edited =DateTime.now();
  final formatter = DateFormat('dd MMM yyyy hh:mm a');

  NotePadProvider(){
    funGetNoteList();
  }

  void funSaveNote() async {
    final notepadDb = await  Hive.openBox<NotePadModel>('notepad_db');
    final notepadModel = NotePadModel( title: titleTC.text, description: discTC.text, createdAt: DateTime.now(), updatedAt: DateTime.now());
    final id=await notepadDb.add(notepadModel);
    notepadModel.key=id;
    notepadDb.put(id, notepadModel);
    titleTC.clear();
    discTC.clear();
    funGetNoteList();
  }
  funGetNoteList()async{
    final notepadDb = await  Hive.openBox<NotePadModel>('notepad_db');
    notepadList.clear();
    notepadList.addAll(notepadDb.values);
    filterList=notepadList;
    notifyListeners();

  }
  funDeleteNote(int? key) async {
    final notepadDb = await  Hive.openBox<NotePadModel>('notepad_db');
    if(key!=null){
      notepadDb.delete(key);
    }
    funGetNoteList();
  }

  funEditNote(DateTime createdAt,int key) async {
    final notepadDb = await  Hive.openBox<NotePadModel>('notepad_db');
    final notepadModel = NotePadModel(key:key , title: titleTC.text, description: discTC.text, createdAt: createdAt, updatedAt: DateTime.now());
    notepadDb.put(key, notepadModel);
    titleTC.clear();
    discTC.clear();
    funGetNoteList();

  }

  funGetNote(int id) async {
    titleTC.clear();
    discTC.clear();
    final notepadDb = await  Hive.openBox<NotePadModel>('notepad_db');
    final notepadModel= notepadDb.get(id);
    if(notepadModel!=null){
      titleTC.text=notepadModel.title;
      discTC.text=notepadModel.description;
      created=notepadModel.createdAt;
      edited=notepadModel.updatedAt;
    }
    notifyListeners();


  }

  void clear() {
    titleTC.clear();
    discTC.clear();
    notifyListeners();

  }

  void changeSearch(bool bool) {
    isSearch=bool;
    if(!isSearch){
      filterList=notepadList;
    }
    notifyListeners();
  }

  void onFilter(String text) {
    filterList=notepadList.where((element) => element.title.toString().toLowerCase().contains(text.toLowerCase())||element.description.toString().toLowerCase().contains(text.toLowerCase())).toList();
    notifyListeners();
  }



}