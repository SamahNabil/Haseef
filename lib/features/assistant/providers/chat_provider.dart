import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/widgets/chat_widgets.dart';

final chatMessagesProvider =
    NotifierProvider<ChatMessagesNotifier, List<ChatMessage>>(
  ChatMessagesNotifier.new,
);

class ChatMessagesNotifier extends Notifier<List<ChatMessage>> {
  @override
  List<ChatMessage> build() => _initialMessages;

  static const _initialMessages = [
    ChatMessage(
      id: '1',
      content:
          'مرحباً علياء، كيف يمكنني مساعدتك في قراراتك المالية اليوم؟ يمكنني تحليل نفقاتك أو تقديم نصيحة استثمارية مخصصة.',
      type: ChatMessageType.assistant,
      time: '١٠:٣٠ ص',
    ),
    ChatMessage(
      id: '2',
      content:
          'أريد الوصول إلى هدف ادخار ١٠٠,٠٠٠ ريال لشراء منزل خلال ٥ سنوات. هل هذا ممكن بناءً على دخلي الحالي؟',
      type: ChatMessageType.user,
      time: '١٠:٣٢ ص',
    ),
    ChatMessage(
      id: '3',
      content:
          'بناءً على متوسط دخلك الشهري (٢٢,٥٠٠ ريال) ومعدل صرفك الحالي، ستحتاجين إلى ادخار حوالي ١,٦٦٧ ريال شهرياً. حالياً، أنت تدخرين ٨٠٠ ريال فقط. هل ترغبين في استعراض فئات الصرف التي يمكن تقليلها لتحقيق هدفك؟',
      type: ChatMessageType.analysis,
      time: '١:٣٣ ص',
      highlight: '١,٦٦٧ ريال',
    ),
  ];

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;

    state = [
      ...state,
      ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        content: text.trim(),
        type: ChatMessageType.user,
        time: 'الآن',
      ),
    ];
  }

  void applySuggestion(String suggestion) {
    sendMessage(suggestion);
  }
}
