import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

DatabaseReference dbref = FirebaseDatabase.instance.ref().child('users');
final _auth = FirebaseAuth.instance;

class welcomescreen extends StatefulWidget {
  const welcomescreen({Key? key}) : super(key: key);

  @override
  State<welcomescreen> createState() => _welcomescreenState();
}

class _welcomescreenState extends State<welcomescreen> {
  String name = '', email = '', contact = '';
  bool showSpinner=true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() async {
    final user = await _auth.currentUser;
    final snapshot = await dbref.get();
    if (snapshot.exists) {
      Map data = snapshot.value as Map;
      data.forEach((key, value) {
        if (value['email'] == user?.email) {
          updateUi(value);
        }
      });
    } else {
      print('No data available.');
    }
  }

  void updateUi(Map value) {
    setState(() {
      name = value['name'];
      email = value['email'];
      contact = value['contact'];
      showSpinner=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/welcome.jpg'), fit: BoxFit.fill),
        ),
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: showSpinner?null:Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.4,
                  left: MediaQuery.of(context).size.width*0.1),
              child: Column(
                children: [
                  Text(
                    'Hello $name',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,                    ),
                  ),
                  SizedBox(height: 10,),
                  Text('Your Email is $email',style: TextStyle(
                    fontSize: 15
                  ),),
                  SizedBox(height: 10,),
                  Text('Contact no is $contact',style: TextStyle(
                    fontSize: 15,
                  ),),
                  SizedBox(height: 10,),
                  Text('Dont worry \n These details are safe with us!',textAlign: TextAlign.center,style: TextStyle(
                    fontSize: 15,
                  ),),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
