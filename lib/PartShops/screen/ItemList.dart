import 'package:Car_service/maps_comment/googlemap.dart';
import 'package:Car_service/tools/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/Item.dart';
import 'GetRatings.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemList extends StatelessWidget {
  final Item item;

  const ItemList({required this.item});
  // void luanchWhatsapp(String number, String message) async {
  //   String url = "whatsapp://send?phone=$number&text=$message}";
  //   await canLaunchUrl(url) ? launch(url) : print('Cant open whatsapp');
  // }
  _launchWhatsapp() async {
    var whatsapp = "+91XXXXXXXXXX";
    var whatsappAndroid =
        Uri.parse("whatsapp://send?phone=$whatsapp&text=hello");
    if (await canLaunchUrl(whatsappAndroid)) {
      await launchUrl(whatsappAndroid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Row(
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                item.imageUrl,
                height: 120.0,
                width: 120.0,
                fit: BoxFit.fitHeight,
              ),
              Flexible(
                //padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        item.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Color(0xFFD73C29),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        item.category,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 0.0),
                      GetRatings(),
                      SizedBox(height: 2.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                              style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Colors.green),
                              ),
                              onPressed: () {
                                String phone1 = "0792281812";
                                String phone2 = "0795530759";
                                String phone3 = "0797070243"; //مركز ابو
                                String phone4 = "0788724660";
                                if (item.id == 0) {
                                  launch('tel://$phone1');
                                } else if (item.id == 1) {
                                  launch('tel://$phone2');
                                } else if (item.id == 2) {
                                  launch('tel://$phone3');
                                } else if (item.id == 3) {
                                  launch('tel://$phone4');
                                }
                              },
                              child: Icon(Icons.call)),
                          SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Colors.white),
                              ),
                              onPressed: () async {
                                final Uri phone1 = Uri.parse("0792281812");
                                final Uri phone2 = Uri.parse("0795530759");
                                final Uri phone3 = Uri.parse("0797070243");
                                final Uri phone4 = Uri.parse("0788724660");
                                if (item.id == 0) {
                                  launchUrl(Uri.parse(
                                      "whatsapp://send?phone=$phone1&text=hello"));
                                } else if (item.id == 1) {
                                  launchUrl(Uri.parse(
                                      "whatsapp://send?phone=$phone2&text=hello"));
                                } else if (item.id == 2) {
                                  launchUrl(Uri.parse(
                                      "whatsapp://send?phone=$phone3&text=hello"));
                                } else if (item.id == 3) {
                                  launchUrl(Uri.parse(
                                      "whatsapp://send?phone=$phone4&text=hello"));
                                }
                              },
                              child: Icon(
                                Icons.whatsapp,
                                color: Colors.green,
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Colors.white),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MapSample(
                                              id: item.id,
                                            )));
                              },
                              child: Icon(
                                Icons.location_on,
                                color: Colors.red,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderContent extends StatelessWidget {
  final Item item;

  HeaderContent(this.item);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 10.0, top: 5.0, right: 10.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Color(0xFFD73C29),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    item.category,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 9.0,
                    ),
                  ),
                  GetRatings(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class MovieDesc extends StatelessWidget {
//   final Item item;
//
//   MovieDesc(this.item);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: <Widget>[
//           Container(
//             child: Column(
//               children: <Widget>[
//                 Text(
//                   'RELEASE DATE:',
//                   style: TextStyle(
//                     color: Colors.black38,
//                     fontSize: 9.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.only(left: 10.0, right: 10.0),
//             child: Column(
//               children: <Widget>[
//                 Text(
//                   'RUNTIME:',
//                   style: TextStyle(
//                     color: Colors.black38,
//                     fontSize: 9.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
