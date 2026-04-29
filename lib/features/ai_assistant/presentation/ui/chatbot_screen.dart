import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cortexia/core/widgets/custom_form_field.dart';
import 'package:cortexia/core/widgets/custom_app_bar.dart';
import 'package:cortexia/core/di/dependency_injection.dart';
import 'package:cortexia/features/ai_assistant/presentation/controllers/ai_assistant_cubit.dart';
import 'package:cortexia/features/ai_assistant/data/models/chat_message.dart';
import 'package:intl/intl.dart';

class ChatbotScreen extends StatefulWidget {
  final String patientName;
  final String admissionId;
  final String? projectId; // optional for now

  const ChatbotScreen({
    super.key,
    required this.patientName,
    required this.admissionId,
    this.projectId,
  });

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  final List<ChatMessage> _messages = [
    ChatMessage(
      text: "Hi, you can ask me anything about patient health or records.",
      isUser: false,
    )
  ];

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage(BuildContext context) {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true));
    });
    _textController.clear();
    _scrollToBottom();

    context.read<AiAssistantCubit>().askRag(
          projectId: "1",
          admissionId: widget.admissionId,
          text: text,
          limit: 10,
        );
  }

  String _formatDateTime(String? dateTimeStr) {
    if (dateTimeStr == null) return '';
    try {
      final dateTime = DateTime.parse(dateTimeStr);
      return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
    } catch (e) {
      return dateTimeStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<AiAssistantCubit>(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: "Chatbot AI",
          subtitle: widget.patientName,
        ),
        body: BlocConsumer<AiAssistantCubit, AiAssistantState>(
          listener: (context, state) {
            if (state is AiAssistantStateSuccess) {
              setState(() {
                _messages.add(
                  ChatMessage(
                    text: state.data.generatedResponse ?? "No response",
                    isUser: false,
                    sources: state.data.sources,
                    queryDateTime: state.data.queryDateTime,
                  ),
                );
              });
              _scrollToBottom();
            } else if (state is AiAssistantStateError) {
              setState(() {
                _messages.add(
                  ChatMessage(
                    text: "Error: ${state.message}",
                    isUser: false,
                  ),
                );
              });
              _scrollToBottom();
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    itemCount: _messages.length + (state is AiAssistantStateLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == _messages.length) {
                        return _buildLoadingBubble();
                      }
                      return _buildMessageBubble(_messages[index]);
                    },
                  ),
                ),
                _buildChatInput(context),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildLoadingBubble() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(15),
        ),
        child: const SizedBox(
          height: 20,
          width: 40,
          child: Center(
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    bool isUser = message.isUser;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        decoration: BoxDecoration(
          color: isUser ? const Color(0xFF0052CC) : const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(15),
            topRight: const Radius.circular(15),
            bottomLeft: Radius.circular(isUser ? 15 : 0),
            bottomRight: Radius.circular(isUser ? 0 : 15),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isUser && message.text.contains("Hi, you can ask")) ...[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.auto_awesome, color: Colors.blue, size: 20),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      message.text,
                      style: const TextStyle(
                        color: Color(0xFF475569),
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ] else ...[
              Text(
                message.text,
                style: TextStyle(
                  color: isUser ? Colors.white : const Color(0xFF475569),
                  fontSize: 15,
                ),
              ),
              if (!isUser && message.sources != null && message.sources!.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  "Sources: ${message.sources!.join(', ')}",
                  style: const TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
              if (!isUser && message.queryDateTime != null) ...[
                const SizedBox(height: 4),
                Text(
                  _formatDateTime(message.queryDateTime),
                  style: const TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 10,
                  ),
                ),
              ],
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildChatInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: CustomTextFormField(
                controller: _textController,
                hintText: "Type your question...",
                fillColor: const Color(0xFFF8FAFC),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.attach_file, color: Color(0xFF94A3B8), size: 20),
                  onPressed: () {
                    // Attachment logic
                  },
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
              color: Color(0xFF0052CC),
              shape: BoxShape.circle,
            ),
            child: BlocBuilder<AiAssistantCubit, AiAssistantState>(
              builder: (context, state) {
                return IconButton(
                  icon: const Icon(Icons.send, color: Colors.white, size: 22),
                  onPressed: state is AiAssistantStateLoading
                      ? null
                      : () => _sendMessage(context),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
