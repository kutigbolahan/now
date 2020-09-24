import 'dart:convert';
import 'dart:isolate';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:nahere/controllers/api.dart';
import 'package:nahere/controllers/auth/auth.dart';
import 'package:nahere/models/fetch_groups_i_belong_to/fetch_Groups.dart';
import 'package:nahere/models/fetch_groups_i_belong_to/serializers.dart';
import 'package:nahere/models/social.dart';
import 'package:nahere/views/pages/checkimagescreen.dart';

import 'package:nahere/views/pages/posttoDifferentGroupfeeds.dart';
import 'package:nahere/widgets/apptheme.dart';
import 'package:nahere/widgets/drawer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'package:timeago/timeago.dart' as timeago;

class DifferentGroupPages extends StatefulWidget {
  @override
  _DifferentGroupPagesState createState() => _DifferentGroupPagesState();
}

class _DifferentGroupPagesState extends State<DifferentGroupPages> {
  double screenHeight, screenWidth;
  var userData;
  // Box<String> feedsBox;
  dynamic data;
  Box<String> feedsBox = Hive.box('feedsApp');

  String urlPrefix = 'https://empl-dev.site/';
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  ScrollController _scrollcontroller = ScrollController(
    initialScrollOffset: 100000050.0,
  );

  var _scaffoldKey;
  var listOfImages = [];
  ReceivePort _receivePort = ReceivePort();
  int progress = 0;

  static downloadingCallback(id, status, progress) {
    SendPort sendPort = IsolateNameServer.lookupPortByName("downloading");

    sendPort.send([id, status, progress]);
  }

