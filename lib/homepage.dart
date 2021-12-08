
import 'package:bahonika_s/content_view.dart';
import 'package:bahonika_s/custom_tab.dart';
import 'package:bahonika_s/custom_tab_bar.dart';
import 'package:bahonika_s/project_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'main.dart';

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
            padding: const EdgeInsets.all(40),
            child: Container(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/tt.png" ,
                )),
            width: 309,
            height: 474,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(0, 78, 125, 1.0),
                    Color.fromRGBO(151, 237, 237, 1.0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
          )
        )),
    ContentView(
        tab: CustomTab(
          title: "About",
        ),
        content: Center(
          child: Container(
            height: 100,
            width: 100,
            child: Text('t'),
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black,
                    Colors.white,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
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
          child: ProjectScreen(),
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
              isMobile = false;
              return desctopView();
            } else {
              isMobile = true;
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
                      onTap: () {
                        tabController.index = contentViews.indexOf(e);
                        scaffoldKey.currentState!.openDrawer();
                      }),
                ))
            .toList(),
      ),
    );
  }
}
