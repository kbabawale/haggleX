import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hagglex/util/strings.dart';
import 'package:hagglex/widgets/queryMutation.dart';
import 'package:hagglex/widgets/spacing.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hagglex/widgets/graphqlConfig.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  bool loggedinData;

  @override
  Widget build(BuildContext context) {
    QueryMutation queryMutation = QueryMutation();
    var size = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
          body: SingleChildScrollView(
              child: Mutation(
                  options: MutationOptions(
                      fetchPolicy: FetchPolicy.noCache,
                      onError: (error) {
                        print(error);
                      },
                      onCompleted: (data) {
                        print(data);
                        Navigator.of(context).pushNamed('/dashboard');
                      },
                      documentNode: gql(queryMutation.login())),
                  builder: (RunMutation runMutation, QueryResult result) {
                    return Container(
                      width: size.width,
                      height: size.height,
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
                          addVerticalSpace(140),
                          Text(
                            'Welcome!',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                          addVerticalSpace(20),
                          TextField(
                            controller: _userNameController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 5),
                              fillColor: Color.fromRGBO(0, 0, 0, 0),
                              filled: true,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(153, 153, 153, 1),
                                    width: 1.5),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    width: 1.2),
                              ),
                              border: InputBorder.none,
                              labelText: "Email Address",
                              labelStyle: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, .7),
                                  fontSize: 10),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          addVerticalSpace(25),
                          TextField(
                            controller: _passwordController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 5),
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
                                  color: Color.fromRGBO(255, 255, 255, .7),
                                  fontSize: 10),
                            ),
                            keyboardType: TextInputType.text,
                            obscureText: true,
                          ),
                          addVerticalSpace(30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Material(
                                color: Color.fromRGBO(255, 255, 255, 0),
                                child: InkWell(
                                  onTap: () {
                                    print('hello');
                                  },
                                  child: Text(
                                    'Forgot Password?',
                                    style: TextStyle(
                                        color:
                                            Color.fromRGBO(255, 255, 255, .7)),
                                  ),
                                ),
                              )
                            ],
                          ),
                          addVerticalSpace(30),
                          Material(
                            color: Color.fromRGBO(62, 6, 6, 0),
                            child: InkWell(
                              onTap: () {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());

                                runMutation(<String, dynamic>{
                                  'input': _userNameController.text.trim(),
                                  'password': _passwordController.text.trim(),
                                });
                              },
                              child: Container(
                                width: size.width,
                                padding: EdgeInsets.symmetric(vertical: 15),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    color: Color.fromRGBO(255, 193, 117, 1)),
                                child: Text(
                                  'LOG IN',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color.fromRGBO(62, 6, 6, 1),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          addVerticalSpace(40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Material(
                                color: Color.fromRGBO(255, 255, 255, 0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushNamed('/signup');
                                  },
                                  child: Text(
                                    'New User? Create a new account',
                                    style: TextStyle(
                                        color:
                                            Color.fromRGBO(255, 255, 255, .7)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  })),
        ));
  }
}
