import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:invoicediscounting/src/components/wallet_conrainer.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';
import 'package:invoicediscounting/src/modules/profile/profile.dart';

class InvestAppBar extends StatelessWidget implements PreferredSizeWidget {
  const InvestAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: backgroundColor,
      centerTitle: false,
      leadingWidth: 52,
      leading: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => Profile()),
            );
          },
          child: CircleAvatar(
            radius: 34,
            child: Image.asset('assets/icons/profile.png'),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: WalletButton(),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: SvgPicture.asset(
            'assets/icons/bell.svg',
            width: 20,
            height: 20,
          ),
        ),
      ],
    );
  }
}



