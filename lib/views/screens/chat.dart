import 'package:crypto_education/utils/app_colors.dart';
import 'package:crypto_education/utils/app_icons.dart';
import 'package:crypto_education/utils/app_texts.dart';
import 'package:crypto_education/utils/custom_svg.dart';
import 'package:crypto_education/views/base/profile_picture.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Chat extends StatefulWidget {
  final bool expanded;
  const Chat({super.key, this.expanded = true});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List<String> messages = [];
  final FocusNode _focusNode = FocusNode();

  void addMessages() {
    setState(() {
      messages = [
        "Lorem ipsum dolor sit amet consectetur. Mauris ut habitant nec imperdiet diam sodales scelerisque.",
        "Lorem ipsum dolor sit amet consectetur. A elit quis dignissim egestas quis. Scelerisque est donec faucibus purus rhoncus maecenas ut felis sit. Pharetra vel justo lectus gravida massa pharetra pellentesque. Viverra pulvinar hac eget ipsum risus. Diam ultrices ut at eget sed laoreet. Enim mattis donec posuere sed. Nunc amet sed laoreet laoreet.",
        // "Lorem ipsum dolor sit amet consectetur. Mauris ut habitant nec imperdiet diam sodales scelerisque.",
        // "Lorem ipsum dolor sit amet consectetur. A elit quis dignissim egestas quis. Scelerisque est donec faucibus purus rhoncus maecenas ut felis sit. Pharetra vel justo lectus gravida massa pharetra pellentesque. Viverra pulvinar hac eget ipsum risus. Diam ultrices ut at eget sed laoreet. Enim mattis donec posuere sed. Nunc amet sed laoreet laoreet.",
        // "Lorem ipsum dolor sit amet consectetur. Mauris ut habitant nec imperdiet diam sodales scelerisque.",
        // "Lorem ipsum dolor sit amet consectetur. A elit quis dignissim egestas quis. Scelerisque est donec faucibus purus rhoncus maecenas ut felis sit. Pharetra vel justo lectus gravida massa pharetra pellentesque. Viverra pulvinar hac eget ipsum risus. Diam ultrices ut at eget sed laoreet. Enim mattis donec posuere sed. Nunc amet sed laoreet laoreet.",
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        messages.isEmpty
            ? newChat()
            : MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    bool isSender = index % 2 == 0;
                    return Padding(
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 16,
                        bottom: index == messages.length - 1 ? 82 : 0,
                      ),
                      child: chatText(messages[index], isSender),
                    );
                  },
                ),
              ),
        inputField(),
      ],
    );
  }

  Widget chatText(String message, bool isSender, {bool isLoading = false}) {
    return Row(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: isSender
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        if (!isSender)
          ProfilePicture(image: "https://thispersondoesnotexist.com", size: 40),
        Flexible(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(
              color: isSender
                  ? AppColors.cyan.shade300
                  : AppColors.gray.shade800,
              borderRadius: isSender
                  ? BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    )
                  : BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
            ),
            child: isLoading
                ? TypingIndicator()
                : Text(
                    message,
                    style: AppTexts.txsr.copyWith(
                      color: isSender
                          ? AppColors.gray.shade800
                          : AppColors.gray.shade100,
                    ),
                  ),
          ),
        ),
        if (isSender)
          ProfilePicture(image: "https://thispersondoesnotexist.com", size: 40),
      ],
    );
  }

  Widget newChat() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.expanded
                ? "ask_me_anything".tr
                : "ask_video".tr,
            textAlign: TextAlign.center,
            style: AppTexts.tlgr.copyWith(color: AppColors.cyan.shade400),
          ),
          const SizedBox(height: 80),
          if (widget.expanded)
            Column(
              children: [
                suggesions("what_is_wallet".tr),
                const SizedBox(height: 12),
                suggesions("how_to_invest_in_crypto".tr),
                const SizedBox(height: 12),
                suggesions("is_crypto_legal_in_usa".tr),
                const SizedBox(height: 12),
              ],
            ),
        ],
      ),
    );
  }

  Positioned inputField() {
    return Positioned(
      bottom: 16,
      left: 20,
      right: 20,
      child: SafeArea(
        child: Container(
          width: double.infinity,
          height: 50,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.gray.shade800,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            children: [
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  focusNode: _focusNode,
                  cursorColor: AppColors.cyan.shade300,
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: "ask_questions".tr,
                    hintStyle: AppTexts.txsr.copyWith(
                      color: AppColors.gray.shade100,
                    ),
                  ),
                  onTapOutside: (event) {
                    _focusNode.unfocus();
                  },
                ),
              ),
              InkWell(
                onTap: () {
                  if (messages.isEmpty) {
                    addMessages();
                  } else {
                    setState(() {
                      messages.clear();
                    });
                  }
                },
                borderRadius: BorderRadius.circular(99),
                child: Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.gray.shade700,
                  ),
                  child: Center(child: CustomSvg(asset: AppIcons.arrowUp)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container suggesions(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.gray.shade800,
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(
        text,
        style: AppTexts.txss.copyWith(color: AppColors.gray.shade300),
      ),
    );
  }
}

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({super.key});

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> dotOneAnim;
  late Animation<double> dotTwoAnim;
  late Animation<double> dotThreeAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();

    dotOneAnim =
        TweenSequence([
          TweenSequenceItem(tween: Tween(begin: 0.0, end: 8.0), weight: 50),
          TweenSequenceItem(tween: Tween(begin: 8.0, end: 0.0), weight: 50),
        ]).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.0, 0.33, curve: Curves.easeInOut),
          ),
        );
    dotTwoAnim =
        TweenSequence([
          TweenSequenceItem(tween: Tween(begin: 0.0, end: 8.0), weight: 50),
          TweenSequenceItem(tween: Tween(begin: 8.0, end: 0.0), weight: 50),
        ]).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.33, 0.66, curve: Curves.easeInOut),
          ),
        );
    dotThreeAnim =
        TweenSequence([
          TweenSequenceItem(tween: Tween(begin: 0.0, end: 8.0), weight: 50),
          TweenSequenceItem(tween: Tween(begin: 8.0, end: 0.0), weight: 50),
        ]).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.66, 1.0, curve: Curves.easeInOut),
          ),
        );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget dot(Animation<double> animation) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) => Transform.translate(
          offset: Offset(0, -animation.value),
          child: child,
        ),
        child: const CircleAvatar(radius: 4, backgroundColor: Colors.white70),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [dot(dotOneAnim), dot(dotTwoAnim), dot(dotThreeAnim)],
    );
  }
}
