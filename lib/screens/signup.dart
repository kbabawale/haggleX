import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hagglex/widgets/queryMutation.dart';
import 'package:hagglex/widgets/spacing.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:country_pickers/country.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hagglex/widgets/graphqlConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
  QueryMutation addMutation = QueryMutation();
  // GraphQLClient _client = graphQLConfiguration.clientToQuery();
  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _referralController = new TextEditingController();
  TextEditingController _countryCodeController =
      new TextEditingController(text: '+234');
  bool loggedinData;
  Country _selectedDialogCountry =
      CountryPickerUtils.getCountryByPhoneCode('234');

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    QueryMutation queryMutation = QueryMutation();
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
          body: SizedBox.expand(
            child: SingleChildScrollView(
              child: Mutation(
                options: MutationOptions(
                    fetchPolicy: FetchPolicy.noCache,
                    onError: (error) {
                      print(error);
                    },
                    onCompleted: (data) {
                      Navigator.of(context).pushNamed('/verify');
                    },
                    documentNode: gql(queryMutation.addUser())),
                builder: (RunMutation runMutation, QueryResult result) {
                  return Container(
                    width: size.width,
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment(-0.8, -0.6),
                        colors: [
                          Color.fromRGBO(63, 42, 117, 1),
                          Color.fromRGBO(46, 25, 99, 1)
                        ],
                        radius: 0.7,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        addVerticalSpace(70),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: size.width * 0.12,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            margin: EdgeInsets.only(left: 20),
                            child: Icon(Icons.arrow_back_ios,
                                size: 20,
                                color: Color.fromRGBO(255, 255, 255, 1)),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(17)),
                                color: Color.fromRGBO(255, 255, 255, 0.2)),
                          ),
                        ),
                        addVerticalSpace(50),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 50, horizontal: 20),
                          width: size.width,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(17)),
                              color: Color.fromRGBO(255, 255, 255, 1)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Create a new account',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              addVerticalSpace(20),
                              TextField(
                                controller: _emailController,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 5),
                                  fillColor: Color.fromRGBO(0, 0, 0, 0),
                                  filled: true,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(153, 153, 153, 1),
                                        width: 1.5),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(153, 153, 153, 1),
                                        width: 1.2),
                                  ),
                                  border: InputBorder.none,
                                  labelText: "Email Address",
                                  labelStyle: TextStyle(
                                      color: Colors.black, fontSize: 10),
                                ),
                                keyboardType: TextInputType.emailAddress,
                              ),
                              addVerticalSpace(25),
                              TextField(
                                controller: _passwordController,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 5),
                                  fillColor: Color.fromRGBO(0, 0, 0, 0),
                                  filled: true,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(153, 153, 153, 1),
                                        width: 1.5),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(153, 153, 153, 1),
                                        width: 1.2),
                                  ),
                                  border: InputBorder.none,
                                  labelText: "Password (Min. 8 characters)",
                                  labelStyle: TextStyle(
                                      color: Colors.black, fontSize: 10),
                                ),
                                keyboardType: TextInputType.text,
                                obscureText: true,
                              ),
                              addVerticalSpace(25),
                              TextField(
                                controller: _userNameController,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 5),
                                  fillColor: Color.fromRGBO(0, 0, 0, 0),
                                  filled: true,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(153, 153, 153, 1),
                                        width: 1.5),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(153, 153, 153, 1),
                                        width: 1.2),
                                  ),
                                  border: InputBorder.none,
                                  labelText: "Create a username",
                                  labelStyle: TextStyle(
                                      color: Colors.black, fontSize: 10),
                                ),
                                keyboardType: TextInputType.text,
                              ),
                              addVerticalSpace(25),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 122,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(232, 232, 232, 1),
                                      border: Border.all(color: Colors.black),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6)),
                                    ),
                                    child: ListTile(
                                      onTap: _openCountryPickerDialog,
                                      title: _buildDialogItem2(
                                          _selectedDialogCountry),
                                    ),
                                  ),
                                  addHorizontalSpace(10),
                                  Expanded(
                                    child: TextField(
                                      controller: _phoneController,
                                      style: TextStyle(color: Colors.black),
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 5),
                                        fillColor: Color.fromRGBO(0, 0, 0, 0),
                                        filled: true,
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  153, 153, 153, 1),
                                              width: 1.5),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  153, 153, 153, 1),
                                              width: 1.2),
                                        ),
                                        border: InputBorder.none,
                                        labelText: "Enter your phone number",
                                        labelStyle: TextStyle(
                                            color: Colors.black, fontSize: 10),
                                      ),
                                      keyboardType: TextInputType.phone,
                                    ),
                                  )
                                ],
                              ),
                              addVerticalSpace(25),
                              TextField(
                                controller: _referralController,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 5),
                                  fillColor: Color.fromRGBO(0, 0, 0, 0),
                                  filled: true,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(153, 153, 153, 1),
                                        width: 1.5),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(153, 153, 153, 1),
                                        width: 1.2),
                                  ),
                                  border: InputBorder.none,
                                  labelText: "Referral code (optional)",
                                  labelStyle: TextStyle(
                                      color: Color.fromRGBO(0, 0, 0, .5),
                                      fontSize: 10),
                                ),
                                keyboardType: TextInputType.text,
                              ),
                              addVerticalSpace(30),
                              Text(
                                'By signing, you agree to HaggleX terms and privacy policy.',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal),
                              ),
                              addVerticalSpace(45),
                              GestureDetector(
                                onTap: () async {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setString(
                                      "email",
                                      _emailController.value.text
                                          .toString()
                                          .trim());
                                  runMutation(<String, dynamic>{
                                    'email': _emailController.text.trim(),
                                    'username': _userNameController.text.trim(),
                                    'password': _passwordController.text.trim(),
                                    'country': 'Nigeria',
                                    'phonenumber': _phoneController.text.trim(),
                                    'currency': 'NGN',
                                    'referralCode': ''
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  width: size.width,
                                  child: Text(
                                    'SIGN UP',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Color.fromRGBO(67, 43, 123, 1),
                                            Color.fromRGBO(106, 75, 188, 1)
                                          ])),
                                ),
                              ),
                              addVerticalSpace(25)
                            ],
                          ),
                        ),
                        addVerticalSpace(80)
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ));
  }

  void _openCountryPickerDialog() => showDialog(
        context: context,
        builder: (context) => Theme(
            data: Theme.of(context).copyWith(primaryColor: Colors.pink),
            child: Scaffold(
              backgroundColor: Color.fromRGBO(46, 25, 99, 1),
              body: CountryPickerDialog(
                  titlePadding: EdgeInsets.all(8.0),
                  searchCursorColor: Colors.pinkAccent,
                  searchInputDecoration: InputDecoration(hintText: 'Search...'),
                  isSearchable: true,
                  // title: Text('Select your phone code'),
                  onValuePicked: (Country country) =>
                      setState(() => _selectedDialogCountry = country),
                  priorityList: [
                    CountryPickerUtils.getCountryByIsoCode('NG'),
                  ],
                  itemBuilder: _buildDialogItem),
            )),
      );
}

Widget _buildDialogItem(Country country) => Row(
      children: <Widget>[
        CountryPickerUtils.getDefaultFlagImage(country),
        SizedBox(width: 8.0),
        Text("+${country.phoneCode}"),
        SizedBox(width: 8.0),
        Flexible(child: Text(country.name))
      ],
    );

Widget _buildDialogItem2(Country country) => Row(
      children: <Widget>[
        CountryPickerUtils.getDefaultFlagImage(country),
        SizedBox(width: 8.0),
        Text("+${country.phoneCode}"),
      ],
    );
