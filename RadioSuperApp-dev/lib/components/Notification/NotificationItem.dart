import 'package:flutter/material.dart';

class NotificationItem extends StatefulWidget {
  // final String senderImage;
  final String header;
  final String description;
  // final String timeAgo;

  const NotificationItem({
    // required this.senderImage,
    required this.header,
    required this.description,
    // required this.timeAgo,
    Key? key,
  }) : super(key: key);

  @override
  _NotificationItemState createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  bool isRead = false;
  bool isDeleted = false;

  @override
  Widget build(BuildContext context) {
    if (isDeleted) return const SizedBox.shrink();

    return Dismissible(
      key: Key(widget.description),
      background: Container(
        color: Colors.transparent,
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  isRead = true;
                });
              },
              child: const Text("Mark as Read", style: TextStyle(color: Colors.white)),
            ),
            // TextButton(
            //   onPressed: () {
            //     setState(() {
            //       isDeleted = true;
            //     });
            //   },
            //   child: const Text("Delete", style: TextStyle(color: Colors.white)),
            // ),
          ],
        ),
      ),
      direction: DismissDirection.endToStart,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: isRead ? Colors.black.withOpacity(0.7) : Colors.white.withOpacity(0.4),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            Row(
              children: [
                // CircleAvatar(
                //   backgroundImage: NetworkImage(widget.senderImage),
                //   radius: 20,
                // ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.header,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.description,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Positioned(
            //   top: 0,
            //   right: 0,
            //   child: Text(
            //     widget.timeAgo,
            //     style: TextStyle(color: Colors.white, fontSize: 12),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
