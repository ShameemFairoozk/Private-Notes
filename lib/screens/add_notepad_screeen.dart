import 'package:flutter/material.dart';
import 'package:notepad/constants/colors.dart';
import 'package:notepad/constants/text_style.dart';
import 'package:notepad/models/notepad_model.dart';
import 'package:provider/provider.dart';

import '../providers/notepad_provider.dart';

class NotePadScreen extends StatelessWidget {
  String from;
  NotePadModel? notePadModel;

  NotePadScreen({Key? key, required this.from, this.notePadModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    NotePadProvider notePadProvider =
        Provider.of<NotePadProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: ColorSelect.white,
      appBar: PreferredSize(
          child: Container(
              color:  ColorSelect.white,
              height: 80.0,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.menu)),
                  from != 'New'
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Consumer<NotePadProvider>(
                                builder: (context, value, child) {
                              return Text(
                                'Created ${value.formatter.format(value.created)}',
                                style: lora12,
                              );
                            }),
                            Consumer<NotePadProvider>(
                                builder: (context, value, child) {
                              return Text(
                                "Edited ${value.formatter.format(value.edited)}",
                                style: lora12,
                              );
                            }),
                          ],
                        )
                      : const SizedBox(),
                  TextButton(
                      onPressed: () {
                        if (notePadProvider.titleTC.text.isNotEmpty ||
                            notePadProvider.discTC.text.isNotEmpty) {
                          if (from != 'Edit') {
                            notePadProvider.funSaveNote();
                          } else {
                            notePadProvider.funEditNote(
                                notePadModel!.createdAt, notePadModel!.key!);
                          }
                          Navigator.pop(context);
                        }
                      },
                      child:  Text(
                        'Save',
                        style: loraBlack,
                      )),
                ],
              )),
          preferredSize: const Size.fromHeight(80.0)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<NotePadProvider>(builder: (context, value, child) {
              return TextField(
                controller: value.titleTC,
                maxLines: null,
                style: lora18,
                decoration: InputDecoration(
                  fillColor: ColorSelect.gray,
                  filled: true,
                  hintText: 'title',
                  border: InputBorder.none,
                ),
              );
            }),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: ColorSelect.gray,
                child:
                    Consumer<NotePadProvider>(builder: (context, value, child) {
                  return TextField(
                    controller: value.discTC,
                    maxLines: null,
                    style: lora14,
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'Description',
                      fillColor: ColorSelect.gray,
                      border: InputBorder.none,
                    ),
                  );
                }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
