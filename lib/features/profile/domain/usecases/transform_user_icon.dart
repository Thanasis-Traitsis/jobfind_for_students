import 'package:flutter/material.dart';

import '../../../../core/constants/icons.dart';

IconData transformUserIcon(String role) {
  switch (role) {
    case 'user':
      return studentIcon;
    case 'old_student':
      return oldStudentIcon;
    case 'business':
      return businessIcon;
    case 'secretary':
      return secretaryIcon;
    default:
      return adminIcon;
  }
}