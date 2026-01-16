import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/mainlayout.dart';
import 'package:invoicediscounting/src/models/chat_model.dart';
import 'package:invoicediscounting/src/modules/activity/trainsation_all.dart';
import 'package:invoicediscounting/src/modules/profile/profile.dart';

class BirbalChat extends StatefulWidget {
  const BirbalChat({super.key});

  @override
  State<BirbalChat> createState() => _BirbalChatState();
}

class _BirbalChatState extends State<BirbalChat> {
  final TextEditingController controller = TextEditingController();
  final List<ChatMessage> messages = [
    // ChatMessage(
    //   text:
    //       'Your total active investment is ₹12,50,000 across 8 invoices.\n\nOut of this, ₹9,20,000 is currently earning returns and ₹3,30,000 is awaiting maturity.',
    //   type: MessageType.bot,
    // ),
  ];

  final List<String> suggestions = [
    "What is my current invested amount?",
    "Which invoices are maturing this week?",
    "What returns have I earned till date?",
    "Show my overdue invoices",
  ];

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      // USER message
      messages.add(ChatMessage(text: text, type: MessageType.user));

      // BOT reply (mock for now)
      messages.add(
        ChatMessage(text: _mockBotReply(text), type: MessageType.bot),
      );
    });

    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      backgroundColor: backgroundColor,
      // ctx: 3,
      appBar: AppBar(
        title: Text(
          'Birbalplus AI assistant',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        elevation: 0,
        backgroundColor: backgroundColor,
        iconTheme: IconThemeData(color: blackColor),
      ),
      bottomNavigationBar: _inputBar(),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: isTablet ? 120 : 20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 12),

              // Suggestions + Header
              // if (messages.length <= 1)
              _suggestionChips(context),

              const SizedBox(height: 16),

              // Chat messages (NOT scrollable itself)
              _chatList(),

              const SizedBox(height: 80), // space for input bar
            ],
          ),
        ),
      ),
    );
  }

  String _mockBotReply(String query) {
    if (query.contains('invested')) {
      return 'Your total active investment is ₹12,50,000 across 8 invoices.';
    }
    if (query.contains('maturing')) {
      return 'Two invoices worth ₹1,80,000 are maturing this week.';
    }
    return 'I’m here to help with your investment queries.';
  }

  Widget _suggestionChips(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = (constraints.maxWidth - 12) / 2;

        return Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),

                    // color: isUser ? onboardingTitleColor : Colors.grey.shade100,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: Image.asset(
                    'assets/icons/chat-dark.png',
                    width: 25,
                    height: 25,
                  ),
                ),

                SizedBox(width: 2),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),

                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Your on-demand investment query assistant',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),

            SizedBox(height: 5),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children:
                  suggestions.map((text) {
                    return GestureDetector(
                      onTap: () => sendMessage(text),
                      child: Container(
                        width: itemWidth,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Text(
                          text,
                          style: const TextStyle(fontSize: 13, height: 1.4),
                        ),
                      ),
                    );
                  }).toList(),
            ),

            SizedBox(height: 5),
          ],
        );
      },
    );
  }

  Widget _userAvatar() {
    return CircleAvatar(
      radius: 18,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: 17,
        backgroundImage: AssetImage('assets/icons/profile.png'),
      ),
    );
  }

  Widget _botAvatar() {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(12),
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Image.asset('assets/icons/chat-dark.png', width: 25, height: 25),
    );
  }

  Widget _chatList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final msg = messages[index];
        final isUser = msg.type == MessageType.user;

        return Align(
          alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
          child: Column(
            crossAxisAlignment:
                isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              // Avatar
              isUser
                  ? _userAvatar()
                  : _botAvatar(),

              // Bubble
              _messageBubble(msg, isUser),
            ],
          ),
        );
      },
    );
  }

  Widget _messageBubble(ChatMessage msg, bool isUser) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      constraints: const BoxConstraints(maxWidth: 280),
      decoration: BoxDecoration(
        color: isUser ? onboardingTitleColor : Colors.grey.shade100,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(isUser ? 12 : 0),
          topRight: Radius.circular(isUser ? 0 : 12),
          bottomLeft: const Radius.circular(12),
          bottomRight: const Radius.circular(12),
        ),
      ),
      child: Text(
        msg.text,
        style: TextStyle(
          fontSize: 13,
          color: isUser ? Colors.white : Colors.black87,
          height: 1.4,
        ),
      ),
    );
  }

  Widget _inputBar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: TextField(
          controller: controller,
          style: Theme.of(context).textTheme.bodyLarge,
          textInputAction: TextInputAction.send,
          onSubmitted: sendMessage,

          decoration: InputDecoration(
            fillColor: whiteColor,
            hintText: 'Type your query here...',
            hintStyle: Theme.of(context).textTheme.bodyMedium,

            suffixIcon: IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
              onPressed: () => sendMessage(controller.text),
              icon: Image.asset('assets/icons/send.png', width: 25, height: 25),
            ),

            suffixIconConstraints: const BoxConstraints(
              minWidth: 36,
              minHeight: 36,
            ),

            contentPadding: const EdgeInsets.symmetric(
              vertical: 18,
              horizontal: 12,
            ),

            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: greyFaintcolor),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: onboardingTitleColor, width: 1.6),
            ),
          ),
        ),
      ),
    );
  }
}
