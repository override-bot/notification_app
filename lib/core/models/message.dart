class Message {
  final String content;

  Message({this.content});

  factory Message.fromJson(Map data) {
    final json = Map<String, dynamic>.from(data);
    return Message(
      content: json['content'],
    );
  }
}
