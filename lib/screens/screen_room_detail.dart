import 'package:flutter/material.dart';
import 'package:mayank_sureliya/screens/screen_select_room.dart';

class ScreenRoomDetail extends StatefulWidget {
  final List<Room> rooms;
  const ScreenRoomDetail({super.key, required this.rooms});

  @override
  State<ScreenRoomDetail> createState() => _ScreenRoomDetailState();
}

class _ScreenRoomDetailState extends State<ScreenRoomDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Room Detail"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...widget.rooms.map((e) {
              return _roomItemDetail(
                  roomName: e.roomName, roomItems: e.roomItems);
            }),
          ],
        ),
      ),
    );
  }

  _roomItemDetail({String? roomName, required List<RoomItem> roomItems}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(5),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
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
              "Room : $roomName",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 8),

            // Adult,Age and Button
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                    "Adult : ${roomItems.where((ele) => ele.name == "Adult").length}"),
                Text(
                    "Child : ${roomItems.where((ele) => ele.name == "Child").length}"),
              ],
            ),
            const SizedBox(height: 10),
            // Room Items List
            Column(
              children: [
                ...roomItems.map(
                  (itemName) => Container(
                    width: MediaQuery.of(context).size.width,
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
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
                        Text("${roomItems.indexOf(itemName) + 1}"),
                        Text("Name : ${itemName.name}"),
                        Text("Age : ${itemName.age}"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
