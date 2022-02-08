import 'package:flutter/material.dart';

class GroceryProductDesc extends StatelessWidget {
  const GroceryProductDesc({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Monoprix',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 3,
        ),
        Text(
          'Grocery, Supermarket',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Icon(Icons.access_time),
            SizedBox(
              width: 5,
            ),
            Text('Within 30 mins'),
            SizedBox(
              width: 10,
            ),
          ],
        )
      ],
    );
  }
}
