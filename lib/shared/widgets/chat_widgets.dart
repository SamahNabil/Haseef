import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';

enum ChatMessageType { user, assistant, analysis }

class ChatMessage {
  const ChatMessage({
    required this.id,
    required this.content,
    required this.type,
    required this.time,
    this.highlight,
  });

  final String id;
  final String content;
  final ChatMessageType type;
  final String time;
  final String? highlight;
}

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
  });

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isUser = message.type == ChatMessageType.user;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) _MessageHeader(type: message.type),
          if (!isUser) const SizedBox(height: AppSpacing.sm),
          Align(
            alignment: isUser ? Alignment.centerLeft : Alignment.centerRight,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.sizeOf(context).width * 0.78,
              ),
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: isUser
                    ? AppColors.primaryGreen
                    : AppColors.surfaceCard,
                borderRadius: BorderRadius.circular(16).copyWith(
                  bottomLeft: isUser ? const Radius.circular(4) : null,
                  bottomRight: isUser ? null : const Radius.circular(4),
                ),
                border: isUser
                    ? null
                    : Border.all(color: AppColors.surfaceCardBorder),
              ),
              child: _MessageContent(message: message, theme: theme),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
            child: Text(
              message.time,
              style: theme.textTheme.labelSmall?.copyWith(
                color: AppColors.textMuted,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageHeader extends StatelessWidget {
  const _MessageHeader({required this.type});

  final ChatMessageType type;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isAnalysis = type == ChatMessageType.analysis;

    return Row(
      children: [
        Icon(
          isAnalysis ? Icons.auto_awesome_rounded : Icons.smart_toy_outlined,
          size: 16,
          color: isAnalysis ? AppColors.accentOrange : AppColors.accentBlue,
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(
          isAnalysis ? 'تحليل الذكاء الاصطناعي' : 'حصيف AI',
          style: theme.textTheme.labelMedium?.copyWith(
            color: AppColors.textMuted,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _MessageContent extends StatelessWidget {
  const _MessageContent({
    required this.message,
    required this.theme,
  });

  final ChatMessage message;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    if (message.highlight == null) {
      return Text(
        message.content,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: message.type == ChatMessageType.user
              ? AppColors.buttonTextDark
              : AppColors.textPrimary,
          height: 1.6,
        ),
      );
    }

    final parts = message.content.split(message.highlight!);
    return RichText(
      text: TextSpan(
        style: theme.textTheme.bodyMedium?.copyWith(
          color: AppColors.textPrimary,
          height: 1.6,
        ),
        children: [
          TextSpan(text: parts[0]),
          TextSpan(
            text: message.highlight,
            style: const TextStyle(
              color: AppColors.accentOrange,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (parts.length > 1) TextSpan(text: parts[1]),
        ],
      ),
    );
  }
}

class SuggestionChip extends StatelessWidget {
  const SuggestionChip({
    super.key,
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surfaceCard,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm + 2,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.surfaceCardBorder),
          ),
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ),
    );
  }
}

class ChatInputBar extends StatelessWidget {
  const ChatInputBar({
    super.key,
    required this.controller,
    required this.onSend,
    this.onSuggestionTap,
  });

  final TextEditingController controller;
  final VoidCallback onSend;
  final ValueChanged<String>? onSuggestionTap;

  static const suggestions = [
    'حلل مصاريفي',
    'توقعات الادخار',
    'نصيحة استثمارية',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            itemCount: suggestions.length,
            separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
            itemBuilder: (context, index) {
              return SuggestionChip(
                label: suggestions[index],
                onTap: () => onSuggestionTap?.call(suggestions[index]),
              );
            },
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            0,
            AppSpacing.md,
            AppSpacing.md,
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.mic_none_rounded,
                  color: AppColors.textPrimary,
                ),
              ),
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'اسأل حصيف...',
                    hintStyle: TextStyle(color: AppColors.textMuted),
                    filled: true,
                    fillColor: AppColors.surfaceCard,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: AppSpacing.md,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Material(
                color: AppColors.primaryGreen,
                borderRadius: BorderRadius.circular(24),
                child: InkWell(
                  onTap: onSend,
                  borderRadius: BorderRadius.circular(24),
                  child: const SizedBox(
                    width: 48,
                    height: 48,
                    child: Icon(
                      Icons.send_rounded,
                      color: AppColors.buttonTextDark,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
