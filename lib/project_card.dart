import 'package:flutter/material.dart';
import 'dart:math';

import 'package:url_launcher/url_launcher.dart';

import 'package:google_fonts/google_fonts.dart';

class ProjectCard extends StatefulWidget {
  // const ProjectCard({Key? key}) : super(key: key);
  ProjectCard({
    required this.imageName,
    required this.mainColor,
    required this.secondColor,
    required this.text,
    required this.description,
  });

  String imageName, text, description;
  Color mainColor, secondColor;

  @override
  _ProjectCardState createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool isBack = false;
  double angle = 0;

  void launchURL() async {
    if (!await launch(
        "https://play.google.com/store/apps/details?id=com.bahonika.timetable"))
      throw 'Could not launch';
  }

  void _flip() {
    setState(() {
      angle = (angle + pi) % (2 * pi);
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double cardWidth = screenWidth > 1360
        ? 309
        : screenWidth > 1000
            ? 260
            : screenWidth > 700
                ? 195
                : 260;

    double cardHeight = screenWidth > 1360
        ? 474
        : screenWidth > 1000
            ? 400
            : screenWidth > 700
                ? 300
                : 400;

    double textSize = screenWidth > 1360
        ? 40
        : screenWidth > 1000
            ? 30
            : screenWidth > 700
                ? 20
                : 40;
    double descriptionSize = textSize * 0.75;

    return GestureDetector(
      onTap: _flip,
      child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: angle),
          duration: const Duration(seconds: 1),
          builder: (BuildContext context, double val, __) {
            if (val >= (pi / 2)) {
              isBack = false;
            } else {
              isBack = true;
            }

            List<Color> colors = [widget.mainColor, widget.secondColor];

            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(val),
              child: Container(
                  width: cardWidth,
                  height: cardHeight,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: isBack
                      ? true
                          ? Stack(children: [
                              ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                child: ShaderMask(
                                  shaderCallback: (bounds) => LinearGradient(
                                          colors: colors,
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter)
                                      .createShader(bounds),
                                  blendMode: BlendMode.srcOver,
                                  child: Container(
                                    width: cardWidth,
                                    height: cardHeight,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Container(
                                    padding: const EdgeInsets.all(40),
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                      "assets/" + widget.imageName,
                                    )),
                              ),
                            ])
                          : const SizedBox.shrink()
                      : Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()..rotateY(pi),
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: widget.mainColor,
                            ),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(widget.text,
                                      style: GoogleFonts.josefinSlab(
                                        textStyle: TextStyle(
                                            fontSize: textSize,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),
                                // const SizedBox(
                                //   height: 40,
                                // ),
                                Align(
                                  alignment: Alignment(-1, -0.6),
                                  child: Text(widget.description,
                                      style: GoogleFonts.josefinSlab(
                                        textStyle: TextStyle(
                                            fontSize: descriptionSize,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      )),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    width: cardWidth * 0.5,
                                    height: cardHeight * 0.1,
                                    child: ElevatedButton(
                                        onPressed: () => launchURL(),
                                        style: ElevatedButton.styleFrom(
                                          primary: Color.lerp(widget.mainColor,
                                              Colors.black, 0.5),
                                          onPrimary: widget.mainColor,
                                          elevation: 0,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Check It!",
                                            style: TextStyle(
                                                fontSize: descriptionSize,
                                                color: widget.mainColor),
                                          ),
                                        )),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )),
            );
          }),
    );
  }
}
