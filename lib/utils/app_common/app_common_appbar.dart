import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:power_washer/utils/app_colors.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final Color iconColor;
  final TextStyle? titleStyle;
  final VoidCallback? onBackTap;
  final VoidCallback? onActionTap;
  final FaIcon? faIcon;
  final IconData? iconData;

  const CommonAppBar({
    Key? key,
    required this.title,
    this.backgroundColor = AppColors.kWhite,
    this.iconColor = Colors.black,
    this.titleStyle,
    this.onBackTap,
    this.onActionTap,
    this.faIcon,
    this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(

      backgroundColor: backgroundColor,
      elevation: 0,
      leading:  iconData == null ?GestureDetector(
        onTap: onBackTap ?? () => Navigator.pop(context),
        child: Icon(
          iconData,
          color: iconColor,
        ),
      ):null,
      centerTitle: true,
      title: Text(
        title.toUpperCase(),
        style: titleStyle ??
            TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 18,
              color: iconColor,
            ),
      ),
      actions: faIcon != null
          ? [
        GestureDetector(
          onTap: onActionTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: faIcon,
          ),
        ),
      ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
