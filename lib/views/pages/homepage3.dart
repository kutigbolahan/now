import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:nahere/controllers/api.dart';
import 'package:timeago/timeago.dart' as timeago;
//import 'package:nahere/models/social.dart';
import 'package:nahere/views/pages/checkimagescreen.dart';
import 'package:nahere/views/pages/postNewFeedsPage.dart';
import 'package:nahere/views/socketsThings/data/socketsManager.dart';
import 'package:nahere/views/socketsThings/model/message.dart';
import 'package:nahere/views/socketsThings/providers.dart/messageProvider.dart';
import 'package:nahere/views/socketsThings/socketmessages/message_items.dart';
import 'package:nahere/widgets/apptheme.dart';
import 'package:nahere/widgets/drawer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:nahere/models/mo.dart';
import 'package:nahere/models/mo.dart' as data5;

class HomePage3 extends StatefulWidget {
  final Function(String) onSendMessage;

  final Function onTyping;

  final Function onStopTyping;

  const HomePage3({
    this.onSendMessage,
    this.onTyping,
    this.onStopTyping,
  });

  @override
  _HomePage3State createState() => _HomePage3State();
}

class _HomePage3State extends State<HomePage3> {
  TextEditingController _textEditingController;
  Timer _typingTimer;

  bool _isTyping = false;
  bool isError1 = false;
  Box<String> feedsBox = Hive.box('feedsApp');
  Future initHive() async {
    // ignore: await_only_futures
    await Hive.box<String>('feedsApp');
  }

  ScrollController _scrollcontroller = ScrollController(
    initialScrollOffset: 100000050.0,
  );

  void _joinChat() {
    if (_textEditingController.text.isEmpty) return;
  }

  ScrollController _scrollController;

  SocketIoManager _socketIoManager;
  // ignore: non_constant_identifier_names
  final String SERVER_URL = 'https://api.empl-dev.site';

  // ignore: unused_field
  String _userNameTyping;

  // ignore: unused_element
  void _sendMessagebutton() {
    if (_textEditingController.text.isEmpty) return;

    widget.onSendMessage(_textEditingController.text);
    setState(() {
      _textEditingController.text = "";
      isError = true;
    });
  }

  // ignore: unused_element
  // void _runTimer() {
  //   if (_typingTimer != null && _typingTimer.isActive) _typingTimer.cancel();
  //   _typingTimer = Timer(Duration(milliseconds: 600), () {
  //     if (!_isTyping) return;
  //     _isTyping = false;
  //     widget.onStopTyping();
  //   });
  //   _isTyping = true;
  //   widget.onTyping();
  // }

  // ignore: unused_element
  void _onTyping() {
    _socketIoManager.sendMessage(
        'typing', json.encode({'senderName': '${feedsBox.get('firstname')}'}));
  }

  // ignore: unused_element
  void _onStopTyping() {
    _socketIoManager.sendMessage('stop_typing',
        json.encode({'senderName': '${feedsBox.get('firstname')}'}));
  }

  // ignore: unused_element
  _sendMessage() {
    // String jsonData = Messa
    //  '{"message":{"type":"Text","content": ${(_textEditingController.text != null && _textEditingController.text.isNotEmpty) ? '"${_textEditingController.text}"' : '"Hello SOCKET IO PLUGIN :))"'},"group":"0","avatar":"img/avatar-default.png"},"sender":{"userId":"589f10b9bbcd694aa570988d","first":"Ha","last":"Test 2","location":{"lat":10.792273999999999,"long":106.6430356,"accuracy":38,"regionId":null,"vendor":"gps","verticalAccuracy":null},"name":"Ha Test 2"},"receivers":["587e1147744c6260e2d3a4af"],"conversationId":"589f116612aa254aa4fef79f","name":null,"isAnonymous":null}';
    FocusScope.of(context).unfocus();
    _socketIoManager.sendMessage(
        "chat",
        Message(
                message: _textEditingController.text,
                group: '0',
                responding_to: null,
                update_by: '${feedsBox.get('userID')}',
                profile_pic: null,
                first_name: '${feedsBox.get('firstname')}',
                last_name: '${feedsBox.get('lastname')}',
                post_id: DateTime.now().millisecond + DateTime.now().second,
                //  '${feedsBox.get('userID')}',
                profession_n: '[C.E.O. at NaHere]',
                time: DateTime.now())
            .toJson());

    // _socketIoManager.sendMessage('chat', Message(

    // ));
    // if (isError1 == true) {
    //   return;
    // _showToast(context,
    //     'Please check your internet connection!! or you dont have any feeds available');
    //  } else if (isError1 == true) {
    // Provider.of<MessagesProvider>(context, listen: false).addMessage(
    //   Message(
    //     message: _textEditingController.text,
    //     group: '0',
    //     responding_to: null,
    //     update_by: '${feedsBox.get('userID')}',
    //     profile_pic: null,
    //     first_name: '${feedsBox.get('firstname')}',
    //     last_name: '${feedsBox.get('firstname')}',
    //     post_id: DateTime.now().millisecondsSinceEpoch + DateTime.now().second,
    //     profession_n: '[C.E.O. at NaHere]',
    //     time: DateTime.now()));
    //  }
    res1.data.add(Data(
      message: _textEditingController.text,
      firstname: '${feedsBox.get('firstname')}',
      lastname: '${feedsBox.get('firstname')}',
      profilePic: null,
      profession: '[C.E.O. at NaHere]',
      // updateTime: DateTime.now()

      // group: '0',
      // respondingto: null,
      // updateby: '${feedsBox.get('userID')}',
      // profile_pic: null,
      // first_name: '${feedsBox.get('firstname')}',
      // last_name: '${feedsBox.get('firstname')}',
      // post_id: DateTime.now().millisecondsSinceEpoch + DateTime.now().second,
      // profession_n: '[C.E.O. at NaHere]',
      // time: DateTime.now())
    ));

    _textEditingController.clear();
    setState(() {});
    // isError = true;
  }

