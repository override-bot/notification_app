import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
class LandingScreen extends StatefulWidget{
  @override
  LandingScreenState createState() => LandingScreenState();
}
class LandingScreenState extends State<LandingScreen>{
  @override
  Widget build(BuildContext context) {
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
                              margin:EdgeInsets.only(top: 7),
                              child: Text(
                                "Notifications App",
                                style: TextStyle(
                                  color: Colors.blue[800],
                                   fontSize: (28/ 720) * MediaQuery.of(context).size.height,
                                   fontWeight: FontWeight.w700
                                ),
                              ),
                            ),
                            Container(
                              margin:EdgeInsets.only(top: 5),
                              child:Text(
                                "Lorem ipsum dolor sit amet\ndummy intro text here... ",
                                textAlign: TextAlign.center,
                                 style: TextStyle(
                                  color: Colors.grey,
                                   fontSize: (15/ 720) * MediaQuery.of(context).size.height,
                                   fontWeight: FontWeight.w600
                                ),
                              )
                            ),

                            Expanded(child:Container()),
                             Container(
                               margin:EdgeInsets.only(bottom: 20),
              width: MediaQuery.of(context).size.width / 1.3,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.blue[800]),
              child: MaterialButton(
                onPressed: (){
                  showMaterialModalBottomSheet(context: context, 
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20)
                ),
                
              ),
             // clipBehavior: Clip.antiAliasWithSaveLayer,
               //   animationCurve: ,
                  elevation: 3.0,
                  builder: (context) => Container(
                    height: 100,
                  ));
                },
                child: Text(
                  "Get Started",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: (15/720) * MediaQuery.of(context).size.height,
                    fontWeight: FontWeight.w500
                  ),
                )
                   
              ),
            ),
             ],
           ),
         ),
      );
  }

}