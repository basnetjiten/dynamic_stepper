import 'package:flutter/material.dart';

class BannerImageWidget extends StatelessWidget {
  const BannerImageWidget({
    required this.onDelete,
    required this.icon,
    required this.placeholderIcon,
    required this.showDeleteIcon,
    required this.onPlaceHolderTap,
    super.key,
  });

  final Widget icon;
  final Widget placeholderIcon;
  final bool showDeleteIcon;
  final void Function()? onDelete;
  final Function(BuildContext context) onPlaceHolderTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () => onPlaceHolderTap(context),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10), child: placeholderIcon),
        ),
        Visibility(
          visible: showDeleteIcon,
          child: Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: onDelete,
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white70,
                  border: Border.all(
                    color: Colors.red,
                  ),
                ),
                child: icon,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
