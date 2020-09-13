import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:nahere/controllers/api.dart';
import 'package:nahere/controllers/auth/auth.dart';

import 'package:nahere/models/countrymodel.dart/countries.dart';
import 'package:nahere/models/countrymodel.dart/serializers.dart';
import 'package:nahere/views/pages/user_Profile.dart';

import 'package:nahere/widgets/drawer.dart';

import 'package:http/http.dart' as http;

import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

class EditProfilePage extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState();
}

// class Genders {
//   String name;
//   int index;
//   Genders({this.name, this.index});
// }

class MapScreenState extends State<EditProfilePage>
    with SingleTickerProviderStateMixin {
  String firstname, lastname;
  final FocusNode myFocusNode = FocusNode();
  TextEditingController _occupationController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _othernameController = TextEditingController();
  TextEditingController _countrynameController = TextEditingController();
  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  // TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  //TextEditingController _genderController = TextEditingController();

  Box<String> feedsBox;
  File imageFile;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  var userData;

  //String filetypeuploadPrefix = filetypeupl
  // var filetype = {'jpg', 'jpeg', 'png'};
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  // int index = 0;

  var currentSelectedValue;
  String selectedUser;

  var selectGender;

  @override
  void initState() {
    super.initState();

    feedsBox = Hive.box('feedsApp');
    _getUserInfo();
    _occupationController.text =
        feedsBox.get('name') != null ? '${feedsBox.get('name')}' : '';
    _stateController.text =
        feedsBox.get('state') != null ? '${feedsBox.get('state')}' : '';

    _countrynameController.text = feedsBox.get('usercountrydrop') != null
        ? '${feedsBox.get('usercountrydrop')}'
        : '';
    _dobController.text =
        feedsBox.get('dobEdit') != null ? '${feedsBox.get('dobEdit')}' : '';

    _phoneController.text = feedsBox.get('phoneNumberEdit') != null
        ? '${feedsBox.get('phoneNumberEdit')}'
        : '';

    _othernameController.text = feedsBox.get('otherNameEdit') != null
        ? '${feedsBox.get('otherNameEdit')}'
        : '';

    _firstnameController.text = feedsBox.get('firstNameEdit') != null
        ? '${feedsBox.get('firstNameEdit')}'
        : '';

    _lastnameController.text = feedsBox.get('lastNameEdit') != null
        ? '${feedsBox.get('lastNameEdit')}'
        : '';

    this.getCountries();
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('data');
    var user = json.decode(userJson);
    setState(() {
      userData = user;
    });
  }

  @override
  void dispose() {
    _occupationController.dispose();
    myFocusNode.dispose();

    super.dispose();
  }

  getFile() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      imageFile = image;
    });
  }

  void uploadFile() async {
    if (imageFile == null) return;
    String base64Image = base64Encode(imageFile.readAsBytesSync());

    final convertbase64Image = base64Image;
    feedsBox.put('base64Imageconvert', convertbase64Image);
    print(base64Image);
    String fileName = imageFile.path.split(".").last;

    // String fileName = path.basename(filePath.path);
    print('file base name: $fileName');

    setState(() {
      _isLoading = true;
    });

    try {
      FormData formData = FormData.fromMap({
        'user_id': userData['user_id'],
        'file': 'data:image/$fileName;base64,' + base64Image,
        // .split(".")
        //.last, //await MultipartFile.fromFile(base64Image, ),
        'to_where': 'user_photo'
      });
      Response response = await Dio().post(
          // 'https://empl-dev.site/api/company/upload_images2?to_where=user_photo',
          'https://empl-dev.site/api/company/upload_images2',
          data: formData);

      print('File upload response: $response');

      // return( '$response');
      _showToast(context, response.data['msg']);

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print('exception caught: $e');
      setState(() {
        _isLoading = false;
      });
      return _showToast(context, 'Image not uploaded successfully');
    }
  }

  Future<Countries> getCountries() async {
    final url = 'https://empl-dev.site/api/country/list_countries';

    try {
      var res = await http.get(Uri.parse(url));
      Countries countries = standardSerializers.deserializeWith(
          Countries.serializer, jsonDecode(res.body));
      // selectedCountries = countries;
      // print(countries);
      return countries;
    } catch (e) {
      print(e);
      return e.message;
    }
  }

  DateTime selectedDate = DateTime.now();

  Future _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.toLocal(),
      firstDate: DateTime(1901, 1),
      lastDate: DateTime(2060),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _dobController.value = TextEditingValue(
            text: '${picked.toLocal()}'.split(" ")[0]); //picked.toString()
      });

      final dateofbirth = _dobController.text;

      feedsBox.put('dobBirth', dateofbirth);
    }
  }

  Future _submit() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      FocusScope.of(context).unfocus();
      setState(() {
        _isLoading = true;
      });
      // Timer(Duration(seconds: 6), onTimeout);
      var data = {
        'firstname': _firstnameController.text,
        'lastname': _lastnameController.text,
        'othernames': _othernameController.text,
        // 'email': _emailController.text,
        'phone': _phoneController.text,
        'dob': _dobController.text,
        'user_id': ' ${userData['user_id']}',
        'gender': '${feedsBox.get('genderSelect')}', // _genderController.text,
      };
      print('${userData['user_id']}');
      print(data);
      try {
        var response = await Provider.of<CallApi>(context, listen: false)
            .postData(data, 'user/update_profile');
        var body = json.decode(response.body);
        print(body);
        if (body['msg'] == 'profile was successfully updated') {
          print('registered successfully!');
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => UserProfileSee()),
          // );
        } else {
          _showToast(context, body['msg']);
        }

        setState(() {
          _isLoading = false;
        });
        _showToast(context, "Profile successfully updated .");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserProfileSee()),
        );
      } catch (e) {
        setState(() {
          _isLoading = false;
        });

        return _showToast(
            context, 'Please check your internet connection and try again!!!');
      }
    }
  }

