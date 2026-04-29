class ChatMessage {
  final String text;
  final bool isUser;
  final List<String>? sources;
  final String? queryDateTime;

  ChatMessage({
    required this.text,
    required this.isUser,
    this.sources,
    this.queryDateTime,
  });
}
