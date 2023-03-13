import 'dart:convert';

class ChatModel {
  int index;
  String text;
  ChatModel({
    required this.index,
    required this.text,
  });

  Map<String, dynamic> toMap() {
    return {
      'index': index,
      'text': text,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      index: map['index']?.toInt() ?? 0,
      text: map['text'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source));
}
