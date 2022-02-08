import 'package:flutter/material.dart';

class BasketItemsList extends StatefulWidget {
  const BasketItemsList({Key? key}) : super(key: key);

  @override
  _BasketItemsListState createState() => _BasketItemsListState();
}

class _BasketItemsListState extends State<BasketItemsList> {
  int _itemCount = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView.separated(
          separatorBuilder: (context, index) {
            return Divider();
          },
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Takis Blue Heat 113 Gram',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'QR 32.00',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            flex: 10,
                          ),
                          Container(
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () => setState(() =>
                                  _itemCount != 0
                                      ? _itemCount--
                                      : _itemCount),
                                  icon: Icon(
                                    Icons.remove,
                                    color: Colors.deepOrange,
                                    size: 20,
                                  ),
                                ),
                                Text(_itemCount.toString()),
                                IconButton(
                                  onPressed: () => setState(() {
                                    _itemCount++;
                                  }),
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.deepOrange,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  flex: 3,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                      height: 70,
                      width: 70,
                      child: Image.network(
                        'https://www.pngkey.com/png/full/876-8765821_takis-bag-fuego-takis-fuego.png',
                        fit: BoxFit.fill,
                      )),
                )
              ],
            );
          }),
    );
  }
}
