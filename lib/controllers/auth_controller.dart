import 'dart:convert';
import 'package:crypto_education/views/screens/auth/signin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crypto_education/controllers/user_controller.dart';
import 'package:crypto_education/services/api_service.dart';
import 'package:crypto_education/services/shared_prefs_service.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  RxBool isLoggedIn = RxBool(false);
  RxBool isLoading = RxBool(false);
  final api = ApiService();

  Future<String> googleLogin() async {
    isLoading(true);
    try {
      var signIn = GoogleSignIn();
      var signInAccount = await signIn.signIn();
      if (signInAccount != null) {
        final response = await api.post("/api/v1/auth/google_login/", {
          "email": signInAccount.email,
          "photoUrl": signInAccount.photoUrl,
          "name": signInAccount.displayName,
          "id": signInAccount.id,
        });
        var body = jsonDecode(response.body);

        if (response.statusCode == 200) {
          return "success";
        } else {
          return body['message'] ?? "Connection Error";
        }
      } else {
        return "Google Sign in failed.";
      }
    } catch (e) {
      return "Unexpected error: ${e.toString()}";
    } finally {
      isLoading(false);
    }
  }

  Future<String> login(
    String email,
    String password, {
    bool rememberMe = true,
  }) async {
    isLoading(true);
    try {
      final response = await api.post("/api/v1/auth/login/", {
        "email": email.trim(),
        "password": password.trim(),
      });
      var body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Get.find<UserController>().setInfo(body['data']);
        if (rememberMe) {
          setToken(body['access_token']);
        }

        return "success";
      } else {
        return body['message'] ?? "Connection Error";
      }
    } catch (e) {
      return "Unexpected error: ${e.toString()}";
    } finally {
      isLoading(false);
    }
  }

  Future<String> signup(
    String name,
    String email,
    String password,
    String confirmPassword,
  ) async {
    try {
      isLoading(true);
      final response = await api.post("/api/v1/auth/register/", {
        "full_name": name.trim(),
        "email": email.trim(),
        "password": password.trim(),
        "confirm_password": confirmPassword.trim(),
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        return "success";
      } else {
        return jsonDecode(response.body)['message'] ?? "Connection Error";
      }
    } catch (e) {
      return "Unexpected error: ${e.toString()}";
    } finally {
      isLoading(false);
    }
  }

  Future<String> sendOtp(String email) async {
    try {
      final response = await api.post("/api/v1/auth/send_otp/", {
        "email": email.trim(),
      });

      if (response.statusCode == 200) {
        return "success";
      } else {
        return jsonDecode(response.body)['message'] ?? "Connection Error";
      }
    } catch (e) {
      return "Unexpected error: ${e.toString()}";
    }
  }

  Future<String> verifyEmail(String email, String code) async {
    try {
      isLoading(true);
      final response = await api.post("/api/v1/auth/verify_email/", {
        "email": email.trim(),
        "otp": code.trim(),
      });
      var body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        setToken(body['access_token']);
        await Get.find<UserController>().getInfo();

        return "success";
      } else {
        return body['message'] ?? "Connection Error";
      }
    } catch (e) {
      return "Unexpected error: ${e.toString()}";
    } finally {
      isLoading(false);
    }
  }

  Future<String> resetPassword(String pass, String conPass) async {
    isLoading(true);
    try {
      final response = await api.post("/api/v1/auth/forgot_password/", {
        "new_password": pass.trim(),
        "confirm_password": conPass.trim(),
      }, authReq: true);
      var body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return "success";
      } else {
        return body['message'] ?? "Connection Error";
      }
    } catch (e) {
      return "Unexpected error: ${e.toString()}";
    } finally {
      isLoading(false);
    }
  }

  Future<bool> previouslyLoggedIn() async {
    String? token = await SharedPrefsService.get('token');
    if (token != null) {
      debugPrint('🔍 Token found. Fetching user info...');
      final message = await Get.find<UserController>().getInfo();
      if (message == "success") {
        debugPrint("🟡 Token: $token");
        isLoggedIn.value = true;
        return true;
      }
    }
    isLoggedIn.value = false;
    return false;
  }

  Future<void> logout() async {
    await SharedPrefsService.clear();
    Get.offAll(() => Signin());
    isLoggedIn.value = false;
  }

  Future<void> setToken(String value) async {
    await SharedPrefsService.set('token', value);
    debugPrint('💾 Token Saved: $value');
  }
}
