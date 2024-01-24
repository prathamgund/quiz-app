import 'package:flutter/material.dart';
import 'package:quiz/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

  int score = 0;

  void checkAnswer(bool userSelectedButton) {
    bool correctAnswer = quizBrain.getCorrectAnswer();
    setState(() {
      if (correctAnswer == userSelectedButton) {
        score++;
        scoreKeeper.add(const Icon(
          Icons.check,
          color: Colors.green,
        ));
      } else {
        scoreKeeper.add(const Icon(
          Icons.close,
          color: Colors.red,
        ));
      }
      if (quizBrain.isFinished() == true) {
        Alert(
                context: context,
                title: "Congrats!",
                desc:
                    "Your score is: $score out of ${quizBrain.getListLength()}.")
            .show();
        quizBrain.reset();
        scoreKeeper = [];
        score = 0;
      } else {
        quizBrain.nextQuestion();
      }
    });
  }

  QuizBrain quizBrain = QuizBrain();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
         Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.green),
                foregroundColor: MaterialStatePropertyAll(Colors.white),
              ),
               onPressed: () {
                checkAnswer(true);
              },
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.red),
                foregroundColor: MaterialStatePropertyAll(Colors.white),
              ),
              onPressed: () {
                checkAnswer(false);
              },
              child: const Text(
                'False',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
  }



//When cliked on a button:
//1. Check for correct answer.
//2. Add the icons.
//3. Check if quiz is finished, if not, Move to next Question.



//If quiz is finished:
//1. Alert and display score.
//2. Reset the Quiz.

//3. Remove the added icons.