import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/EditAccountSection/textfield.dart';
import 'package:foodzer_customer_app/Preferences/Preferences.dart';

import 'buttonContainer.dart';

class EditAccount extends StatefulWidget {
  const EditAccount({Key? key}) : super(key: key);

  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {

  TextEditingController nameController=new TextEditingController();
  TextEditingController phoneController=new TextEditingController();
  TextEditingController emailController=new TextEditingController();
  bool isEditMode = false;
  bool isname = false;
  bool isphone = false;
  bool isemail = false;
  @override
  void initState() {
    getUserDetails();
    super.initState();
  }


  getUserDetails() async{
    UserPreference().getUserData().then((value)=> {
      nameController.text = value.userName!,
      phoneController.text= value.userMobie!,
      emailController.text= value.userEmail!
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            }, icon: Icon(Icons.keyboard_backspace_outlined,color: Colors.black,size: 30,)),
        title: Text("EDIT ACCOUNT",
            style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w600)),
      ),
      body:SingleChildScrollView(child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 15,right: 15,bottom:isname?0: 20),
            child: TextFormField(

              readOnly: isname?false:true,
              controller: nameController,
              style: TextStyle(
                  color: Colors.black, fontSize: 17),
              decoration: InputDecoration(
                fillColor: Colors.white,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepOrangeAccent),
                ),
                suffixIcon: IconButton(
                  autofocus: true,
                  onPressed: (){
                    setState(() {
                      isname =!isname;
                      isphone= false;
                      isemail = false;
                    });
                  },
                  icon: Icon(Icons.edit,
                  color: Colors.deepOrangeAccent,),
                  iconSize: 16,
                ),
                // disabledBorder: InputBorder.none,
                labelText: "Name",
                labelStyle: TextStyle(
                  height: .5,
                    color: Colors.black, fontSize: 15),

                // enabledBorder: InputBorder.none,
              ),
              maxLines: 1,
            ),
          ),
          isname ? ButtonContainer() : Container(),
          Container(
            margin: EdgeInsets.only(left: 15,right: 15,bottom:isphone?0: 20),
            child: TextFormField(

              readOnly: isphone?false:true,
              controller: phoneController,
              style: TextStyle(
                  color: Colors.black, fontSize: 17),
              decoration: InputDecoration(
                fillColor: Colors.white,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepOrangeAccent),
                ),
                suffixIcon: IconButton(
                  autofocus: true,
                  onPressed: (){
                    setState(() {
                      setState(() {
                        isname =false;
                        isphone= !isphone;
                        isemail = false;
                      });
                    });
                  },
                  icon: Icon(Icons.edit,
                    color: Colors.deepOrangeAccent,),
                  iconSize: 16,
                ),
                // disabledBorder: InputBorder.none,
                labelText: "PHONE NUMBER",
                labelStyle: TextStyle(
                    height: .5,
                    color: Colors.black, fontSize: 15),

                // enabledBorder: InputBorder.none,
              ),
              maxLines: 1,
            ),
          ),
          isphone ? ButtonContainer() : Container(),
          Container(
            margin: EdgeInsets.only(left: 15,right: 15,bottom:isemail?0: 20),
            child: TextFormField(

              readOnly: isemail?false:true,
              controller: emailController,
              style: TextStyle(
                  color: Colors.black, fontSize: 17),
              decoration: InputDecoration(
                fillColor: Colors.white,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepOrangeAccent),
                ),
                suffixIcon: IconButton(
                  autofocus: true,
                  onPressed: (){
                    setState(() {
                      isname =false;
                      isphone= false;
                      isemail = !isemail;
                    });
                  },
                  icon: Icon(Icons.edit,
                    color: Colors.deepOrangeAccent,),
                  iconSize: 16,
                ),
                // disabledBorder: InputBorder.none,
                labelText: "EMAIL ADDRESS",
                labelStyle: TextStyle(
                    height: .5,
                    color: Colors.black, fontSize: 15),

                // enabledBorder: InputBorder.none,
              ),
              maxLines: 1,
            ),
          ),
          isemail ? ButtonContainer() : Container(),
          // TextSection(
          //   onpressed: () {
          //     setState(() {
          //       isname = !isname;
          //       isphone =false;
          //       isemail=false;
          //     });
          //   },
          //   label: "NAME",
          // ),
          // isname ? ButtonContainer() : Container(),
          // TextSection(
          //     label: "PHONE NUMBER",
          //     onpressed: () {
          //       setState(() {
          //         isphone = !isphone;
          //         isname =false;
          //         isemail=false;
          //       });
          //     }),
          // isphone ? ButtonContainer() : Container(),
          // TextSection(
          //     label: "EMAIL ADDRESS",
          //     onpressed: () {
          //       setState(() {
          //         isemail = !isemail;
          //         isname =false;
          //         isphone=false;
          //       });
          //     }),
          // isemail ? ButtonContainer() : Container(),
        ],
      ),
    ));
  }
}
