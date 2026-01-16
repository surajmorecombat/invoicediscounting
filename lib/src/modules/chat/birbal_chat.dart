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
    ChatMessage(
      text:
          'Your total active investment is ₹12,50,000 across 8 invoices.\n\nOut of this, ₹9,20,000 is currently earning returns and ₹3,30,000 is awaiting maturity.',
      type: MessageType.bot,
    ),
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
      messages.add(ChatMessage(text: text, type: MessageType.user));
    });
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width >= 600;

    return MainLayout(
      backgroundColor: backgroundColor,
      ctx: 3,
      appBar: AppBar(
        title: Text(
          'Birbalplus AI assistant',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        elevation: 0,
        backgroundColor: backgroundColor,
        iconTheme: IconThemeData(color: blackColor),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: isTablet ? 120 : 20),
        child: Column(
          children: [
            _suggestionChips(context),
            Expanded(child: _chatList()),
            _inputBar(),
          ],
        ),
      ),
    );
  }

Widget _suggestionChips(BuildContext context) {
  return LayoutBuilder(
    builder: (context, constraints) {
      final itemWidth = (constraints.maxWidth - 12) / 2;

      return Column(
        children: [
          Row(children: [
            Image.asset('assets/icons/chat-dark.png',width: 24,height: 24,),Text('Your on-demand investment query assistant')
          ],),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: suggestions.map((text) {
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
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      );
    },
  );
}


  Widget _chatList() {
    return ListView.builder(
      //  padding: const EdgeInsets.all(16),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final msg = messages[index];
        final isUser = msg.type == MessageType.user;
        return Align(
          alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.all(14),
            constraints: const BoxConstraints(maxWidth: 280),
            decoration: BoxDecoration(
              color: isUser ? Colors.blue : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              msg.text,
              style: TextStyle(
                fontSize: 13,
                color: isUser ? Colors.white : Colors.black87,
                height: 1.4,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _inputBar() {
    return SafeArea(
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
    );
  }
}
