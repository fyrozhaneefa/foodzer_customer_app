import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/utils/helper.dart';

class PopularBrandCard extends StatelessWidget {
  final String logo,brandName,time;
  final press;
  const PopularBrandCard({
    Key? key,
    required this.logo,
    required this.brandName,
    required this.time,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      child: InkWell(
        onTap: press,
        child: Container(
          margin: EdgeInsets.only(bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: Helper.getScreenWidth(context) * 0.28,
                height: Helper.getScreenHeight(context) * 0.13,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border:
                    Border.all(width: 1.0, color: Colors.grey.shade200)),
                child: Image.network(
                  logo,
                  fit: BoxFit.contain,
                  repeat: ImageRepeat.noRepeat,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(

                width: Helper.getScreenWidth(context)*0.3,
                alignment: Alignment.topLeft,
                child: Text(
                  brandName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(

                  child: Text(time)
              )
            ],
          ),
        ),
      ),
    );
  }
}