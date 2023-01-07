import 'package:Car_service/RateThisApp/page/rate_comment_page.dart';
import 'package:Car_service/RateThisApp/page/rate_dialog_page.dart';
import 'package:Car_service/RateThisApp/page/rate_info_page.dart';
import 'package:Car_service/RateThisApp/page/rate_stars_page.dart';
import 'package:Car_service/RateThisApp/widget/rate_app_init_widget.dart';
import 'package:Car_service/RateThisApp/widget/tabbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rate_my_app/rate_my_app.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(RateThisApp());
}

class RateThisApp extends StatelessWidget {
  static final String title = 'Rate My App';

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Rate This App"),
          centerTitle: true,
          backgroundColor: Color(0xff006666),
        ),
        body: MaterialApp(
          title: title,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primarySwatch: Colors.indigo),
          home: RateAppInitWidget(
            builder: (rateMyApp) => HomePage(rateMyApp: rateMyApp),
          ),
        ),
      );
}

class HomePage extends StatefulWidget {
  final RateMyApp rateMyApp;

  const HomePage({
    Key? key,
    required this.rateMyApp,
  }) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) => TabBarWidget(
        title: RateThisApp.title,
        tabs: [
          Tab(icon: Icon(Icons.open_in_full), text: 'Dialog'),
          Tab(icon: Icon(Icons.rate_review), text: 'Comment'),
          // Tab(icon: Icon(Icons.star_rate_sharp), text: 'Stars'),
          // Tab(icon: Icon(Icons.info_outline_rounded), text: 'Info'),
        ],
        children: [
          RateDialogPage(rateMyApp: widget.rateMyApp),
          RateCommentPage(rateMyApp: widget.rateMyApp),
          // RateStarsPage(rateMyApp: widget.rateMyApp),
          // RateInfoPage(rateMyApp: widget.rateMyApp),
        ],
      );
}
