import 'package:flutter/material.dart';

class TabBarWidget extends StatelessWidget {
  final String title;
  final List<Tab> tabs;
  final List<Widget> children;

  const TabBarWidget({
    Key? key,
    required this.title,
    required this.tabs,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff006666),
            centerTitle: true,
            flexibleSpace: TabBar(
              isScrollable: false,
              indicatorColor: Colors.white,
              indicatorWeight: 5,
              tabs: tabs,
            ),
            elevation: 20,
          ),
          body: TabBarView(children: children),
        ),
      );
}
