import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import 'profile_avatar.dart';

class AppHeader extends StatefulWidget {
  final String title;
  const AppHeader({super.key, required this.title});

  @override
  State<AppHeader> createState() => _AppHeaderState();
}

class _AppHeaderState extends State<AppHeader>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulse;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _pulse, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryPurple.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Row(
          children: [
            // Page title with animated accent line
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryNavy,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 3),
                AnimatedBuilder(
                  animation: _pulseAnim,
                  builder: (_, __) => Container(
                    width: 40,
                    height: 3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primaryPurple
                              .withValues(alpha: _pulseAnim.value),
                          AppColors.accentCyan
                              .withValues(alpha: _pulseAnim.value),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            // Live Status badge
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFECFDF5),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFF10B981), width: 1),
              ),
              child: Row(
                children: [
                  AnimatedBuilder(
                    animation: _pulseAnim,
                    builder: (_, __) => Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.lerp(
                          const Color(0xFF10B981),
                          const Color(0xFF34D399),
                          _pulseAnim.value,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF10B981)
                                .withValues(alpha: _pulseAnim.value * 0.6),
                            blurRadius: 6,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    'Open to Opportunities',
                    style: TextStyle(
                      color: Color(0xFF065F46),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Profile Avatar with user photo
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [AppColors.primaryPurple, AppColors.accentCyan],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryPurple.withValues(alpha: 0.4),
                    blurRadius: 10,
                  )
                ],
              ),
              child: const ProfileAvatar(size: 38),
            ),
          ],
        ),
      ),
    );
  }
}
