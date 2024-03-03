import 'dart:io';

double calculateBottomNavbar() {
  if (Platform.isIOS) {
    return 80.0;
  }
  return 60.0;
}
