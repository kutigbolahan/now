import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:nahere/views/socketsThings/model/message.dart';
import 'package:nahere/views/socketsThings/providers.dart/messageProvider.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class MessagesItem extends StatelessWidget {
  final Message _message;

  final bool isUserMassage;

  const MessagesItem(this._message, this.isUserMassage);

  @override
  Widget build(BuildContext context) {
    //final mess = Provider.of<MessagesProvider>(context).socialMessages;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        // leading: Image.asset(
        //   'assets/images/no_image.png',
        //   width: 30,
        //   height: 50,
        // ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              _message.first_name == null ? "" : _message.first_name,
              style: GoogleFonts.montserrat(
                  fontSize: 13, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              _message.last_name == null ? "" : _message.last_name,
              style: GoogleFonts.montserrat(
                  fontSize: 13, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              width: 3,
            ),
            // Text(
            //   timeago.format(_message.time) == null
            //       ? ""
            //       : timeago.format(_message.time),
            //   style: GoogleFonts.montserrat(
            //       fontSize: 10, fontWeight: FontWeight.w200),
            // )
          ],
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _message.profession_n == null ? "" : _message.profession_n,
              style: GoogleFonts.montserrat(
                  fontSize: 14, fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 4,
            ),
            Text(_message.message == null ? "" : _message.message),
            // Divider()
          ],
        ),
      ),
    );
  }
}
