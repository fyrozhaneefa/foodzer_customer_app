import 'package:flutter/material.dart';

class LanelContainer extends StatelessWidget {
  const LanelContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child:

        Column(mainAxisAlignment: MainAxisAlignment.center,children:[
         Center(
          child: Container(
            color: Colors.grey[300],
            width: 500,
            height: 250,
            child:Padding(padding: EdgeInsets.only(top: 20), child:
            Column(children: [ Center(
              child: Container(
                height: 110,
                width: 110,
                decoration:
                    BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
                child: Center(
                  child: Icon(Icons.camera),
                ),
              ),
            ),
              OutlinedButton(onPressed: (){}, child:Text("Upload"))

          ],
            )),
        ),
      ),
    ]),),);
  }
}