  @override
  void initState() {
    super.initState();
    publicFeeds();

    initHive();
    _textEditingController = TextEditingController();
    _joinChat();
    _scrollController = ScrollController();

    _socketIoManager = SocketIoManager(serverUrl: SERVER_URL)
      ..init()
      ..subscribe('chat', (Map<String, dynamic> socket2data) {
        res1.data.add(Data.fromJson(socket2data));
        // Provider.of<MessagesProvider>(context, listen: false)
        //     .addMessage(Message.fromJson(socket2data));
        // _scrollController.animateTo(
        //   0.0,
        //   duration: Duration(milliseconds: 200),
        //   curve: Curves.bounceInOut,
        // );
        setState(() {
          isError1 = true;
        });
      })
      // ..subscribe('chat', (Map<String, dynamic> socket2data) {
      //   _userNameTyping = socket2data['first_name'];
      //   setState(() {
      //     _isTyping = true;
      //   });
      // })
      // ..subscribe('chat', (Map<String, dynamic> socket2data) {
      //   setState(() {
      //     _isTyping = false;
      //   });
      // })
      ..connect();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (_scrollcontroller.hasClients) {
        _scrollcontroller.animateTo(
          _scrollcontroller.position.maxScrollExtent,
          duration: const Duration(milliseconds: 10),
          curve: Curves.ease,
        );
      }
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _scrollController.dispose();
    _socketIoManager.disconnect();
    super.dispose();
  }

  double screenHeight, screenWidth;

  dynamic data;
  List data2;
  bool isLoading = false;
  bool isError = false;
  SocialFeeds2 res1;
  var listOfImages = [];
  String urlPrefix = 'https://empl-dev.site/';
  // Message _message = Message();

