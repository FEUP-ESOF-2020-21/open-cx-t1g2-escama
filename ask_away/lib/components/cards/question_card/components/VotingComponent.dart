import 'package:ask_away/models/AppUser.dart';
import 'package:ask_away/models/Question.dart';
import 'package:ask_away/screens/main_screen/MainScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum VoteType {
  UP,
  DOWN
}

extension VoteValue on VoteType {
  static const values = {
    VoteType.UP: 1,
    VoteType.DOWN: -1,
  };

  int get value => values[this];
}

class VotingComponent extends StatefulWidget {
  int votes;
  Function callback;
  Question question;

  int getTotalVotes() {
    return votes;
  }

  void vote(VoteType voteType) {
    User user;
    String questionID = question.id;
    DocumentReference userRef = FirebaseFirestore.instance.collection('Users').doc(currentUser);

    FirebaseFirestore.instance.runTransaction(
      (transaction) {
        return userRef.get().then(
          (value) {
            user = User.fromData(value.data());
            DocumentReference docRef = FirebaseFirestore.instance.collection("Questions").doc(questionID);

            // User didn't have a vote in this question
            if (!user.votes.containsKey(questionID)) {
              docRef.update({"votes": FieldValue.increment(voteType.value)});
              question.votes += voteType.value;

              user.votes[questionID] = voteType.value;
              userRef.update({"votes": user.votes});
            }

            // User already had a vote of the same type
            else if (user.votes[questionID] == voteType.value) {
              docRef.update({"votes": FieldValue.increment(-voteType.value)});
              question.votes -= voteType.value;

              user.votes.remove(questionID);
              userRef.update({"votes": user.votes});
            }

            // User already had a vote of the opposite type
            else {
              docRef.update({"votes": FieldValue.increment(2 * voteType.value)});
              question.votes += 2 * voteType.value;

              user.votes[questionID] = voteType.value;
              userRef.update({"votes": user.votes});
            }

            callback();
          },
        );
      },
    );
  }

  VotingComponent(this.votes, this.callback, this.question);

  @override
  _VotingComponentState createState() => new _VotingComponentState();
}

class _VotingComponentState extends State<VotingComponent> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.keyboard_arrow_up),
          iconSize: 30,
          onPressed: () => setState(
            () {
              widget.vote(VoteType.UP);
              widget.callback();
            },
          ),
        ),
        Text(
          (widget.getTotalVotes()).toString(),
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        IconButton(
          icon: Icon(Icons.keyboard_arrow_down),
          iconSize: 30,
          onPressed: () => setState(
            () {
              widget.vote(VoteType.DOWN);
              widget.callback();
            },
          ),
        ),
      ],
    );
  }
}
