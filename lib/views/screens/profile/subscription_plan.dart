import 'package:crypto_education/controllers/user_controller.dart';
import 'package:crypto_education/utils/app_texts.dart';
import 'package:crypto_education/utils/custom_snackbar.dart';
import 'package:crypto_education/views/base/custom_app_bar.dart';
import 'package:crypto_education/views/base/custom_button.dart';
import 'package:crypto_education/views/base/subscription_widget.dart';
import 'package:crypto_education/views/screens/profile/info.dart';
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
  String? loading;

  @override
  void initState() {
    super.initState();

    if (!user.purchaseInitialized.value) {
      user.initPurchase();
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
                    makePayment("\$rc_monthly");
                  },
                  isLoading: loading == "\$rc_monthly",
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
                    makePayment("\$rc_annual");
                  },
                  isLoading: loading == "\$rc_annual",
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
                const SizedBox(height: 20),

                Text(
                  "apple_policy".tr,
                  style: AppTexts.tmdr,
                  textAlign: TextAlign.center,
                ),

                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        padding: 0,
                        onTap: () {
                          Get.to(
                            () => Info(
                              title: "privacy_policy".tr,
                              data: "privacy_policies",
                            ),
                          );
                        },
                        text: "privacy_policy".tr,
                        isSecondary: true,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: CustomButton(
                        padding: 0,
                        onTap: () {
                          Get.to(
                            () => Info(
                              title: "terms_of_service".tr,
                              data: "terms_conditions",
                            ),
                          );
                        },
                        text: "terms_of_service".tr,
                        isSecondary: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 0),
                CustomButton(
                  onTap: restorePurchases,
                  text: "Restore Purchases",
                  isLoading: loading == "restore",
                  trailing: "assets/icons/reload.svg",
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void restorePurchases() async {
    if (loading != null) {
      return;
    }
    setState(() {
      loading = "restore";
    });
    try {
      if (!user.purchaseInitialized.value) {
        await user.initPurchase();
      }
      // Call RevenueCat restore
      await Purchases.invalidateCustomerInfoCache();
      final restoredInfo = await Purchases.restorePurchases();
      await Purchases.invalidateCustomerInfoCache();

      if (restoredInfo.activeSubscriptions.isNotEmpty) {
        // Update user plan on backend
        if (user.userInfo.value!.subscription != "elite") {
          await user.updatePlan("free").then((message) {
            if (message == "success") {
              customSnackbar(
                "Restore Successful",
                "Your purchases have been restored.",
              );
            }
          });
        }
      } else {
        customSnackbar("No Purchases", "No previous purchases were found.");
      }
    } catch (e) {
      debugPrint(e.toString());
      customSnackbar("Error", "Failed to restore purchases. Please try again.");
    } finally {
      setState(() {
        loading = null;
      });
    }
  }

  void makePayment(String packageName) async {
    if (loading != null) {
      return;
    }
    setState(() {
      loading = packageName;
    });
    if (!user.purchaseInitialized.value) {
      await user.initPurchase();
    }
    try {
      final offerings = await Purchases.getOfferings();
      final offering = offerings.getOffering("Default");
      if (offering != null) {
        final package = offering.getPackage(packageName);
        if (package != null) {
          // ignore: deprecated_member_use
          await Purchases.purchasePackage(package);
          String planName;
          if (packageName == "\$rc_annual") {
            planName = "pro";
            await user.updatePlan(planName).then((message) {
              if (message == "success") {
                customSnackbar(
                  "Payment Successful",
                  "You have been Subscribed",
                );
              }
            });
          } else if (packageName == "\$rc_monthly") {
            planName = "basic";
            await user.updatePlan(planName).then((message) {
              if (message == "success") {
                customSnackbar(
                  "Payment Successful",
                  "You have been Subscribed",
                );
              }
            });
          }
        } else {
          customSnackbar("Error", "Something went wrong. Please try again.");
        }
      }
    } catch (e) {
      debugPrint(e.toString());
      customSnackbar("Error", "Something went wrong. Please try again.");
    } finally {
      setState(() {
        loading = null;
      });
    }
  }
}