  Future<SocialFeeds2> publicFeeds() async {
    // print('${feedsBox.get('userID')}');
    String url =
        // 'https://empl-dev.site/api/social/fetch_updates?user=${feedsBox.get('userID')}&group_id=0&page=0&limit=250000000';
        'https://empl-dev.site/api/social/fetch_updates?user=117&group_id=0&page=0&limit=5';
    try {
      final response = await http.get(url);
      // final response = await Provider.of<CallApi>(context, listen: false)
      //     .getData('social/fetch_updates?user=117&group_id=0&page=0&limit=25');
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        data2 = json.decode(response.body)['data'];
        res1 = SocialFeeds2.fromJson(data);
        for (int index = 0; index < res1.data.length; index++) {
          if (res1.data[index].socialFiles != null) {
            for (int i = 0; i < res1.data[index].socialFiles.length; i++) {
              listOfImages.add(res1.data[index].socialFiles[index].val);
            }
          }
          // if (data2[index]['socialFiles'] != null) {
          //   for (int i = 0; i < data2[index]['socialFiles'].length; i++) {
          //     listOfImages.add(data2[index]['socialFiles'][i]['val']);
          //   }
          // }
        }
        setState(() {
          isLoading = true;
        });
        // Provider.of<MessagesProvider>(context, listen: false).addMessage(res1);
        return res1;
      } else {
        throw Exception('Failed to load feeds');
      }
    } catch (e) {
      setState(() {
        isError = true;
      });
      // _showToast(context,
      //     'Please check your internet connection!! or you dont have any feeds available');
      return e;
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
    return Container(height: screenHeight / 1.25, child: buildListView(res1));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          ' Public Feeds',
          style: GoogleFonts.montserrat(
              color: Color(0xff01A0C7),
              fontSize: 17,
              fontWeight: FontWeight.w500),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
                // _modalBottomSheetMenu();
              }),
        ],
      ),
      drawer: MyDrawer(),
      body: SafeArea(
          child: Stack(
        // overflow: Overflow.visible,
        children: [
          Container(
              height: screenHeight / 1.25,
              child: ListView(
                shrinkWrap: true,
                children: [
                  tyy(),
                  // Consumer<MessagesProvider>(
                  //   builder: (_, messagesProvider, __) => ListView.separated(
                  //       shrinkWrap: true,
                  //       physics: BouncingScrollPhysics(),
                  //       separatorBuilder: (context, index) => Divider(
                  //             indent: 10.0,
                  //             endIndent: 10.0,
                  //             color:
                  //                 Provider.of<ThemeNotifier>(context).lightTheme
                  //                     ? Colors.black12
                  //                     : Colors.white24,
                  //           ),
                  //       reverse: true,
                  //       controller: _scrollController,
                  //       itemCount: messagesProvider.allMessages.length,
                  //       itemBuilder: (ctx, index) => MessagesItem(
                  //             messagesProvider.allMessages[index],
                  //             messagesProvider.allMessages[index]
                  //                 .isUserMessage(_textEditingController.text),
                  //           )),
                  // ),
                ],
              )),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Material(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                        elevation: 2,
                        child: Row(children: [
                          Expanded(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: size.width,
                                maxWidth: size.width,
                                minHeight: 25.0,
                                maxHeight: 300.0,
                              ),
                              child: Form(
                                child: TextFormField(
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black87,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  // onChanged: (_) {
                                  //   _runTimer();
                                  // },
                                  // onFieldSubmitted: (_) {
                                  //   _sendMessagebutton();
                                  // },
                                  cursorColor: Color(0xff01A0C7),
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  controller: _textEditingController,
                                  decoration: InputDecoration(
                                    prefixIcon: IconButton(
                                        icon: Icon(
                                          Icons.attach_file,
                                          color: Colors.grey,
                                        ),
                                        onPressed: () {}),
                                    suffixIcon: IconButton(
                                        icon: Icon(
                                          Icons.camera_alt,
                                          color: Colors.grey,
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailsPage()),
                                          );
                                        }),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        top: 13.0,
                                        left: 13.0,
                                        right: 13.0,
                                        bottom: 13.0),
                                    hintText: "Type a Message",
                                    hintStyle: GoogleFonts.montserrat(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Color(0xff01A0C7),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: IconButton(
                            icon: Icon(
                              Icons.send,
                              color: Colors.white,
                              size: 20,
                            ),
                            onPressed: _sendMessage),
                      ),
                    ),
                  ],
                ),
              ))
        ],
      )),
    );
  }

  List<Widget> getSubtitleChildren(
      dynamic jsonBody, int index, String urlPrefix) {
    List<Widget> _mWidgets = [];

    for (int i = 0; i < jsonBody['data'][index]['socialFiles'].length; i++) {
      if (jsonBody['data'][index]['socialFiles'][i]
          .toString() //xlsx
          .contains('.pdf')) {
        Widget pdfImage = Stack(
          children: [
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
                        print('Permission denied');
                      }
                    }),
              ),
            ),
          ],
        );
        _mWidgets.add(pdfImage);
      } else if (jsonBody['data'][index]['socialFiles'][i]
              .toString() //xlsx
              .contains('.xls') ||
          jsonBody['data'][index]['socialFiles'][i]
              .toString() //xlsx
              .contains('.xlsx')) {
        Widget pdfImage = Stack(children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/images/excel5.jpg')),
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
                        requiresStorageNotLow: true);
                  } else {
                    _showToast(context, 'Permission denied');
                    print('Permission denied');
                  }
                }),
          )),
        ]);
        _mWidgets.add(pdfImage);
      } else if (jsonBody['data'][index]['socialFiles'][i]
          .toString()
          .contains('.doc')) {
        Widget pdfImage = Stack(children: [
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
        ]);
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
      backgroundColor: Colors.red,
      shape: RoundedRectangleBorder(),
      content: Text(
        msg,
        style: GoogleFonts.montserrat(fontSize: 12, color: Colors.white),
      ),
      duration: Duration(seconds: 10),
    );

    GlobalKey<ScaffoldState>().currentState.showSnackBar(snackBar);
  }

  ListView buildListView(
    SocialFeeds2 res1,
  ) {
    return ListView.separated(
      // shrinkWrap: true,
      // reverse: true,
      // key:
      // ValueKey(10), // PageStorageKey(snapshot.data.data),
      physics: BouncingScrollPhysics(),
      separatorBuilder: (context, index) => Divider(
        color: Provider.of<ThemeNotifier>(context).lightTheme
            ? Colors.black12
            : Colors.white24,
      ),
      controller: _scrollcontroller,
      itemCount: res1.data.length != null ? res1.data.length : Text('no Feeds'),
      itemBuilder: (BuildContext context, int index) {
        return Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            //   mainAxisSize: MainAxisSize.max,
            children: [
              // Consumer<MessagesProvider>(
              //   builder: (_, messagesProvider, __) => ListView.separated(
              //     shrinkWrap: true,
              //     physics: BouncingScrollPhysics(),
              //     separatorBuilder: (context, index) => Divider(
              //       indent: 10.0,
              //       endIndent: 10.0,
              //       color: Provider.of<ThemeNotifier>(context).lightTheme
              //           ? Colors.black12
              //           : Colors.white24,
              //     ),
              //     reverse: true,
              //     controller: _scrollController,
              //     itemCount: messagesProvider.allMessages.length,
              //     itemBuilder: (ctx, index) => MessagesItem(
              //       messagesProvider.allMessages[index],
              //       // messagesProvider.allMessages[index]
              //       //     .isUserMessage(_textEditingController.text),s
              //     ),
              //   ),
              // ),
              ListTile(
                leading: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      // Container(
                      //   child:  res1.data[index].profilePic != null
                      //       ? CachedNetworkImage(
                      //           imageUrl:
                      //               urlPrefix + res1.data[index].profilePic,
                      //           imageBuilder: (context, imageProvider) =>
                      //               Container(
                      //             width: 50.0,
                      //             height: 50.0,
                      //             decoration: BoxDecoration(
                      //               shape: BoxShape.circle,
                      //               image: DecorationImage(
                      //                   image: imageProvider,
                      //                   fit: BoxFit.cover),
                      //             ),
                      //           ),
                      //           placeholder: (context, url) =>
                      //               //  CircleAvatar(
                      //               //   radius: 25,
                      //               //   backgroundColor: Colors.white,
                      //               //   backgroundImage: AssetImage(
                      //               //       'assets/images/no_image.png'),
                      //               // ),
                      //               CircularProgressIndicator(
                      //             strokeWidth: 1.5,
                      //             backgroundColor: Color(0xff01A0C7),
                      //           ),
                      //           errorWidget: (context, url, error) =>
                      //               CircleAvatar(
                      //             radius: 25,
                      //             backgroundColor: Colors.white,
                      //             backgroundImage:
                      //                 AssetImage('assets/images/no_image.png'),
                      //           ),
                      //         )
                      //       : Container(
                      //           child: Center(
                      //             child: SpinKitFadingCircle(
                      //               color: Color(0xff01A0C7),
                      //               size: 50,
                      //             ),
                      //           ),
                      //         ),
                      // ),
                    ]),
                title: Row(
                  children: <Widget>[
                    Text(
                      res1.data[index].firstname,
                      style: GoogleFonts.montserrat(
                          fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      res1.data[index].lastname,
                      style: GoogleFonts.montserrat(
                          fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    // Text(
                    //   timeago
                    //       .format(DateTime.parse(res1.data[index].updateTime)),
                    //   // data2[index]['updateTime'].toString(),
                    //   //  timeago.format(DateTime.parse(data2[index]['updateTime'])),
                    //   style: GoogleFonts.montserrat(
                    //       fontSize: 10, fontWeight: FontWeight.w200),
                    // )
                  ],
                ),
                subtitle: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      res1.data[index].profession != null
                          ? res1.data[index].profession
                          : '',
                      // _parseHtmlString(snapshot.data.data[index].lastname),
                      style: GoogleFonts.montserrat(
                          fontSize: 14, fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      res1.data[index].message,
                      style: GoogleFonts.montserrat(
                          fontSize: 14, fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    res1.data[index].socialFiles != null
                        ? GridView.count(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            children:
                                getSubtitleChildren(data, index, urlPrefix))
                        : Container()
                  ],
                ),
              ),
            ]);
      },
    );
  }
}
