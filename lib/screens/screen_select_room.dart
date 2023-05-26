import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mayank_sureliya/screens/screen_room_detail.dart';

class Room {
  final int id;
  final String roomName;
  final List<RoomItem> roomItems;
  Room({
    required this.id,
    required this.roomName,
    required this.roomItems,
  });
}

class RoomItem {
  String name = '';
  int age = 0;

  RoomItem({
    required this.name,
    required this.age,
  });
}

class ScreenSelectRoom extends StatefulWidget {
  const ScreenSelectRoom({super.key});

  @override
  State<ScreenSelectRoom> createState() => _ScreenSelectRoomState();
}

class _ScreenSelectRoomState extends State<ScreenSelectRoom> {
  int? selectedRoom;
  bool onChangeDropdown = false;
  List<Room> rooms = [];

  void onSelectRoom() {
    setState(() {
      rooms.clear();
      for (int i = 0; i < (selectedRoom ?? 1); i++) {
        rooms.add(
          Room(
            id: Random().nextInt(99999),
            roomName: "Room ${i + 1}",
            roomItems: [],
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(5),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                value: selectedRoom,
                hint: const Text("Select Room"),
                onChanged: (value) {
                  setState(() {
                    selectedRoom = value ?? 1;
                    onChangeDropdown = true;
                  });
                },
                items: List<DropdownMenuItem<int>>.generate(
                  5,
                  (int index) {
                    return DropdownMenuItem<int>(
                      value: index + 1,
                      child: Text('${index + 1}'),
                    );
                  },
                ),
              )),
            ),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...rooms.map((value) {
                      return _roomItem(
                        roomItems: value.roomItems,
                        title: value.roomName,
                        roomId: value.id,
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                if (onChangeDropdown == true) {
                  onSelectRoom();
                  setState(() {
                    onChangeDropdown = false;
                  });
                } else {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (_) => ScreenRoomDetail(rooms: rooms),
                    ),
                  );
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.circular(3),
                ),
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: const Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container _roomItem({String? title, List<RoomItem>? roomItems, int? roomId}) {
    var adultCtrl = TextEditingController();
    var childCtrl = TextEditingController();
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.16),
            blurRadius: 4,
            offset: Offset(0, 1),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? "",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 8),

          // Adult,Age and Button
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: SizedBox(
                  height: 35,
                  child: TextField(
                    controller: adultCtrl,
                    maxLines: 1,
                    decoration: InputDecoration(
                      filled: true,
                      hintText: "Enter Adult",
                      contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(5)),
                      fillColor: Colors.grey.shade300,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SizedBox(
                  height: 35,
                  child: TextField(
                    controller: childCtrl,
                    maxLines: 1,
                    decoration: InputDecoration(
                      filled: true,
                      hintText: "Enter Child",
                      contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(5)),
                      fillColor: Colors.grey.shade300,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Add Button
              InkWell(
                onTap: () {
                  setState(() {
                    rooms
                        .singleWhere((element) => element.id == roomId)
                        .roomItems
                        .addAll(
                          List.generate(
                            int.tryParse(adultCtrl.text) ?? 0,
                            (index) => RoomItem(age: 1, name: "Adult"),
                          ),
                        );
                    rooms
                        .singleWhere((element) => element.id == roomId)
                        .roomItems
                        .addAll(
                          List.generate(
                            int.tryParse(childCtrl.text) ?? 0,
                            (index) => RoomItem(age: 1, name: "Child"),
                          ),
                        );
                  });
                },
                child: Container(
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: const Text(
                    "Add",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          (roomItems ?? []).isEmpty
              ? const SizedBox()
              : const SizedBox(height: 15),

          // Room Items List
          Column(
            children: [
              ...(roomItems ?? []).map((e) {
                return roomAddItem(context, e.name);
              }).toList(),
            ],
          ),
        ],
      ),
    );
  }

  Widget roomAddItem(BuildContext context, String title) {
    var nameCtrl = TextEditingController();
    var ageCtrl = TextEditingController();
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(60, 64, 67, 0.3),
            blurRadius: 2,
            spreadRadius: 0,
            offset: Offset(0, 1),
          ),
          BoxShadow(
            color: Color.fromRGBO(60, 64, 67, 0.15),
            blurRadius: 3,
            spreadRadius: 1,
            offset: Offset(0, 1),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: SizedBox(
                  height: 35,
                  child: TextField(
                    controller: nameCtrl,
                    maxLines: 1,
                    decoration: InputDecoration(
                      filled: true,
                      hintText: "Enter Name",
                      contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(5)),
                      fillColor: Colors.grey.shade300,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SizedBox(
                  height: 35,
                  child: TextField(
                    controller: ageCtrl,
                    maxLines: 1,
                    decoration: InputDecoration(
                      filled: true,
                      hintText: "Enter Age",
                      contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(5)),
                      fillColor: Colors.grey.shade300,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
