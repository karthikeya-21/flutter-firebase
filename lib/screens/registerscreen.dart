import 'package:flutter/material.dart';
import 'package:firebase_demo/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

final _auth=FirebaseAuth.instance;
DatabaseReference dbref=FirebaseDatabase.instance.ref().child('users');

class registerscreen extends StatefulWidget {
  const registerscreen({Key? key}) : super(key: key);

  @override
  State<registerscreen> createState() => _registerscreenState();
}



class _registerscreenState extends State<registerscreen> {
  late String email,password,phno,name;
  bool showSpinner=false;


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/register.jpg'), fit: BoxFit.fill),
      ),
      child: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 117, left: 15),
                  child: Text(
                    'Hello\n New User',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.12,
                    left: 20,
                    right: 20,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                        decoration: edittextdecoration.copyWith(hintText: 'Enter your Name'),
                        onChanged: (value){
                          name=value;
                        },

                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: edittextdecoration.copyWith(hintText: 'Enter your Email'),
                        onChanged: (value){
                          email=value;
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                        obscureText: true,
                        decoration: edittextdecoration.copyWith(hintText: 'Enter your Password'),
                        onChanged: (value){
                          password=value;
                        },

                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration: edittextdecoration.copyWith(hintText: 'Enter your Phno'),
                        onChanged: (value){
                          phno=value;
                        },

                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Material(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(10.0),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextButton(
                            onPressed: () async{
                              setState(() {
                                showSpinner=true;
                              });
                              try{
                                Map<String,String> user={
                                  'name':name,
                                  'email':email,
                                  'contact':phno,
                                };
                              var newuser=await _auth.createUserWithEmailAndPassword(email: email, password: password);
                              if(newuser!=null){
                                await dbref.push().set(user);
                                Navigator.pushNamed(context, 'welcome');
                              }
                              }catch(e){
                                final snackbar=SnackBar(content: Text(e.toString(),
                                ),
                                action: SnackBarAction(label: 'ok', onPressed: (){}),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(snackbar);
                                print(e);
                              }
                              setState(() {
                                showSpinner=false;
                              });
                            },
                            child: Text(
                              'Register',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Already a User?'),
                          SizedBox(
                            width: 20,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, 'login');
                            },
                            child: Text(''
                                'Login in Here!'),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
