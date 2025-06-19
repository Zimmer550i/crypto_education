import 'package:crypto_education/views/base/custom_app_bar.dart';
import 'package:crypto_education/views/base/subscription_widget.dart';
import 'package:flutter/material.dart';

class SubscriptionPlan extends StatelessWidget {
  const SubscriptionPlan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Subscription Plan"),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              spacing: 16,
              children: [
                const SizedBox(height: 8),
                SubscriptionWidget(
                  title: "Basic",
                  price: "\$56",
                  subTitle:
                      "Start your financial journey with guided videos, community access, and AI support—ideal for beginners building strong foundations.",
                  pros: [
                    "Access to the AI Agent",
                    "Access to Telegram group",
                    "Over 150 Videos",
                  ],
                ),
                SubscriptionWidget(
                  title: "Pro",
                  price: "\$199",
                  subTitle:
                      "Take action with expert-led live calls, real-time trading signals, and portfolio insights—perfect for hands-on learners and active investors.",
                  pros: [
                    "Everything in Basic",
                    "Q&A Live Calls",
                    "Trading Signals",
                    "Portfolio Analysis",
                  ],
                  isPremium: true,
                ),
                SubscriptionWidget(
                  title: "Elite",
                  price: "\$399",
                  subTitle:
                      "Unlock advanced learning with personal mentorship, exclusive events, and deep-dive masterclasses—built for serious investors.",
                  pros: [
                    "Everything in Pro",
                    "Exclusive Masterclasses",
                    "1:1 Mentoring",
                    "Exclusive Events",
                  ],
                  isPremium: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
