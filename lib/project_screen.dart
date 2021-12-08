import 'dart:html';

import 'package:bahonika_s/project_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class ProjectScreen extends StatelessWidget {
  Widget Timetable = ProjectCard(
    imageName: "tt.png",
    topColor: Color.fromRGBO(0, 78, 125, 1.0),
    bottomColor: Color.fromRGBO(151, 237, 237, 1.0),
    text: "Timetable",
    description: "Schedule aggregator for Murmansk Arctic State University",
  );

  Widget UselessBlocks = ProjectCard(
    imageName: "ub.png",
    topColor: Color.fromRGBO(255, 148, 11, 1),
    bottomColor: Color.fromRGBO(151, 237, 237, 1.0),
    text: "Useless blocs",
    description: "Monologue - clicker game",
  );

  Widget PolarSun = ProjectCard(
    imageName: "ps.png",
    topColor: Color.fromRGBO(93, 145, 72, 1),
    bottomColor: Color.fromRGBO(151, 237, 237, 1.0),
    text: "Polar Sun",
    description: "Digital Herbarium of Murmansk Arctic State University",
  );

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 100,
                ),
                Timetable,
                SizedBox(
                  height: 100,
                ),
                UselessBlocks,
                SizedBox(
                  height: 100,
                ),
                PolarSun,
                SizedBox(
                  height: 100,
                ),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // verticalDirection: VerticalDirection.down,
              children: [
                Timetable,
                UselessBlocks,
                PolarSun,
              ],
            ),
    );
  }
}
