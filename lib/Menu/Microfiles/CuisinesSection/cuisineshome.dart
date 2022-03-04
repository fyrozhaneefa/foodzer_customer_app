import 'package:flutter/material.dart';

import '../FiltterSection/applybutton.dart';
import 'cuisinesitems.dart';
import 'cuisinesheader.dart';

class Cuisines extends StatelessWidget {
  const Cuisines({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DraggableScrollableSheet(
          initialChildSize: 0.9,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          builder: (context, _) => Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Colors.white),
            child: Column(
              children: [
                Container(
                  height: 130,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      color: Colors.white),
                  child: Headersection(),
                ),
                Expanded(
                  child: CuisinesItems(),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(elevation: 0, child: ApplyButton()),
      backgroundColor: Colors.grey,
    );
  }

}
