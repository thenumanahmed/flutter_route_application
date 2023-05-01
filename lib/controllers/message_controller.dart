import 'package:get/get.dart';

enum MessageState { chat, message }

class MessageController extends GetxController {
  final messageState = MessageState.chat.obs;
}
