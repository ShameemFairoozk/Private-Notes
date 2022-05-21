import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notepad/constants/text_style.dart';
import 'package:notepad/providers/notepad_provider.dart';
import 'package:notepad/screens/add_notepad_screeen.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';

class ListNotePadScreen extends StatelessWidget {
  const ListNotePadScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NotePadProvider _notePadProvider =
        Provider.of<NotePadProvider>(context, listen: false);

    return Scaffold(
        backgroundColor: ColorSelect.white,
        floatingActionButton: FloatingActionButton(
          backgroundColor: ColorSelect.orange,
          child: const Icon(Icons.add),
          onPressed: () {
            _notePadProvider.clear();
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NotePadScreen(
                        from: 'New',
                      )),
            );
          },
        ),
        appBar: PreferredSize(
            child: Container(
                color: ColorSelect.white,
                height: 80.0,
                width: double.infinity,
                alignment: Alignment.bottomCenter,
                child:
                    Consumer<NotePadProvider>(builder: (context, value, child) {
                  return value.isSearch == false
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 30,
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.home)),
                            ),
                            Text(
                              'Home',
                              style: lora,
                            ),
                            SizedBox(
                              height: 30,
                              child: IconButton(
                                  onPressed: () {
                                    _notePadProvider.changeSearch(true);
                                  },
                                  icon: const Icon(Icons.search)),
                            ),
                          ],
                        )
                      : TextField(
                          onChanged: (text) {
                            _notePadProvider.onFilter(text);
                          },
                          decoration: InputDecoration(
                              fillColor: ColorSelect.gray,
                              filled: true,
                              prefixIcon: const Icon(Icons.search),
                              suffixIcon: IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    _notePadProvider.changeSearch(false);
                                  }),
                              hintText: 'Search something ...',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none),
                              contentPadding: EdgeInsets.zero));
                })),
            preferredSize: const Size.fromHeight(80.0)),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Consumer<NotePadProvider>(builder: (context, value, child) {
              return StaggeredGrid.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  children: List.generate(value.filterList.length, (index) {
                    var notePadModel = value.filterList[index];
                    return StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: index % 2 == 0 ? 3 : 2,
                        child: Container(
                          decoration: BoxDecoration(
                              color: ColorSelect.gray,
                              borderRadius: BorderRadius.circular(15)),
                          child: InkWell(
                            onTap: () {
                              _notePadProvider.funGetNote(notePadModel.key!);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NotePadScreen(
                                          from: 'Edit',
                                          notePadModel: notePadModel,
                                        )),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          notePadModel.title,
                                          style:lora18,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(
                                          height: 30,
                                          child: IconButton(
                                            onPressed: () {
                                              _notePadProvider.funDeleteNote(
                                                  notePadModel.key);
                                            },
                                            icon: const Icon(Icons.delete),
                                            padding: EdgeInsets.zero,
                                          ))
                                    ],
                                  ),
                                  Flexible(
                                    child: Text(
                                      notePadModel.description,
                                      style: lora12,
                                      maxLines: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ));
                  }));
            }),
          ),
        ));
  }
}
