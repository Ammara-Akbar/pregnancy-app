import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class _ChatMessage {
  const _ChatMessage({required this.fromUser, required this.text});

  final bool fromUser;
  final String text;
}

class PregnantAiAssistantScreen extends StatefulWidget {
  const PregnantAiAssistantScreen({super.key});

  @override
  State<PregnantAiAssistantScreen> createState() =>
      _PregnantAiAssistantScreenState();
}

class _PregnantAiAssistantScreenState extends State<PregnantAiAssistantScreen> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  bool _showMoreSuggestions = false;

  final List<_ChatMessage> _messages = [
    const _ChatMessage(
      fromUser: true,
      text: 'I have lower back pain at 28 weeks. What can help?',
    ),
    const _ChatMessage(
      fromUser: false,
      text:
          'Lower back pain is common in later pregnancy. These usually help:\n\n'
          '• Try gentle cat-cow stretches or a short walk\n'
          '• Use a pregnancy pillow and rest on your side\n'
          '• Apply a warm (not hot) compress for 10–15 minutes\n'
          '• Avoid heavy lifting and long standing\n\n'
          'Contact your doctor if pain is severe, sudden, or comes with '
          'bleeding, fever or contractions. You\'re doing great.',
    ),
  ];

  static const _suggestions = [
    'Is it safe to drink coffee during pregnancy?',
    'How many glasses of water should I drink daily?',
    'When should I start counting baby kicks?',
    'What foods help with iron levels?',
    'Can I sleep on my back in the second trimester?',
    'What exercises are safe in the third trimester?',
  ];

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _send([String? preset]) {
    final text = (preset ?? _controller.text).trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(_ChatMessage(fromUser: true, text: text));
      _messages.add(_ChatMessage(fromUser: false, text: _replyFor(text)));
      _controller.clear();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOut,
      );
    });
  }

  String _replyFor(String question) {
    final q = question.toLowerCase();
    if (q.contains('coffee') || q.contains('caffeine')) {
      return 'Most guidelines suggest keeping caffeine under about 200 mg a day '
          '(roughly one 12 oz coffee). Prefer smaller cups, and check with your '
          'clinician if you have specific risks.';
    }
    if (q.contains('water')) {
      return 'Aim for about 8–10 glasses a day, and a little more in heat or '
          'after exercise. Pale yellow urine is a simple hydration check.';
    }
    if (q.contains('kick')) {
      return 'Many moms start noticing clearer patterns from around week 28. '
          'Learn your baby\'s usual rhythm and contact maternity care if '
          'movements reduce or change.';
    }
    if (q.contains('iron')) {
      return 'Iron-rich options include lentils, spinach, lean meat, dates and '
          'fortified cereals. Pair them with vitamin C foods to help absorption.';
    }
    if (q.contains('sleep') || q.contains('back')) {
      return 'Side sleeping is usually more comfortable after the first '
          'trimester. Use pillows under your bump and between your knees for '
          'support.';
    }
    return 'Thanks for asking. I can share general pregnancy guidance, but I\'m '
        'not a doctor. For personal medical advice, please check with your '
        'clinician. Would you like tips on diet, symptoms, movement or baby '
        'care?';
  }

  @override
  Widget build(BuildContext context) {
    final visibleSuggestions = _showMoreSuggestions
        ? _suggestions
        : _suggestions.take(4).toList();

    return Scaffold(
      backgroundColor: AppColors.softPink,
      appBar: AppBar(
        backgroundColor: AppColors.softPink,
        elevation: 0,
        foregroundColor: AppColors.burgundy,
        title: const Column(
          children: [
            Text(
              'AI Assistant',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
            ),
            Text(
              'Your personal pregnancy companion',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: AppColors.textMuted,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.history_rounded)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              controller: _scrollController,
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: AppColors.mistPink),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.asset(
                          'assets/images/sehat_ai_robot.png',
                          width: 52,
                          height: 52,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Hi, I\'m Sehat AI. Ask me anything about pregnancy, '
                          'baby care, symptoms, diet and more. I\'m here to help you!',
                          style: TextStyle(
                            fontSize: 13,
                            height: 1.4,
                            fontWeight: FontWeight.w600,
                            color: AppColors.burgundy,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  'Suggested questions',
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 8),
                for (final suggestion in visibleSuggestions) ...[
                  InkWell(
                    onTap: () => _send(suggestion),
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.ringPink),
                      ),
                      child: Text(
                        suggestion,
                        style: const TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: AppColors.burgundy,
                        ),
                      ),
                    ),
                  ),
                ],
                TextButton(
                  onPressed: () => setState(
                    () => _showMoreSuggestions = !_showMoreSuggestions,
                  ),
                  child: Text(
                    _showMoreSuggestions
                        ? 'Show fewer suggestions'
                        : 'View More Suggestions',
                    style: const TextStyle(
                      color: AppColors.magenta,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                for (final message in _messages) ...[
                  _ChatBubble(message: message),
                  const SizedBox(height: 10),
                ],
              ],
            ),
          ),
          SafeArea(
            top: false,
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
              decoration: const BoxDecoration(
                color: AppColors.white,
                border: Border(top: BorderSide(color: AppColors.mistPink)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _send(),
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                        filled: true,
                        fillColor: AppColors.softPink,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Material(
                    color: AppColors.magenta,
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: _send,
                      child: const Padding(
                        padding: EdgeInsets.all(12),
                        child: Icon(
                          Icons.send_rounded,
                          color: AppColors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  const _ChatBubble({required this.message});

  final _ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final isUser = message.fromUser;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: isUser
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        if (!isUser) ...[
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/images/sehat_ai_robot.png',
              width: 32,
              height: 32,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 8),
        ],
        Flexible(
          child: Column(
            crossAxisAlignment: isUser
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Text(
                isUser ? 'You' : 'Sehat AI',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: isUser ? AppColors.blush : AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(16),
                    topRight: const Radius.circular(16),
                    bottomLeft: Radius.circular(isUser ? 16 : 4),
                    bottomRight: Radius.circular(isUser ? 4 : 16),
                  ),
                  border: Border.all(color: AppColors.mistPink),
                ),
                child: Text(
                  message.text,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.45,
                    color: AppColors.textDark,
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
