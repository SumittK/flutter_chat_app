import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String userName;
  final Alignment alignment;
  final Timestamp timestamp;

  const MessageBubble({
    super.key,
    required this.message,
    required this.userName,
    required this.alignment,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Align(
        alignment: alignment,
        child: IntrinsicWidth(
          child: Container(
            margin: EdgeInsets.only(
                left: alignment == Alignment.centerRight ? 50.0 : 0.0,
                right: alignment == Alignment.centerLeft ? 50.0 : 0.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: alignment == Alignment.centerRight
                  ? Colors.blue
                  : Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: alignment == Alignment.centerRight
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  message,
                  style: GoogleFonts.poppins(
                    fontSize: 16.0,
                    color: alignment == Alignment.centerRight
                        ? Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 5.0),
                Text(
                  DateFormat('MMM d h:mm a').format(timestamp.toDate()),
                  style: GoogleFonts.poppins(
                    fontSize: 10.0,
                    color: alignment == Alignment.centerRight
                        ? Colors.white
                            .withOpacity(0.5)
                        : Colors.black.withOpacity(0.5),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}