//final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final dateFormat = DateFormat('yyyy-M-dd');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      //tobe removed for darkmode
      //  backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: AppBar(
        // iconTheme: new IconThemeData(color: Color(0xff01A0C7)),
        elevation: 0.0,
        //tobe removed for darkmode
        //backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Edit Profile',
          style: GoogleFonts.montserrat(
              color: Color(0xff01A0C7),
              fontSize: 17,
              fontWeight: FontWeight.w500),
        ),
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: imageFile == null
                    ? Center(
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(200),
                            border:
                                Border.all(color: Color(0xff01A0C7), width: 3),
                            // Color(0xFFededed)
                            // Color(0xff01A0C7)
                            // boxShadow: [
                            //   BoxShadow(
                            //       color: Colors.white,
                            //       blurRadius: 6,
                            //       spreadRadius: 6,
                            //       offset: Offset.fromDirection(0, 0))
                            // ]
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage:
                                feedsBox.get('base64Imageconvert') != null
                                    ? MemoryImage(
                                        base64Decode(
                                          feedsBox.get('base64Imageconvert'),
                                        ),
                                      )
                                    : NetworkImage(
                                        userData != null
                                            ? userData['photo_path']
                                            : '',
                                        scale: 1.0),
                            //  NetworkImage(
                            //     userData != null
                            //         ? userData['photo_path']
                            //         : '',
                            //     scale: 1.0)
                          ),
                        ),
                      )
                    : Container(
                        width: 100,
                        height: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.file(
                            imageFile,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FlatButton(
                    onPressed: getFile,
                    child: Text(
                      'Choose Image',
                      style: GoogleFonts.montserrat(
                        color: Color(0xff01A0C7),
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Firstname",
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      TextFormField(
                        controller: _firstnameController,
                        validator: EditProfileValidator.validate,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Lastname",
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      TextFormField(
                        controller: _lastnameController,
                        validator: EditProfileValidator.validate,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Othername",
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      TextFormField(
                        controller: _othernameController,
                        validator: EditProfileValidator.validate,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Occupation",
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      TextFormField(
                        controller: _occupationController,
                        validator: EditProfileValidator.validate,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Country",
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          FutureBuilder<Countries>(
                            future: getCountries(),
                            builder: (BuildContext context,
                                AsyncSnapshot<Countries> snapshot) {
                              if (!snapshot.hasData)
                                return Container(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 0.9,
                                  ),
                                );
                              if (snapshot.hasData) {
                                return DropdownButton<Data>(
                                    value: currentSelectedValue,
                                    hint: Text(
                                      'Select Country',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    items: snapshot.data.data.map((Data count) {
                                      return DropdownMenuItem<Data>(
                                          child: Text(count.countryName),
                                          value: count);
                                    }).toList(),
                                    onChanged: (val) {
                                      setState(() {
                                        currentSelectedValue = val;
                                      });
                                      final countrydrop =
                                          currentSelectedValue.countryName;
                                      feedsBox.put(
                                          'usercountrydrop', countrydrop);
                                    });
                              }
                              return Container();
                            },
                          ),
                        ],
                      ),
                      TextFormField(
                        // validator: EditProfileValidator.validate,
                        controller: _countrynameController,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "State",
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      TextFormField(
                        validator: EditProfileValidator.validate,
                        controller: _stateController,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Email",
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      TextFormField(
                        enabled: false,
                        validator: EditProfileValidator.validate,
                        controller: TextEditingController(
                            text: '${feedsBox.get('email2')}'),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Phone number",
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      TextFormField(
                        validator: PhoneNumberValidator1.validatePhoneNumber,
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Dob",
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: AbsorbPointer(
                          child: TextFormField(
                            validator: EditProfileValidator.validate,
                            controller: _dobController,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Gender",
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      DropdownButton<String>(
                          value: feedsBox.get('genderSelect'),
                          // != null
                          //     ? feedsBox.get('genderSelect')
                          //     : Text('select gender'),
                          items: <String>['Male', 'Female', 'Others']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              child: Text(value),
                              value: value,
                            );
                          }).toList(),
                          hint: Text('Select Gender'),
                          onChanged: (val) {
                            setState(() {
                              selectGender = val;
                            });

                            final genderval = selectGender;
                            feedsBox.put('genderSelect', genderval);

                            print(selectGender);
                          }),
                    ],
                  )),
              SizedBox(
                height: 20,
              ),
              Center(
                child: _isLoading
                    ? CircularProgressIndicator(
                        strokeWidth: 1.5,
                      )
                    : Container(
                        width: 200,
                        child: RaisedButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0)),
                          color: Color(0xff01A0C7),
                          textColor: Colors.white,
                          onPressed: () {
                            //  _submit();
                            final val = _occupationController.text;
                            //final middlename = _othernameController.text;
                            final state = _stateController.text;
                            final phonenumber = _phoneController.text;
                            // final gender = _genderController.text;
                            final othername = _othernameController.text;
                            // final countrydrop = currentSelectedValue.countryName;
                            final firstname = _firstnameController.text;
                            final lastname = _lastnameController.text;
                            // feedsBox.put('usercountrydrop', countrydrop);
                            feedsBox.put('firstname', firstname);
                            feedsBox.put('lastname', lastname);
                            feedsBox.put('otherName', othername);
                            feedsBox.put('name', val);
                            feedsBox.put('phone', phonenumber);
                            // feedsBox.put('gender', gender);
                            //feedsBox.put('middlename', middlename);
                            feedsBox.put('state', state);
                            _submit();
                            uploadFile();
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => UserProfileSee()),
                            // );

                            //   _showToast(
                            //       context, "Profile successfully updated .");
                          },
                          child: Text(
                            'Save',
                            style: GoogleFonts.montserrat(
                                fontSize: 17, fontWeight: FontWeight.w300),
                          ),
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _showToast(BuildContext context, msg) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Color(0xff01A0C7),
      shape: RoundedRectangleBorder(),
      content: Text(
        msg,
        style: GoogleFonts.montserrat(fontSize: 12),
      ),
      duration: Duration(seconds: 3),
    );
    //  Navigator.pushAndRemoveUntil(
    //                         context,
    //                         MaterialPageRoute(
    //                             builder: (context) => ProfilePage()),
    //                         (route) => false);
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
