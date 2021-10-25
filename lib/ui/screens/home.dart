import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:notification_app/view_models/auth_view_model.dart';
import 'package:notification_app/view_models/base_view_model.dart';
import 'package:provider/provider.dart';

class LandingScreen extends StatefulWidget {
  @override
  LandingScreenState createState() => LandingScreenState();
}

class LandingScreenState extends State<LandingScreen> {
  TextEditingController _numberField = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authVM = context.read<AuthViewModel>();
    final appState =
        context.select<AuthViewModel, ViewState>((value) => value.appState);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3,
                margin: EdgeInsets.all(25.0),
                // child: Image.asset(),
                decoration: new BoxDecoration(
                    image: new DecorationImage(
                        fit: BoxFit.contain,
                        image: new AssetImage(
                            "assets/Reminder Note_Isometric.png")))),
            Container(
              margin: EdgeInsets.only(top: 7),
              child: Text(
                "Notifications App",
                style: TextStyle(
                    color: Colors.blue[800],
                    fontSize: (28 / 720) * MediaQuery.of(context).size.height,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 5),
                child: Text(
                  "Lorem ipsum dolor sit amet\ndummy intro text here... ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: (15 / 720) * MediaQuery.of(context).size.height,
                      fontWeight: FontWeight.w600),
                )),
            Expanded(child: Container()),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              width: MediaQuery.of(context).size.width / 1.3,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.blue[800]),
              child: MaterialButton(
                  onPressed: () {
                    showMaterialModalBottomSheet(
                        context: context,
                        enableDrag: true,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        // clipBehavior: Clip.antiAliasWithSaveLayer,
                        //   animationCurve: ,
                        elevation: 3.0,
                        builder: (context) => Form(
                              key: formKey,
                              child: Container(
                                height: 300,
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 20),
                                      child: Text(
                                        "Add your phone number to receive notifications",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: (17 / 720) *
                                                MediaQuery.of(context)
                                                    .size
                                                    .height,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 15),
                                      width: MediaQuery.of(context).size.width /
                                          1.3,
                                      child: TextFormField(
                                        controller: _numberField,
                                        validator: (val) {
                                          if (val.isEmpty)
                                            return "Enter a phone number";

                                          if (int.tryParse(val) == null)
                                            return "Enter a valid phone number";

                                          if (val.length != 11)
                                            return "Enter a valid phone number";
                                          return null;
                                        },
                                        style: TextStyle(color: Colors.black),
                                        decoration: InputDecoration(
                                          hintText: "7059392971",
                                          prefixText: "+234",
                                          labelText: "phone number",
                                          labelStyle: TextStyle(
                                              color: Colors.grey,
                                              fontSize: (17 / 720) *
                                                  MediaQuery.of(context)
                                                      .size
                                                      .height,
                                              fontWeight: FontWeight.w500),
                                          focusedBorder: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.grey,
                                                  width: 1.5)),
                                          enabledBorder: new OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey,
                                                  width: 1.5)),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 17),
                                      width: MediaQuery.of(context).size.width /
                                          1.8,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          color: Colors.blue[800]),
                                      child: MaterialButton(
                                          onPressed: () {
                                            if (formKey.currentState
                                                .validate()) {
                                              authVM.saveContact(
                                                  _numberField.text);
                                            }
                                          },
                                          child: appState == ViewState.busy
                                              ? CircularProgressIndicator()
                                              : Text(
                                                  "Add number",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: (15 / 720) *
                                                          MediaQuery.of(context)
                                                              .size
                                                              .height,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                    ),
                                  ],
                                ),
                              ),
                            ));
                  },
                  child: Text(
                    "Get Started",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize:
                            (15 / 720) * MediaQuery.of(context).size.height,
                        fontWeight: FontWeight.w500),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
