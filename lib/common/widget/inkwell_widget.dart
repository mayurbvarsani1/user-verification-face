

import 'package:flutter/material.dart';

class inkWell extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget? child;
  const inkWell({super.key,this.onTap,required this.child});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: child,
    );
  }
}
