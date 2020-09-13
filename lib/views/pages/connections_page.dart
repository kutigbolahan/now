// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:google_fonts/google_fonts.dart';

// import 'package:nahere/models/connectionsmodel/connections.dart';

// import 'package:nahere/models/connectionsmodel/serializers.dart';

// import 'package:nahere/widgets/drawer.dart';

// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:nahere/controllers/api.dart';

// import 'package:provider/provider.dart';

// class ConnectionsPage extends StatefulWidget {
//   @override
//   _ConnectionsPageState createState() => _ConnectionsPageState();
// }

// class _ConnectionsPageState extends State<ConnectionsPage> {
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   var userData;

//   void getUserInfo() async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();
//     var userJson = localStorage.getString('data');
//     var user = json.decode(userJson);
//     setState(() {
//       userData = user;
//     });
//   }

//   Future<Connections> getConnections() async {
//     //final url = 'https://empl-dev.site/api/user/my_connections?user_id=117';
//     // 'https://empl-dev.site/api/user/my_connections?user_id=${userData['user_id']}';
//     var response = await Provider.of<CallApi>(context, listen: false)
//         .getData('my_connections?user_id=117');
//     try {
//       // var res = await http.get(url);
//       // final rep = jsonDecode(res.body);
//       Connections connections = standardSerializers.deserializeWith(
//           Connections.serializer, jsonDecode(response.body));
      
//       return connections;
//     } catch (e) {
//       print(e);
//       return e.message;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       key: _scaffoldKey,
//       appBar: AppBar(
//         iconTheme: new IconThemeData(color: Color(0xff01A0C7)),
//         elevation: 0.0,
//         backgroundColor: Colors.white,
//         centerTitle: true,
//         title: Text(
//           'My Connections',
//           style: GoogleFonts.montserrat(
//               color: Color(0xff01A0C7),
//               fontSize: 17,
//               fontWeight: FontWeight.w500),
//         ),
//       ),
//       drawer: MyDrawer(),
//       body: SafeArea(
//           child: Padding(
//         padding: const EdgeInsets.all(18.0),
//         child: FutureBuilder<Connections>(
//             future: getConnections(),
//             builder:
//                 (BuildContext context, AsyncSnapshot<Connections> snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: <Widget>[
//                         SpinKitFadingCircle(
//                           color: Color(0xff01A0C7),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               } else if (snapshot.connectionState == ConnectionState.none) {
//                 return Center(
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                       Image.asset(
//                         'assets/images/interface.png',
//                         width: 70,
//                         height: 70,
//                         fit: BoxFit.fill,
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Text(
//                         'Connection Error !!!',
//                         style: GoogleFonts.montserrat(
//                             fontSize: 12, fontWeight: FontWeight.w500),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       RaisedButton(
//                         textColor: Colors.white,
//                         color: Color(0xff01A0C7),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(7)),
//                         onPressed: () {
//                           Navigator.pushAndRemoveUntil(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => ConnectionsPage()),
//                               (route) => false);
//                         },
//                         child: Text(
//                           'Try Again',
//                           style: GoogleFonts.montserrat(
//                             fontSize: 10,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       )
//                     ]));
//               } else if (snapshot.hasError) {
//                 return Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Text(
//                         'You Dont Have Any Connections Yet.',
//                         style: GoogleFonts.montserrat(
//                             fontSize: 12, fontWeight: FontWeight.w500),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                     ],
//                   ),
//                 );
//               } else if (snapshot.connectionState == ConnectionState.done) {
//                 return ListView.builder(
//                   itemCount: snapshot.data.data.length,
//                   itemBuilder: (context, index) {
//                     return Theme(
//                       data: ThemeData(accentColor: Colors.black),
//                       child: Card(
//                         elevation: 2,
//                                               child: ExpansionTile(
//                           title: Text(
//                             snapshot.data.data[index].companyName,
//                             style: GoogleFonts.montserrat(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w400,
//                               color: Color(0xff01A0C7),
//                             ),
//                           ),
//                           children: <Widget>[
//                             Padding(
//                               padding:
//                                   const EdgeInsets.only(right: 90.0, left: 20),
//                               child: Align(
//                                 alignment: Alignment.centerLeft,
//                                                             child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: <Widget>[
//                                     Text(
//                                       '-' +
//                                           snapshot.data.data[index].moduleDetails[0]
//                                               .moduleFullName,
//                                       style: GoogleFonts.montserrat(
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.w300,
//                                           color: Colors.black),
//                                     ),
//                                     SizedBox(height: 4),
//                                     Text(
//                                       '-' +
//                                           snapshot.data.data[index].moduleDetails[0]
//                                               .moduleLandingPage,
//                                       style: GoogleFonts.montserrat(
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.w300,
//                                           color: Colors.black),
//                                     ),
//                                     SizedBox(height: 6),
//                                   ],
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               }
//               return CircularProgressIndicator();
//             }),
//       )),
//     );
//   }
// }
