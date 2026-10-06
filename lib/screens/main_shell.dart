import 'package:flutter/material.dart';
import '../widgets/common/sidebar.dart';
import 'dashboard_screen.dart';
import 'about_screen.dart';
import 'skills_screen.dart';
import 'qualification_screen.dart';
import 'contact_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;

  void _navigate(int index) {
    setState(() => _selectedIndex = index);
  }

  Widget _buildScreen() {
    switch (_selectedIndex) {
      case 0:
        return DashboardScreen(onNavigate: _navigate);
      case 1:
        return const AboutScreen();
      case 2:
        return const SkillsScreen();
      case 3:
        return const QualificationScreen();
      case 4:
        return const ContactScreen();
      default:
        return DashboardScreen(onNavigate: _navigate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          AppSidebar(
            selectedIndex: _selectedIndex,
            onItemSelected: _navigate,
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.04, 0),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                          parent: animation, curve: Curves.easeOut),
                    ),
                    child: child,
                  ),
                );
              },
              child: KeyedSubtree(
                key: ValueKey<int>(_selectedIndex),
                child: _buildScreen(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
