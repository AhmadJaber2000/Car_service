import 'package:Car_service/ChatNew/screens/chat_screen.dart';
import 'package:Car_service/ChatNew/screens/home_screen.dart';
import 'package:Car_service/model/roleType.dart';
import 'package:Car_service/tools/constants.dart';
import 'package:Car_service/user/view/userMechanicPage.dart';
import 'package:Car_service/user/view/userTruckPage.dart';
import 'package:Car_service/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import '../../ChatIn/screens/home_screen.dart';
import '../../smarthome/Model/homeinfodata.dart';
import '../../smarthome/Model/homeinfomodel.dart';
import '../../smarthome/controlwidget/airconditionerControl.dart';
import '../../user/view/userNormalPage.dart';
import '../../user/view/drawer.dart';

class Home extends StatefulWidget {
  final String type;
  const Home({Key? key, required this.type}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  List<HomeInfoModel> homeInfoData = HomeInfoData().infoData;
  @override
  void initState() {
    _tabController =
        new TabController(length: homeInfoData.length, vsync: this);
  }

  late TabController _tabController;
  @override
  Widget build(BuildContext context) {
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
        backgroundColor: Colors.white,
        drawer: const DrawerView(),
        // appBar: (AppBar(
        //     brightness: Brightness.light,
        //     backgroundColor: primecolor,
        //     elevation: 0,
        //     title: Text(
        //       'Home',
        //       style: TextStyle(color: Colors.white),
        //     ),
        //     centerTitle: true,
        //     bottom: TabBar(
        //       indicator: UnderlineTabIndicator(
        //         borderSide: BorderSide(width: 3.0, color: Colors.white),
        //         insets:
        //             EdgeInsets.symmetric(horizontal: isPortrait ? 20.0 : 5.0),
        //       ),
        //       labelColor: Colors.white,
        //       labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        //       unselectedLabelColor: Colors.white,
        //       unselectedLabelStyle: TextStyle(fontSize: 16),
        //       isScrollable: true,
        //       controller: _tabController,
        //       tabs: tabTextWidget(homeInfoData, isPortrait),
        //     ))),
        body: widget.type == RoleType.customer
            ? const UserNormalPage()
            : widget.type == RoleType.mechanic
                ? const UserMechanicPage()
                : widget.type == RoleType.truck
                    ? const UserTruckPage()
                    : WelcomeScreen());
  }
}
