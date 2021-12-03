import 'dart:js';

import 'package:bahonika_s/content_view.dart';
import 'package:bahonika_s/custom_tab.dart';
import 'package:bahonika_s/custom_tab_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  late double screenHeight;
  late double screenWidth;
  late TabController tabController;

  List<ContentView> contentViews = [
    ContentView(
        tab: CustomTab(
          title: "Home",
        ),
        content: Center(
          child: Container(
            height: 100,
            width: 100,
            decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25.0),
                    bottomLeft: Radius.circular(25.0))),
          ),
        )),
    ContentView(
        tab: CustomTab(
          title: "About",
        ),
        content: Center(
          child: Container(
            height: 100,
            width: 100,
            decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25.0),
                    bottomLeft: Radius.circular(25.0))),
          ),
        )),
    ContentView(
        tab: CustomTab(
          title: "Projects",
        ),
        content: Center(
          child: Container(
            height: 100,
            width: 100,
            decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25.0),
                    bottomLeft: Radius.circular(25.0))),
          ),
        )),
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: contentViews.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();

    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    double topPadding = screenHeight * 0.05;

    return Scaffold(
        backgroundColor: Colors.grey[900],
        endDrawer: drawer(),
        key: scaffoldKey,
        body: Padding(
          padding: EdgeInsets.only(top: topPadding),
          child: LayoutBuilder(builder: (context, constraints) {
            if (constraints.maxWidth > 715) {
              return desctopView();
            } else {
              return mobileView();
            }
          }),
        ));
  }

  Widget desctopView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomTabBar(
            controller: tabController,
            tabs: contentViews.map((e) => e.tab).toList()),
        Container(
          height: screenHeight * 0.85,
          child: TabBarView(
            controller: tabController,
            children: contentViews.map((e) => e.content).toList(),
          ),
        )
      ],
    );
  }

  Widget mobileView() {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        width: screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () => scaffoldKey.currentState!.openEndDrawer(),
              icon: const Icon(Icons.menu_rounded),
              color: Colors.grey,
            ),
            Container(
              height: screenHeight * 0.85,
              child: TabBarView(
                controller: tabController,
                children: contentViews.map((e) => e.content).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget drawer() {
    return Drawer(
      child: ListView(
        children: contentViews
            .map((e) => Container(
                  child: ListTile(
                    title: Text(e.tab.title),
                    onTap: () => tabController.index = contentViews.indexOf(e),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
