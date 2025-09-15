import 'dart:io';

import 'package:crypto_education/controllers/user_controller.dart';
import 'package:crypto_education/utils/custom_snackbar.dart';
import 'package:crypto_education/views/base/custom_app_bar.dart';
import 'package:crypto_education/views/base/subscription_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class SubscriptionPlan extends StatefulWidget {
  const SubscriptionPlan({super.key});

  @override
  State<SubscriptionPlan> createState() => _SubscriptionPlanState();
}

class _SubscriptionPlanState extends State<SubscriptionPlan> {
  final user = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    initPurchase();
  }

  void initPurchase() async {
    await Purchases.setLogLevel(LogLevel.debug);

    if (Platform.isAndroid) {
      await Purchases.configure(
        PurchasesConfiguration("goog_xmILfTdnQjSvLskLSoWPBlTgisW"),
      );
    } else if (Platform.isIOS) {
      await Purchases.configure(
        PurchasesConfiguration("PLACE APPLE API KEY HERE"),
      );
    }
  }

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
                  duration: "month".tr,
                  subTitle: "basic_description".tr,
                  pros: [
                    "feature_1".tr,
                    "feature_2".tr,
                    "feature_3".tr,
                    "feature_4".tr,
                    "feature_5".tr,
                    "feature_6".tr,
                    "feature_7".tr,
                  ],
                  isPurchased: user.userInfo.value!.subscription == "basic",
                  onTap: () async {
                    makePayment("Basic");
                  },
                ),
                SubscriptionWidget(
                  title: "pro".tr,
                  price: "price_pro".tr,
                  duration: "year".tr,
                  subTitle: "pro_description".tr,
                  pros: [
                    "everything_in_basic".tr,
                    "qa_live_calls".tr,
                    "trading_signals".tr,
                    "portfolio_analysis".tr,
                  ],
                  isPurchased: user.userInfo.value!.subscription == "pro",
                  isPremium: true,
                  onTap: () async {
                    makePayment("Pro");
                  },
                ),
                // SubscriptionWidget(
                //   title: "elite".tr,
                //   price: "price_elite".tr,
                //   duration: "single_payment".tr,
                //   subTitle: "elite_description".tr,
                //   pros: [
                //     "everything_in_basic".tr,
                //     "exclusive_masterclasses".tr,
                //     "one_on_one_mentoring".tr,
                //     "exclusive_events".tr,
                //   ],
                //   isPremium: true,
                // ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void makePayment(String packageName) async {
    try {
      final offerings = await Purchases.getOfferings();
      debugPrint(offerings.toString());
      final offering = offerings.getOffering("Default");
      debugPrint(offering.toString());
      if (offering != null) {
        final package = offering.getPackage(packageName);
        debugPrint(package.toString());

        if (package != null) {
          await Purchases.logIn(user.userInfo.value!.email);
          final appUserID = await Purchases.appUserID;
          debugPrint("Paid user: $appUserID");
          await Purchases.purchasePackage(package);

          user.getInfo().then((message) {
            if (message == "success" &&
                user.userInfo.value!.subscription == "success") {
              customSnackbar(
                "Payment Successful",
                "You have successfully purchased the $packageName Package",
              );
            }
          });
          // ignore: use_build_context_synchronously
          if (Navigator.canPop(context)) {
            Get.back();
          }
        }
      }
    } catch (e) {
      debugPrint(e.toString());
      customSnackbar("Error", "Something went wrong. Please try again.");
    }
  }
}
