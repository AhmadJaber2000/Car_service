import 'package:Car_service/ui/User_cart/UserCart.dart';
import 'package:Car_service/ui/User_cart/UserFunctionScreens/EditProfile.dart';
import 'package:Car_service/ui/User_cart/UserFunctionScreens/LocationSelector.dart';
import 'package:flutter/material.dart';
import 'WinchHome/CallWinch.dart';
import 'MechanicHome/CallMechanic/CallMechanic.dart';

class UserPage extends StatelessWidget {
  UserPage({
    Key? key,
    required this.itemindex,
    required this.userCart,
    required this.press,
  }) : super(key: key);
  int itemindex;
  final UserCart userCart;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      height: 190,
      child: InkWell(
        onTap: () {
          itemindex = userCart.index;
          if (itemindex == 1) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfile(),
                ));
          } else if (itemindex == 2) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CallMechanic()));
          } else if (itemindex == 3) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CallWinch()));
          } else if (itemindex == 4) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LocationSelector()));
          }
        },
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: Colors.white,
              ),
            ),
            Positioned(
              left: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 160,
                width: 250,
                child: Image.asset(
                  userCart.image,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: -100,
              child: SizedBox(
                height: 136,
                width: size.width,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        userCart.title,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Spare Part',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
