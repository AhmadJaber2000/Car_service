import 'package:Car_service/ui/User_cart/UserCart.dart';
import 'package:Car_service/ui/home/UserPage.dart';
import 'package:flutter/material.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: 10),
          Expanded(
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 70), //70
                  decoration: BoxDecoration(
                    color: Color(0xff1db954),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                ),
                ListView.builder(
                  itemCount: usercard.length,
                  itemBuilder: (context, index) => UserPage(
                    itemindex: index,
                    userCart: usercard[index],
                    press: () {
                      /* Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(
                            product: products[index],
                          ),
                        ),
                      );*/
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
