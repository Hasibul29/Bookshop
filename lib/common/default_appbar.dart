import 'package:flutter/material.dart';

import 'default_text.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onPressed;
  final Icon? icon;
  final bool hasActionButton;
  const DefaultAppBar({
    super.key,
    required this.title,
    this.onPressed,
    this.icon,
    this.hasActionButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: DefaultText(
        text: title,
        fontWeight: FontWeight.w700,
        fontSize: 18,
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_rounded),
        onPressed: () => Navigator.pop(context),
      ),
      actions: hasActionButton
          ? [
              IconButton(
                  onPressed: onPressed,
                  icon: icon ?? const Icon(Icons.logo_dev)),
              const SizedBox(width: 20),
            ]
          : [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
