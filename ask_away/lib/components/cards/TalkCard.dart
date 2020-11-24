import 'package:ask_away/components/SimpleButton.dart';
import 'package:ask_away/models/Talk.dart';
import 'package:ask_away/screens/talks_questions/TalkQuestionsScreen.dart';
import 'package:flutter/material.dart';

class TalkCard extends StatefulWidget {
  Talk talk;
  @override
  State<TalkCard> createState() => TalkCardState();

  TalkCard(this.talk);
}

class TalkCardState extends State<TalkCard> {
  bool displayText = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: (){this.setState(() {
            displayText = !displayText;
          });},
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(18)),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        this.widget.talk.title,
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      Icon(
                        Icons.bookmark_border,
                        size: 30,
                        color: Color(0xFFFF5656),
                      ),
                    ],
                  ),
                  AnimatedContainer(
                    height: displayText ? 0 : 100,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 20),
                      child: RichText(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                        text: TextSpan(
                            style: TextStyle(
                              color: Color(0xFF979797),
                              fontSize: 16,
                            ),
                            text:
                                this.widget.talk.description),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: Color(0xFFE11D1D),
                            ),
                            Text(
                              this.widget.talk.creator.username,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 5,
                              ),
                              child: Icon(
                                Icons.calendar_today,
                                color: Color(0xFFE11D1D),
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "6 hours",
                                    style: TextStyle(
                                      color: Color(0xFFFF5656),
                                      fontSize: 16,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " left",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SimpleButton(
                    "Enter Talk",
                    () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TalkQuestionsScreen(),
                        ),
                      );
                    },
                    20,
                    Color(0xFFC4C4C4)
                  ),
                ],
              ),

            ),

          ),
        ),
        SizedBox(height: 20,)

      ],
    );
  }
}