  @override
  void initState() {
    super.initState();
    initHive();
    // differentGroupfeeds();
    if (this.mounted) {
      setState(() {
        differentGroupfeeds();
      });
    }
    // _getUserInfo();
    // if (!mounted) {
    //   differentGroupfeeds();
    //   differentGroupfeedsFuture = differentGroupfeeds();
    // }
    // differentGroupfeedsFuture
    // if (!mounted) {
    //   setState(() {
    //     differentGroupfeeds();
    //   });
    // }
    // _differentGroupfeedsFuture = differentGroupfeeds();
    //feedsBox = Hive.box('feedsApp');

    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (_scrollcontroller.hasClients) {
        _scrollcontroller.animateTo(
          _scrollcontroller.position.maxScrollExtent,
          duration: const Duration(milliseconds: 10),
          curve: Curves.bounceIn,
        );
      }
    });

    ///register a send port for the other isolates
    IsolateNameServer.registerPortWithName(
        _receivePort.sendPort, "downloading");

    ///Listening for the data is comming other isolataes
    _receivePort.listen((message) {
      setState(() {
        progress = message[2];
      });

      print(progress);
    });

    FlutterDownloader.registerCallback(downloadingCallback);
  }

  @override
  void dispose() {
    _scrollcontroller.dispose();
    super.dispose();
  }

  initHive() async {
    // ignore: await_only_futures
    await Hive.box('feedsApp');
    //Updated code
  }

  //  _getUserInfo() async {
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();
  //   var userJson = localStorage.getString('data');
  //   var user = json.decode(userJson);
  //   print(user);
  //   //user = userData;
  //   setState(() {
  //     userData = user;
  //   });
  // }
  dynamic res1;
  dynamic data2;
  bool isLoading = false;
  bool isError = false;
  Future<SocialFeeds2> differentGroupfeeds() async {
    print('${feedsBox.get('userID')}');
    print('${feedsBox.get('GROUPIDEACH')}');

    String url =
        //'https://empl-dev.site/api/social/fetch_updates?user=${userData['user_id']}&group_id=0&page=0&limit=25');
        'https://empl-dev.site/api/social/fetch_updates?user=${feedsBox.get('userID')}&group_id=${feedsBox.get('GROUPIDEACH')}&page=0&limit=25000000';
    // 'https://empl-dev.site/api/social/fetch_updates?user=117&group_id=0&page=0&limit=25';
    //'https://empl-dev.site/api/social/fetch_updates?user=117&group_id=14&page=0&limit=25';
    //'https://empl-dev.site/api/social/fetch_updates?user=117&group_id=${feedsBox.get('GROUPIDEACH')}&page=0&limit=25');
    // ${group_id[group_id]}
    // 'https://empl-dev.site/api/social/fetch_updates?user=${feedsBox.get('userID')}&group_id=${feedsBox.get('GROUPIDEACH')}&page=0&limit=250000000000');

    final response = await http.get(url);

    // 'https://empl-dev.site/api/social/fetch_updates?user=117&group_id=$feedsBox.get(groupId)&page=1&limit=25');
    try {
      if (response.statusCode == 200) {
        //  return SocialFeeds1.fromJson(json.decode(response.body));
        data = json.decode(response.body);
        data2 = json.decode(response.body)['data'];
        res1 = SocialFeeds2.fromJson(data);

        for (int index = 0; index < data2.length; index++) {
          if (data2[index]['socialFiles'] != null) {
            for (int i = 0; i < data2[index]['socialFiles'].length; i++) {
              listOfImages.add(data2[index]['socialFiles'][i]['val']);
            }
          }
        }
        setState(() {
          isLoading = true;
        });
        // final apiresonse = res;
        // feedsBox.put('apiResponseForIntialData', apiresonse.toString());
        return res1;
        //  return SocialFeeds1.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load feeds');
      }
    } catch (e) {
      setState(() {
        isError = true;
      });
      print(e);
      // return e.message;
      return _showToast(context, 'Please check your internet connection');
    }
  }

  Future<Fetch> fetchGroupsUsersBelongTo() async {
    try {
      var res = await Provider.of<CallApi>(context)
          .getData('social/fetch_groups_i_belong_to?user=117');
      // social/fetch_groups_i_belong_to?user=${userData['user_id']}
      //final response = serializers.deserialize(json.decode(res.body),specifiedType: new FullType(SocialFeeds));
      //print('${userData['user_id']}');
      Fetch fetch = standardSerializers.deserializeWith(
        Fetch.serializer,
        json.decode(res.body),
      );
      //print(fetch);
      return fetch;
    } catch (e) {
      print(e);
      return e.message;
    }
  }

  Widget tyy() {
    if (isError) {
      return Center(child: Text('No Feeds Available'));
    } else if (!isLoading) {
      return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SpinKitFadingCircle(
                color: Color(0xff01A0C7),
              ),
            ]),
      );
    }
    return Container(
        height: screenHeight / 1.25,
        child: buildListView(
          res1,
        ));
  }

  @override
  Widget build(BuildContext context) {
    // final feedsProvider =
    //     Provider.of<DifferentGroupsFeedstest>(context, listen: false);
    // final themeNotifier = Provider.of<ThemeNotifier>(context);
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return Scaffold(
      //tobe removed for darkmode
      //backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        //iconTheme: new IconThemeData(color: Color(0xff01A0C7)),
        elevation: 0.0,
        //tobe removed for darkmode
        //backgroundColor: Colors.white,
        title: Text(
          '${feedsBox.get('GROUPNAME')}',
          style: GoogleFonts.montserrat(
              color: Color(0xff01A0C7),
              fontSize: 17,
              fontWeight: FontWeight.w500),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
                _modalBottomSheetMenu();
              }),
        ],
      ),
      drawer: MyDrawer(),
      body: RefreshIndicator(
        color: Color(
            0xff01A0C7), // themeProvider.isLightTheme ? Color(0xff01A0C7):   Color(0xff01A0C7),
        key: refreshKey,
        onRefresh: differentGroupfeeds,
        child: Stack(overflow: Overflow.visible, children: [
          tyy(),

          // Container(
          //   height: screenHeight / 1.25,
          //   child: FutureBuilder<SocialFeeds1>(
          //       future: differentGroupfeeds(),
          //       // differentGroupsFeedstest
          //       //     .differentGroupfeeds1(), //differentGroupfeeds(),
          //       //differentGroupfeedsFuture, //differentGroupfeedsFuture, //differentGroupfeeds(),
          //       builder: (BuildContext context,
          //           AsyncSnapshot<SocialFeeds1> snapshot) {
          //         if (snapshot.connectionState == ConnectionState.waiting) {
          //           return Center(
          //             child: Column(
          //                 mainAxisAlignment: MainAxisAlignment.center,
          //                 crossAxisAlignment: CrossAxisAlignment.center,
          //                 children: <Widget>[
          //                   SpinKitFadingCircle(
          //                     color: Color(0xff01A0C7),
          //                   ),
          //                 ]),
          //           );
          //         } else if (snapshot.connectionState == ConnectionState.none) {
          //           return Center(
          //               child: Column(
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   children: <Widget>[
          //                 Image.asset(
          //                   'assets/images/interface.png',
          //                   width: 70,
          //                   height: 70,
          //                   fit: BoxFit.fill,
          //                 ),
          //                 SizedBox(
          //                   height: 10,
          //                 ),
          //                 Text(
          //                   'Connection Error !!!',
          //                   style: GoogleFonts.montserrat(
          //                       fontSize: 12, fontWeight: FontWeight.w500),
          //                   // style: TextStyle(color: Colors.red),
          //                 ),
          //                 SizedBox(
          //                   height: 10,
          //                 ),
          //                 RaisedButton(
          //                   textColor: Colors.white,
          //                   color: Color(0xff01A0C7),
          //                   shape: RoundedRectangleBorder(
          //                       borderRadius: BorderRadius.circular(7)),
          //                   onPressed: () {
          //                     Navigator.pushAndRemoveUntil(
          //                         context,
          //                         MaterialPageRoute(
          //                             builder: (context) =>
          //                                 DifferentGroupPages()),
          //                         (route) => false);
          //                   },
          //                   child: Text(
          //                     'Try Again',
          //                     style: GoogleFonts.montserrat(
          //                       fontSize: 10,
          //                       fontWeight: FontWeight.w500,
          //                     ),
          //                   ),
          //                 )
          //               ]));
          //         } else if (snapshot.hasError) {
          //           return Center(
          //               child: Column(
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   crossAxisAlignment: CrossAxisAlignment.center,
          //                   children: <Widget>[
          //                 AlertDialog(
          //                   title: Center(
          //                     child: Text(
          //                       'Error',
          //                       style: GoogleFonts.montserrat(
          //                           fontSize: 17,
          //                           fontWeight: FontWeight.w400,
          //                           color: Color(0xff01A0C7)),
          //                     ),
          //                   ),
          //                   content: Center(
          //                     child: Text(
          //                       'An error has occurred.\nKindly ensure you have a working internet connection.\n OR \nNo current feeds available.',
          //                       textAlign: TextAlign.center,
          //                       style: GoogleFonts.montserrat(
          //                           fontSize: 13,
          //                           fontWeight: FontWeight.w500,
          //                           color: Color(0xff01A0C7)),
          //                     ),
          //                   ),
          //                   actions: [
          //                     FlatButton(
          //                       onPressed: () {
          //                         Navigator.pushAndRemoveUntil(
          //                             context,
          //                             MaterialPageRoute(
          //                                 builder: (context) =>
          //                                     DifferentGroupPages()),
          //                             (route) => false);
          //                       },
          //                       child: Text(
          //                         'Try Again',
          //                         style: GoogleFonts.montserrat(
          //                             fontSize: 13,
          //                             fontWeight: FontWeight.w400,
          //                             color: Color(0xff01A0C7)),
          //                       ),
          //                     )
          //                   ],
          //                 ),
          //                 // Center(
          //                 // child: Text(
          //                 //   'You have no  group feeds currently !!!',
          //                 //   textAlign: TextAlign.center,
          //                 //   style: GoogleFonts.montserrat(
          //                 //       fontSize: 15, fontWeight: FontWeight.w300),
          //                 // ),#
          //                 // Text(
          //                 //   'You Currently have no feeds ',
          //                 //   style: GoogleFonts.montserrat(
          //                 //     fontSize: 12,
          //                 //     fontWeight: FontWeight.w500,
          //                 //   ),
          //                 // ),
          //                 // SizedBox(
          //                 //   height: 3,
          //                 // ),
          //                 // Image.asset(
          //                 //   'assets/images/interface.png',
          //                 //   width: 70,
          //                 //   height: 70,
          //                 //   fit: BoxFit.fill,
          //                 // ),
          //                 // SizedBox(
          //                 //   height: 10,
          //                 // ),
          //                 // Text(
          //                 //   'Oops,something went wrong',
          //                 //   style: GoogleFonts.montserrat(
          //                 //       fontSize: 12, fontWeight: FontWeight.w500),
          //                 //   // style: TextStyle(color: Colors.red),
          //                 // ),
          //                 // Text(
          //                 //   'Please check your internet connection !!!',
          //                 //   style: GoogleFonts.montserrat(
          //                 //       fontSize: 12, fontWeight: FontWeight.w500),
          //                 //   // style: TextStyle(color: Colors.red),
          //                 // ),
          //                 // SizedBox(
          //                 //   height: 10,
          //                 // ),
          //                 // RaisedButton(
          //                 //   textColor: Colors.white,
          //                 //   color: Color(0xff01A0C7),
          //                 //   shape: RoundedRectangleBorder(
          //                 //       borderRadius: BorderRadius.circular(7)),
          //                 //   onPressed: () {
          //                 //     Navigator.pushAndRemoveUntil(
          //                 //         context,
          //                 //         MaterialPageRoute(
          //                 //             builder: (context) =>
          //                 //                 DifferentGroupPages()),
          //                 //         (route) => false);
          //                 //   },
          //                 //   child: Text(
          //                 //     'Try Again',
          //                 //     style: GoogleFonts.montserrat(
          //                 //       fontSize: 10,
          //                 //       fontWeight: FontWeight.w500,
          //                 //     ),
          //                 //   ),
          //                 // )
          //                 //  )
          //               ]));
          //         } else if (snapshot.connectionState == ConnectionState.done) {
          //           return ListView.separated(
          //               separatorBuilder: (context, index) => Divider(
          //                     color: themeNotifier.lightTheme
          //                         ? Colors.black12
          //                         : Colors
          //                             .white24, // themeProvider.isLightTheme ? Colors.black12:   Colors.white24,//Colors.black12,
          //                   ),
          //               physics: BouncingScrollPhysics(),
          //               controller: _scrollcontroller,
          //               // shrinkWrap: true,
          //               itemCount: snapshot.data.data.length,
          //               itemBuilder: (context, index) {
          //                 return ListTile(
          //                   leading: Row(
          //                       crossAxisAlignment: CrossAxisAlignment.start,
          //                       mainAxisSize: MainAxisSize.min,
          //                       children: <Widget>[
          //                         Container(
          //                           child: urlPrefix +
          //                                       snapshot.data.data[index]
          //                                           .profile_pic !=
          //                                   null
          //                               ? CachedNetworkImage(
          //                                   imageUrl: urlPrefix +
          //                                       snapshot.data.data[index]
          //                                           .profile_pic,
          //                                   imageBuilder:
          //                                       (context, imageProvider) =>
          //                                           Container(
          //                                     width: 50.0,
          //                                     height: 50.0,
          //                                     decoration: BoxDecoration(
          //                                       shape: BoxShape.circle,
          //                                       image: DecorationImage(
          //                                           image: imageProvider,
          //                                           fit: BoxFit.cover),
          //                                     ),
          //                                   ),
          //                                   placeholder: (context, url) =>
          //                                       CircularProgressIndicator(
          //                                     strokeWidth: 1.5,
          //                                     backgroundColor:
          //                                         Color(0xff01A0C7),
          //                                   ),
          //                                   errorWidget:
          //                                       (context, url, error) =>
          //                                           CircleAvatar(
          //                                     radius: 25,
          //                                     backgroundColor: Colors.white,
          //                                     backgroundImage: AssetImage(
          //                                         'assets/images/no_image.png'),
          //                                   ),
          //                                 )
          //                               : Container(
          //                                   child: Center(
          //                                     child: SpinKitFadingCircle(
          //                                       color: Color(0xff01A0C7),
          //                                       size: 50,
          //                                     ),
          //                                   ),
          //                                 ),
          //                         ),
          //                       ]),
          //                   title: Row(
          //                     children: <Widget>[
          //                       Text(
          //                         snapshot.data.data[index].firstname,
          //                         style: GoogleFonts.montserrat(
          //                             fontSize: 13,
          //                             fontWeight: FontWeight.w500),
          //                       ),
          //                       SizedBox(
          //                         width: 5,
          //                       ),
          //                       Text(
          //                         snapshot.data.data[index].lastname,
          //                         style: GoogleFonts.montserrat(
          //                             fontSize: 13,
          //                             fontWeight: FontWeight.w500),
          //                       ),
          //                       SizedBox(
          //                         width: 5,
          //                       ),
          //                       Text(
          //                         timeago.format(DateTime.parse(
          //                             '${snapshot.data.data[index].update_time}')),
          //                         style: GoogleFonts.montserrat(
          //                             fontSize: 10,
          //                             fontWeight: FontWeight.w200),
          //                       )
          //                     ],
          //                   ),
          //                   subtitle: Column(
          //                       // mainAxisAlignment: MainAxisAlignment.start,
          //                       crossAxisAlignment: CrossAxisAlignment.start,
          //                       children: <Widget>[
          //                         Text(
          //                           '${snapshot.data.data[index].profession}',
          //                           // _parseHtmlString(snapshot.data.data[index].lastname),
          //                           style: GoogleFonts.montserrat(
          //                               fontSize: 14,
          //                               fontWeight: FontWeight.w300),
          //                         ),
          //                         SizedBox(
          //                           height: 5,
          //                         ),
          //                         Text(
          //                           snapshot.data.data[index].message,
          //                           // _parseHtmlString(snapshot.data.data[index].lastname),
          //                           style: GoogleFonts.montserrat(
          //                               fontSize: 14,
          //                               fontWeight: FontWeight.w300),
          //                         ),
          //                         data['data'][index]['socialFiles'] != null
          //                             ? GridView.count(
          //                                 physics:
          //                                     NeverScrollableScrollPhysics(),
          //                                 shrinkWrap: true,
          //                                 crossAxisCount: 2,
          //                                 crossAxisSpacing: 10,
          //                                 mainAxisSpacing: 10,
          //                                 children: getSubtitleChildren(
          //                                     data, index, urlPrefix))
          //                             : Container()
          //                       ]),
          //                 );
          //               });
          //         }
          //         return Container();
          //       }),
          // ),
          DifferentGroupPagesPost(),
        ]),
      ),
      // floatingActionButton: OpenContainer(
      //   //openColor: Color(0xff01A0C7),
      //   openColor: Color(0xff01A0C7),
      //   closedColor: Color(0xff01A0C7),
      //   transitionType: ContainerTransitionType.fadeThrough,
      //   openBuilder: (BuildContext context, VoidCallback _) {
      //     return DifferentGroupPagesPost();
      //   },
      //   closedElevation: 60.0,
      //   closedShape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(
      //       50,
      //     ),
      //   ),
      //   // closedColor: Color(0xff01A0C7),
      //   closedBuilder: (BuildContext context, VoidCallback openContainer) {
      //     return SizedBox(
      //       height: 50,
      //       width: 50,
      //       child: Center(
      //         child: Icon(
      //           Icons.message,
      //           color: Colors.white,
      //         ),
      //       ),
      //     );
      //   },
      // ),
    );
  }

  ListView buildListView(
    res1,
  ) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      separatorBuilder: (context, index) => Divider(
        color: Provider.of<ThemeNotifier>(context).lightTheme
            ? Colors.black12
            : Colors.white24,
      ),
      controller: _scrollcontroller,
      itemCount: data2.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  child: urlPrefix + data2[index]['profile_pic'] != null
                      ? CachedNetworkImage(
                          imageUrl: urlPrefix + data2[index]['profile_pic'],
                          imageBuilder: (context, imageProvider) => Container(
                            width: 50.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                          placeholder: (context, url) =>
                              //  CircleAvatar(
                              //   radius: 25,
                              //   backgroundColor: Colors.white,
                              //   backgroundImage: AssetImage(
                              //       'assets/images/no_image.png'),
                              // ),
                              CircularProgressIndicator(
                            strokeWidth: 1.5,
                            backgroundColor: Color(0xff01A0C7),
                          ),
                          errorWidget: (context, url, error) => CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.white,
                            backgroundImage:
                                AssetImage('assets/images/no_image.png'),
                          ),
                        )
                      : Container(
                          child: Center(
                            child: SpinKitFadingCircle(
                              color: Color(0xff01A0C7),
                              size: 50,
                            ),
                          ),
                        ),
                ),
              ]),
          title: Row(
            children: <Widget>[
              Text(
                data2[index]['firstname'],
                style: GoogleFonts.montserrat(
                    fontSize: 13, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                data2[index]['lastname'],
                style: GoogleFonts.montserrat(
                    fontSize: 13, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                timeago.format(DateTime.parse(data2[index]['update_time'])),
                // data2[index]['updateTime'].toString(),
                //  timeago.format(DateTime.parse(data2[index]['updateTime'])),
                style: GoogleFonts.montserrat(
                    fontSize: 10, fontWeight: FontWeight.w200),
              )
            ],
          ),
          subtitle: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                data2[index]['profession'] != null
                    ? data2[index]['profession']
                    : '',
                // _parseHtmlString(snapshot.data.data[index].lastname),
                style: GoogleFonts.montserrat(
                    fontSize: 14, fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                data2[index]['message'],
                //_parseHtmlString(snapshot.data.data[index].lastname),
                style: GoogleFonts.montserrat(
                    fontSize: 14, fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: 7,
              ),
              data['data'][index]['socialFiles'] != null
                  ? GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: getSubtitleChildren(data, index, urlPrefix))
                  : Container()
            ],
          ),
        );
      },
    );
  }

  Widget _modalBottomSheetMenu() {
    showModalBottomSheet(
      isDismissible: true,
      context: context,
      //backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
      ),
      builder: (context) {
        //  Navigator.pop(context);
        return FutureBuilder<Fetch>(
          future: fetchGroupsUsersBelongTo(),
          builder: (BuildContext context, AsyncSnapshot<Fetch> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SpinKitFadingCircle(
                        color: Color(0xff01A0C7),
                      ),
                    ]),
              );
            } else if (snapshot.connectionState == ConnectionState.none) {
              return Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Sorry You are not connected to any group yet',
                        style: GoogleFonts.montserrat(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      )
                    ]),
              );
            } else if (snapshot.hasError) {
              // return Center(
              //     child: Column(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         crossAxisAlignment: CrossAxisAlignment.center,
              //         children: <Widget>[
              //       Text('Sorry You are not connected to any group yet')
              //     ]));

              return Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                    // Center(
                    // child: Text(
                    //   'You have no  group feeds currently !!!',
                    //   textAlign: TextAlign.center,
                    //   style: GoogleFonts.montserrat(
                    //       fontSize: 15, fontWeight: FontWeight.w300),
                    // ),#

                    // Image.asset(
                    //   'assets/images/interface.png',
                    //   width: 70,
                    //   height: 70,
                    //   fit: BoxFit.fill,
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    Text(
                      'Oops,something went wrong',
                      style: GoogleFonts.montserrat(
                          fontSize: 12, fontWeight: FontWeight.w500),
                      // style: TextStyle(color: Colors.red),
                    ),
                    Text(
                      'Please check your internet connection !!! \nOr join a group',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                          fontSize: 12, fontWeight: FontWeight.w500),
                      // style: TextStyle(color: Colors.red),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                      textColor: Colors.white,
                      color: Color(0xff01A0C7),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DifferentGroupPages()),
                            (route) => false);
                      },
                      child: Text(
                        'Try Again',
                        style: GoogleFonts.montserrat(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                    //  )
                  ]));
            } else if (snapshot.connectionState == ConnectionState.done) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.builder(
                  itemCount: snapshot.data.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          onTap: () {
                            final groupId = snapshot.data.data[index].groupId;
                            final groupName =
                                snapshot.data.data[index].groupName;
                            feedsBox.put('GROUPNAME', groupName);
                            feedsBox.put('GROUPIDEACH', groupId);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DifferentGroupPages()),
                            );
                          },
                          title: Stack(children: [
                            Text(
                              snapshot.data.data[index].groupName,
                              style: GoogleFonts.montserrat(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                                // color: Colors.white
                                // color: Color(0xff01A0C7)
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xff01A0C7)),
                                child: Center(
                                  child: Text(
                                    '10',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                          ]),

                          //  Text(
                          //     snapshot.data.data[index].groupName,
                          //     style: GoogleFonts.montserrat(
                          //         fontSize: 15,
                          //         fontWeight: FontWeight.w300,
                          //         color: Color(0xff01A0C7)),
                          //   ),
                        ),
                      ],
                    );
                  },
                ),
              );
            }

            return Container();
          },
        );
      },
    );
    return Container();
  }

  List<Widget> getSubtitleChildren(
      dynamic jsonBody, int index, String urlPrefix) {
    List<Widget> _mWidgets = [];

    for (int i = 0; i < jsonBody['data'][index]['socialFiles'].length; i++) {
      if (jsonBody['data'][index]['socialFiles'][i]
          .toString() //xlsx
          .contains('.pdf')) {
        Widget pdfImage = GestureDetector(
            onTap: () {},
            child: Stack(children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset('assets/images/pdf2.jpg')),
              Center(
                  child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: IconButton(
                    icon: Icon(
                      Icons.arrow_downward,
                      color: Colors.red,
                    ),
                    onPressed: () async {
                      final status = await Permission.storage.request();
                      if (status.isGranted) {
                        final externalDir = await getExternalStorageDirectory();
                        final id = await FlutterDownloader.enqueue(
                          url: urlPrefix +
                              jsonBody['data'][index]['socialFiles'][i]['val'],
                          savedDir: externalDir.path,
                          fileName: "pdf file download ",
                          showNotification: true,
                          openFileFromNotification: true,
                        );
                      } else {
                        _showToast(context, 'Permission denied');
                      }
                    }),
              )),
            ]));
        _mWidgets.add(pdfImage);
      } else if (jsonBody['data'][index]['socialFiles'][i]
              .toString() //xlsx
              .contains('.xls') ||
          jsonBody['data'][index]['socialFiles'][i]
              .toString() //xlsx
              .contains('.xlsx')) {
        Widget pdfImage = GestureDetector(
            onTap: () {},
            child: Stack(children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset('assets/images/excel.png')),
              Center(
                  child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: IconButton(
                    icon: Icon(
                      Icons.arrow_downward,
                      color: Colors.red,
                    ),
                    onPressed: () async {
                      final status = await Permission.storage.request();
                      if (status.isGranted) {
                        final externalDir = await getExternalStorageDirectory();
                        final id = await FlutterDownloader.enqueue(
                          url: urlPrefix +
                              jsonBody['data'][index]['socialFiles'][i]['val'],
                          savedDir: externalDir.path,
                          fileName: "excel file download",
                          showNotification: true,
                          openFileFromNotification: true,
                        );
                      } else {
                        _showToast(context, 'Permission denied');
                        print('Permission denied');
                      }
                    }),
              )),
            ]));
        _mWidgets.add(pdfImage);
      } else if (jsonBody['data'][index]['socialFiles'][i]
          .toString()
          .contains('.doc')) {
        Widget pdfImage = GestureDetector(
            onTap: () {},
            child: Stack(children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset('assets/images/doc.jpg')),
              Center(
                  child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: IconButton(
                    icon: Icon(
                      Icons.arrow_downward,
                      color: Colors.red,
                    ),
                    onPressed: () async {
                      final status = await Permission.storage.request();
                      if (status.isGranted) {
                        final externalDir = await getExternalStorageDirectory();
                        final id = await FlutterDownloader.enqueue(
                          url: urlPrefix +
                              jsonBody['data'][index]['socialFiles'][i]['val'],
                          savedDir: externalDir.path,
                          fileName: "excel file download",
                          showNotification: true,
                          openFileFromNotification: true,
                        );
                      } else {
                        _showToast(context, 'download failed');
                        print('Permission denied');
                      }
                    }),
              )),
            ]));
        _mWidgets.add(pdfImage);
      } else if (jsonBody['data'][index]['socialFiles'][i]
          .toString()
          .contains('.png')) {
        _mWidgets.add(GestureDetector(
          onTap: () async {
            final image7 =
                urlPrefix + jsonBody['data'][index]['socialFiles'][i]['val'];
            feedsBox.put('Image7', image7);

            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return CheckImageScreen();
            }));
          },
          child: CachedNetworkImage(
              fadeInCurve: Curves.bounceIn,
              imageUrl:
                  urlPrefix + jsonBody['data'][index]['socialFiles'][i]['val'],
              imageBuilder: (context, imageProvider) => ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      decoration: BoxDecoration(
                        //shape: BoxShape.rectangle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                  ),
              placeholder: (context, url) => Center(
                    child: Container(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(
                        strokeWidth: 1.5,
                        backgroundColor: Color(0xff01A0C7),
                      ),
                    ),
                  ),
              errorWidget: (context, url, error) => Container()),
        ));
      }
    }
    return _mWidgets;
  }

  _showToast(BuildContext context, msg) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Color(0xff01A0C7),
      shape: RoundedRectangleBorder(),
      content: Text(
        msg,
        style: GoogleFonts.montserrat(fontSize: 12, color: Colors.white),
      ),
      duration: Duration(seconds: 5),
    );

    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
