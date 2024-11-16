import 'package:flutter/material.dart';

class QuestionNavigationWidget extends StatefulWidget {
  @override
  _QuestionNavigationWidgetState createState() =>
      _QuestionNavigationWidgetState();
}

class _QuestionNavigationWidgetState extends State<QuestionNavigationWidget> {
  int _selectedQuestionIndex = -1; // Index of the currently selected question
  int _previousSelectedIndex =
      -1; // Index of the previously selected question, only one at a time

  final List<int> questions =
      List.generate(13, (index) => index + 1); // 1 to 13 questions

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(questions.length, (index) {
              bool isSelected = _selectedQuestionIndex == index;
              bool isPrevious = _previousSelectedIndex == index;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _previousSelectedIndex = _selectedQuestionIndex;
                    _selectedQuestionIndex = index;
                  });
                },
                child: Stack(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.green
                            : isPrevious
                                ? Colors.green.withOpacity(0.5)
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.green,
                        ),
                      ),
                      child: Text(
                        "${questions[index]}",
                        style: TextStyle(
                          color: isSelected || isPrevious
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (index == 1) // Add badge on question 2 (index 1)
                      Positioned(
                        top: -2,
                        right: -2,
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            "P",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (_selectedQuestionIndex > 0) {
                    setState(() {
                      _previousSelectedIndex = _selectedQuestionIndex;
                      _selectedQuestionIndex--;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Colors.grey),
                  ),
                ),
                child: Icon(Icons.arrow_back, color: Colors.grey),
              ),
              ElevatedButton(
                onPressed: () {
                  // Finish button action here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Colors.grey),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 40),
                ),
                child: Text(
                  "Finish",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_selectedQuestionIndex < questions.length - 1) {
                    setState(() {
                      _previousSelectedIndex = _selectedQuestionIndex;
                      _selectedQuestionIndex++;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Icon(Icons.arrow_forward),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Main app to demonstrate usage
void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text("Question Navigation")),
      body: Center(
        child: QuestionNavigationWidget(), // Using the widget
      ),
    ),
  ));
}
