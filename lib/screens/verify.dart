import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hagglex/util/strings.dart';
import 'package:hagglex/widgets/graphqlConfig.dart';
import 'package:hagglex/widgets/queryMutation.dart';
import 'package:hagglex/widgets/spacing.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerifyPage extends StatefulWidget {
  @override
  _VerifyPageState createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  TextEditingController _codeController = new TextEditingController();
  String email;

  Future getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String dataIn2 = prefs.getString("email") ?? '';
    setState(() {
      email = dataIn2;
    });
  }

  Future<QueryResult> resend() async {
    print('Hi');
    QueryMutation queryMutation = QueryMutation();
    final variable = {
      "email": "kolapobabawale@gmail.com",
    };

    GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
    GraphQLClient client = graphQLConfiguration.clientToQuery();

    QueryResult queryResult = await client.query(
      QueryOptions(
          documentNode: gql(queryMutation.resendVerificationCode()),
          variables: variable),
    );
    return queryResult;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getData();
    QueryMutation queryMutation = QueryMutation();
    var size = MediaQuery.of(context).size;
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
                        Navigator.of(context).pushNamed('/complete');
                      },
                      documentNode: gql(queryMutation.verifyUser())),
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
                          Text(
                            'Verify your account',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          addVerticalSpace(30),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 50, horizontal: 20),
                            width: size.width,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(17)),
                                color: Color.fromRGBO(255, 255, 255, 1)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                new Image.asset(
                                  imagesDir + '/tick.png',
                                  repeat: ImageRepeat.noRepeat,
                                ),
                                addVerticalSpace(30),
                                Text(
                                  'We just sent a verification code to your email.',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  'Please enter the code',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal),
                                ),
                                addVerticalSpace(20),
                                TextField(
                                  controller: _codeController,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 5),
                                    fillColor: Color.fromRGBO(0, 0, 0, 0),
                                    filled: true,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(153, 153, 153, 1),
                                          width: 1.5),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(153, 153, 153, 1),
                                          width: 1.2),
                                    ),
                                    border: InputBorder.none,
                                    labelText: "Verification code",
                                    labelStyle: TextStyle(
                                        color: Colors.black, fontSize: 10),
                                  ),
                                  keyboardType: TextInputType.number,
                                ),
                                addVerticalSpace(25),
                                GestureDetector(
                                  onTap: () {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    runMutation(<String, dynamic>{
                                      'code': int.parse(
                                          _codeController.text.trim()),
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    width: size.width,
                                    child: Text(
                                      'VERIFY ME',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Color.fromRGBO(67, 43, 123, 1),
                                              Color.fromRGBO(106, 75, 188, 1)
                                            ])),
                                  ),
                                ),
                                addVerticalSpace(25),
                                Text(
                                  'This code will expire in 10 minutes',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal),
                                ),
                                addVerticalSpace(40),
                                InkWell(
                                  onTap: () {
                                    resend();
                                  },
                                  child: Text(
                                    'Resend Code',
                                    style: TextStyle(
                                        color: Colors.black,
                                        decoration: TextDecoration.underline,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                          addVerticalSpace(80)
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ));
  }
}
