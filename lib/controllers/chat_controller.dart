import 'dart:convert';
import 'package:crypto_education/controllers/localization_controller.dart';
import 'package:crypto_education/models/chat_model.dart';
import 'package:crypto_education/models/message_model.dart';
import 'package:crypto_education/services/api_service.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final api = ApiService();

  RxMap<String, RxList<MessageModel>> messageBuffer = RxMap();
  RxList<ChatModel> globalSessions = RxList.empty();
  Rxn<ChatModel> currentGlobalSession = Rxn();
  RxnString currentVideoSession = RxnString();
  RxBool isLoading = RxBool(false);
  RxBool fetchingChat = RxBool(false);
  RxBool aiReplying = RxBool(false);

  Future<String> getGlobalSession() async {
    isLoading(true);
    try {
      final response = await api.get(
        "/api/v1/ai/global_session/",
        authReq: true,
      );
      var body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        List<ChatModel> temp = [];

        for (var j in body.keys) {
          for (var i in body[j]) {
            temp.add(ChatModel.fromJson(i));
          }
        }

        globalSessions.value = temp;

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

  Future<String> getGlobalMessages() async {
    fetchingChat(true);
    try {
      if (currentGlobalSession.value == null) {
        await createGlobalChat();
      }
      final String sessionId = currentGlobalSession.value!.objectId;

      if (messageBuffer.containsKey(sessionId)) {
        return "success";
      }

      final response = await api.get(
        "/api/v1/ai/session_messages/$sessionId/",
        authReq: true,
      );
      var body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        List<MessageModel> temp = [];
        for (var i in body) {
          temp.add(MessageModel.fromJson(i));
        }

        messageBuffer[sessionId] = RxList.from(temp);

        return "success";
      } else {
        return body['message'] ?? "Connection Error";
      }
    } catch (e) {
      return "Unexpected error: ${e.toString()}";
    } finally {
      fetchingChat(false);
    }
  }

  Future<String> createGlobalChat() async {
    fetchingChat(true);
    try {
      final response = await api.post(
        "/api/v1/ai/create_session/",
        {},
        authReq: true,
      );
      var body = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final chat = ChatModel.fromJson(body);
        globalSessions.add(chat);
        currentGlobalSession.value = chat;

        return "success";
      } else {
        return body['message'] ?? "Connection Error";
      }
    } catch (e) {
      return "Unexpected error: ${e.toString()}";
    } finally {
      fetchingChat(false);
    }
  }

  Future<String> createVideoChat() async {
    fetchingChat(true);
    try {
      final response = await api.post(
        "/api/v1/ai/create_video_chat_session/",
        {},
        authReq: true,
      );
      var body = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        currentVideoSession.value = body['session_id'];

        return "success";
      } else {
        return body['message'] ?? "Connection Error";
      }
    } catch (e) {
      return "Unexpected error: ${e.toString()}";
    } finally {
      fetchingChat(false);
    }
  }

  Future<String> sendGlobalMessage(String message) async {
    aiReplying(true);
    try {
      String sessionId = currentGlobalSession.value!.objectId;
      addMessage(
        sessionId,
        MessageModel(
          content: message,
          role: "user",
          objectId: "does_not_exists",
          timestamp: DateTime.timestamp().toString(),
          sessionId: sessionId,
        ),
      );
      String language;
      if (Get.find<LocalizationController>().locale.languageCode == "de") {
        language = "German";
      } else {
        language = "English";
      }
      final response = await api.post(
        "/api/v1/ai/ask_global_question/",
        {"question": message.trim(), "session_id": sessionId},
        queryParams: {"language": language},
        authReq: true,
      );
      var body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        addMessage(sessionId, MessageModel.fromJson(body));

        return "success";
      } else {
        return body['message'] ?? "Connection Error";
      }
    } catch (e) {
      return "Unexpected error: ${e.toString()}";
    } finally {
      aiReplying(false);
    }
  }

  Future<String> sendVideoMessage(String id, String message) async {
    aiReplying(true);
    try {
      String sessionId = currentVideoSession.value!;
      addMessage(
        sessionId,
        MessageModel(
          content: message,
          role: "user",
          objectId: "does_not_exists",
          timestamp: DateTime.timestamp().toString(),
          sessionId: sessionId,
        ),
      );
      String language;
      if (Get.find<LocalizationController>().locale.languageCode == "de") {
        language = "German";
      } else if (Get.find<LocalizationController>().locale.languageCode ==
          "bn") {
        language = "Bangla";
      } else {
        language = "English";
      }
      final response = await api.post(
        "/api/v1/ai/ask_question_from_video/$id/",
        {"question": message.trim(), "session_id": sessionId},
        queryParams: {"language": language},
        authReq: true,
      );
      var body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        addMessage(
          sessionId,
          MessageModel(
            content: body["answer"],
            role: "bot",
            objectId: "",
            timestamp: DateTime.timestamp().toString(),
            sessionId: sessionId,
          ),
        );

        return "success";
      } else {
        return body['message'] ?? "Connection Error";
      }
    } catch (e) {
      return "Unexpected error: ${e.toString()}";
    } finally {
      aiReplying(false);
    }
  }

  Future<String> deleteGlobalSession(String id) async {
    isLoading(true);
    try {
      final response = await api.delete(
        "/api/v1/ai/rename_global_session/$id/",
        authReq: true,
      );
      // final body = jsonDecode(response.body);

      if (response.statusCode == 204) {
        globalSessions.removeWhere((val) {
          if (currentGlobalSession.value == val) {
            createGlobalChat();
          }
          return val.objectId == id;
        });

        return "Deleted successfully";
      } else {
        return "Could not be deleted";
      }
    } catch (e) {
      return "Unexpected error: ${e.toString()}";
    } finally {
      isLoading(false);
    }
  }

  Future<String> renameGlobalSession(String id, String name) async {
    isLoading(true);
    try {
      final response = await api.post("/api/v1/ai/rename_global_session/$id/", {
        "name": name,
      }, authReq: true);
      // final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final index = globalSessions.indexWhere((val) {
          return val.objectId == id;
        });

        globalSessions.elementAt(index).name = name;

        return "success";
      } else {
        return "Connection Error";
      }
    } catch (e) {
      return "Unexpected error: ${e.toString()}";
    } finally {
      isLoading(false);
    }
  }

  void addMessage(String sessionId, MessageModel message) {
    if (messageBuffer.containsKey(sessionId)) {
      messageBuffer[sessionId]!.add(message);
    } else {
      messageBuffer[sessionId] = RxList.from([message]);
    }
  }

  RxList<MessageModel> getMessages({
    ChatModel? chatModel,
    bool isVideo = false,
  }) {
    String? id = isVideo
        ? currentVideoSession.value
        : currentGlobalSession.value?.objectId;

    return messageBuffer[id ?? ""] ?? RxList.empty();
  }
}
