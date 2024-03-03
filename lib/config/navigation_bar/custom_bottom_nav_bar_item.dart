import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomBottomNavBarItem extends BottomNavigationBarItem {
  final String initialLocation;

  const CustomBottomNavBarItem({
    required this.initialLocation,
    required Widget icon,
    String? label,
    Widget? activeIcon,
  }) : super(icon: icon, label: label, activeIcon: activeIcon ?? icon);
}

const List<CustomBottomNavBarItem> tabs = [
  CustomBottomNavBarItem(
    icon:  FaIcon(
      FontAwesomeIcons.house,
      size: 19,
    ),
    activeIcon:  FaIcon(
      FontAwesomeIcons.house,
      size: 19,
    ),
    label: '⬤',
    initialLocation: '/',
  ),
  CustomBottomNavBarItem(
    icon: FaIcon(
      FontAwesomeIcons.briefcase,
      size: 19,
    ),
    activeIcon: FaIcon(
      FontAwesomeIcons.briefcase,
      size: 19,
    ),
    label: '⬤',
    initialLocation: '/job-listing',
  ),
  CustomBottomNavBarItem(
    icon: FaIcon(
      FontAwesomeIcons.solidUser,
      size: 19,
    ),
    activeIcon: FaIcon(
      FontAwesomeIcons.solidUser,
      size: 19,
    ),
    label: '⬤',
    initialLocation: '/profile',
  ),
];
