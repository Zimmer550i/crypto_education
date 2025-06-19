import 'package:crypto_education/views/base/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class Info extends StatefulWidget {
  final String title;
  final String data;
  const Info({super.key, required this.title, required this.data});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  String text = """
  <div style="font-family: Arial; font-size: 16px; color: #f1f1f1;">
    <h2 style="color: #00BFFF;">🌟 Welcome to Your blablabla Page!</h2>
    <p style="font-size: 18px;">
      This is just a <strong style="color: #FFD700;">beautiful placeholder</strong> 📝.<br />
      Once your app is still developing, you will be able to add your desired content right from the 
      <span style="color: #90EE90;">Admin Dashboard</span> 🎯.
    </p>
    <p style="font-style: italic; font-size: 16px; color: #cccccc;">
      Update anytime, anywhere — your words, your way ✨.
    </p>
    <ul style="margin-top: 20px; color: #ffffff;">
      <li>🔧 Dynamic text editing</li>
      <li>🎨 Customize the look and feel</li>
      <li>🚀 Push updates instantly</li>
    </ul>
    <p style="margin-top: 20px; font-size: 14px; color: #aaaaaa;">
      Powered by <span style="color: #FF69B4;">Wasiul</span>'s magic ✨
    </p>
  </div>
  """;

  @override
  void initState() {
    super.initState();
    text = text.replaceAll("blablabla", widget.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.title),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 24),
                Html(data: text),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
