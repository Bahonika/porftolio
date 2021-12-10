import 'package:bahonika_s/project_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class ProjectScreen extends StatelessWidget {
  Widget Timetable = ProjectCard(
    imageName: "tt.png",
    mainColor: const Color.fromARGB(255, 0, 78, 125),
    secondColor: const Color.fromARGB(255, 151, 237, 237),
    text: "Timetable",
    description: "Schedule aggregator for Murmansk Arctic State University",
  );

  Widget UselessBlocks = ProjectCard(
    imageName: "ub.png",
    mainColor: const Color.fromARGB(255, 255, 148, 11),
    secondColor: const Color.fromARGB(255, 151, 237, 237),
    text: "Useless blocs",
    description: "Monologue - clicker game",
  );

  Widget PolarSun = ProjectCard(
    imageName: "ps.png",
    mainColor: const Color.fromARGB(255, 93, 145, 72),
    secondColor: const Color.fromARGB(255, 151, 237, 237),
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
