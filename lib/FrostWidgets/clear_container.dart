import 'dart:ui';
import 'package:flutter/material.dart';

clearContainer(Widget child) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(15),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 2, 0, 0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.12),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(
            width: 2,
            color: Colors.white.withOpacity(0.05),
          ),
        ),
        child: child,
      ),
    ),
  );
}

clearContainerRect(Widget child0) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(15),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 2, 0, 0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(
            width: 2,
            color: Colors.white.withOpacity(0.05),
          ),
        ),
        child: child0,
      ),
    ),
  );
}
