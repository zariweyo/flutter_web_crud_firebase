import 'package:flutter/material.dart';

abstract class MReorderableObject{
  int priority;
  bool enabled;

  Uri reorderableImage();
  String reorderableDescription();
  String reorderableDescription2();
  String reorderableTitle();
  IconData reorderableIcon();
  String reorderableId();
  Future<bool> reorderableDeleteable();
  void reorderableNewPriority(int length);


}
