import 'package:crypto_education/views/base/custom_app_bar.dart';
import 'package:crypto_education/views/base/subscription_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubscriptionPlan extends StatelessWidget {
  const SubscriptionPlan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "subscription_plan".tr),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              spacing: 16,
              children: [
                const SizedBox(height: 8),
                SubscriptionWidget(
                  title: "basic".tr,
                  price: "price_basic".tr,
                  subTitle: "basic_description".tr,
                  pros: [
                    "ai_access".tr,
                    "telegram_group".tr,
                    "over_150_videos".tr,
                  ],
                ),
                SubscriptionWidget(
                  title: "pro".tr,
                  price: "price_pro".tr,
                  subTitle: "pro_description".tr,
                  pros: [
                    "everything_in_basic".tr,
                    "qa_live_calls".tr,
                    "trading_signals".tr,
                    "portfolio_analysis".tr,
                  ],
                  isPremium: true,
                ),
                SubscriptionWidget(
                  title: "elite".tr,
                  price: "price_elite".tr,
                  subTitle: "elite_description".tr,
                  pros: [
                    "everything_in_basic".tr,
                    "exclusive_masterclasses".tr,
                    "one_on_one_mentoring".tr,
                    "exclusive_events".tr,
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
