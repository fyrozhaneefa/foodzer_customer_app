import 'package:flutter/material.dart';

class SpecialRequest extends StatefulWidget {
  const SpecialRequest({Key? key}) : super(key: key);

  @override
  _SpecialRequestState createState() => _SpecialRequestState();
}

class _SpecialRequestState extends State<SpecialRequest> {
  bool checkedValue=true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              'Special request',
              style:TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20
              )
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.brunch_dining,
                      color: Colors.grey.shade700,
                    ),
                    SizedBox(width: 15,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'No cutlery',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        SizedBox(height: 7,),
                        Text(
                          'Less plastic is the best plastic',
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                child: Checkbox(
                  checkColor: Colors.white,  // color of tick Mark
                  activeColor: Colors.deepOrange.shade700,
                  value: checkedValue,
                  onChanged: (newValue) {
                    setState(() {
                      checkedValue = newValue!;
                    });
                  },
                ),
              )
            ],
          ),
          Divider(height: 20,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.message_outlined,
                color: Colors.grey.shade700,
              ),
              SizedBox(width: 15,),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add a note',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    SizedBox(height: 7,),
                    TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.deepOrange,
                        hintText: "Anything else we need to know?",
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Divider()
        ],
      ),
    );
  }
}

