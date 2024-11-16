import 'package:christiandimene/common_widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class TestPassesResultScreen extends StatefulWidget {
  const TestPassesResultScreen({super.key});

  @override
  State<TestPassesResultScreen> createState() => _TestPassesResultScreenState();
}

class _TestPassesResultScreenState extends State<TestPassesResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'practice: Managing Your Time Wisely',
        onCallBack: () {},
        leadingIconUnVisible: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(),
        ),
      ),
    );
  }
}
