import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../models/profile_model.dart';
import '../widgets/common/app_header.dart';
import '../widgets/common/profile_avatar.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  // Remaining facts (Passion and North Star removed)
  static const _verticalFacts = [
    _FactData(
      icon: Icons.location_on_rounded,
      tag: 'LOCATION',
      value: 'Andhra Pradesh, India',
      accentColor: Color(0xFF3B82F6),
    ),
    _FactData(
      icon: Icons.school_rounded,
      tag: 'DEGREE',
      value: 'B.Tech AI & DS (2026 - Present)',
      accentColor: Color(0xFF8B5CF6),
    ),
    _FactData(
      icon: Icons.stars_rounded,
      tag: 'CGPA',
      value: '8.7 / 10',
      accentColor: Color(0xFFF59E0B),
    ),
    _FactData(
      icon: Icons.translate_rounded,
      tag: 'LANGUAGES',
      value: 'English & Telugu',
      accentColor: Color(0xFF10B981),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();

    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.04),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const profile = ProfileModel.instance;

    return Column(
      children: [
        const AppHeader(title: 'About Me'),
        Expanded(
          child: FadeTransition(
            opacity: _fadeAnim,
            child: SlideTransition(
              position: _slideAnim,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ==========================================
                    // 1. ORGANIC HERO NARRATIVE (NO BOX CONTAINER)
                    // ==========================================
                    _buildHeroNarrative(context, profile),
                    const SizedBox(height: 36),

                    // Ambient connecting divider
                    Container(
                      height: 1,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryPurple.withValues(alpha: 0.3),
                            AppColors.accentCyan.withValues(alpha: 0.2),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // ==========================================
                    // 2. QUICK FACTS (VERTICAL FLOW & HOVER EFFECTS)
                    // ==========================================
                    const _SectionHeader(
                      icon: Icons.fingerprint_rounded,
                      title: 'Quick Facts',
                      subtitle: 'Key background credentials & details',
                      color: AppColors.primaryPurple,
                    ),
                    const SizedBox(height: 16),
                    Column(
                      children: _verticalFacts
                          .map((f) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: _VerticalFactTile(fact: f),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // 1. Organic Hero Narrative (Unboxed, fluid typography and glowing aura)
  Widget _buildHeroNarrative(BuildContext context, ProfileModel profile) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 720;

        final avatarWidget = Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Glowing Concentric Orbital Ring
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const SweepGradient(
                    colors: [
                      AppColors.primaryPurple,
                      AppColors.accentCyan,
                      AppColors.cardAboutGlow,
                      AppColors.primaryPurple,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryPurple.withValues(alpha: 0.35),
                      blurRadius: 28,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const ProfileAvatar(size: 105),
                ),
              ),
              const SizedBox(height: 14),
              // Floating live status pill
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFF10B981).withValues(alpha: 0.25),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        color: Color(0xFF10B981),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Ready to Build & Collaborate',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF047857),
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );

        final textWidget = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Subtitle Tag
            Row(
              children: [
                Container(
                  width: 24,
                  height: 3,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.primaryPurple, AppColors.accentCyan],
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 10),
                ShaderMask(
                  shaderCallback: (b) => const LinearGradient(
                    colors: [AppColors.primaryPurple, AppColors.accentCyan],
                  ).createShader(b),
                  child: const Text(
                    'BIOGRAPHY & CREATIVE DNA',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Name
            Text(
              profile.name,
              style: const TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w900,
                color: AppColors.primaryNavy,
                letterSpacing: -1.0,
                height: 1.15,
              ),
            ),
            const SizedBox(height: 6),

            // Title badge
            Text(
              profile.title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.blueGrey.shade700,
                letterSpacing: -0.2,
              ),
            ),
            const SizedBox(height: 18),

            // Narrative Story with an editorial vertical gradient accent line
            Container(
              padding: const EdgeInsets.only(left: 18),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    width: 3.5,
                    color: AppColors.primaryPurple.withValues(alpha: 0.4),
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'I\'m a passionate Artificial Intelligence & Data Science (AI & DS) student with a deep interest in building elegant, intelligent, user-focused digital experiences.',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryNavy.withValues(alpha: 0.85),
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'I love exploring the intersection of design and data science — from crafting beautiful UIs to developing machine learning models and predictive analytics. '
                    'Every project I take on is an opportunity to learn, grow, and create real-world impact.',
                    style: TextStyle(
                      fontSize: 13.5,
                      color: Colors.blueGrey.shade600,
                      height: 1.7,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );

        if (isCompact) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              avatarWidget,
              const SizedBox(height: 28),
              textWidget,
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            avatarWidget,
            const SizedBox(width: 36),
            Expanded(child: textWidget),
          ],
        );
      },
    );
  }
}

// ==========================================
// SUB-COMPONENTS WITH ANIMATED HOVER EFFECTS
// ==========================================

class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  const _SectionHeader({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 17, color: color),
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryNavy,
                letterSpacing: -0.3,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.only(left: 33),
          child: Text(
            subtitle,
            style: TextStyle(
              fontSize: 12.5,
              color: Colors.blueGrey.shade500,
            ),
          ),
        ),
      ],
    );
  }
}

class _FactData {
  final IconData icon;
  final String tag;
  final String value;
  final Color accentColor;

  const _FactData({
    required this.icon,
    required this.tag,
    required this.value,
    required this.accentColor,
  });
}

class _VerticalFactTile extends StatefulWidget {
  final _FactData fact;
  const _VerticalFactTile({required this.fact});

  @override
  State<_VerticalFactTile> createState() => _VerticalFactTileState();
}

class _VerticalFactTileState extends State<_VerticalFactTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final fact = widget.fact;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(_isHovered ? 6 : 0, 0, 0),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          color: _isHovered
              ? Colors.white
              : Colors.white.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered
                ? fact.accentColor.withValues(alpha: 0.45)
                : Colors.blueGrey.shade100.withValues(alpha: 0.5),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? fact.accentColor.withValues(alpha: 0.16)
                  : Colors.black.withValues(alpha: 0.02),
              blurRadius: _isHovered ? 18 : 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Circular Icon Disc
            Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: fact.accentColor.withValues(alpha: 0.12),
              ),
              child: Icon(fact.icon, size: 18, color: fact.accentColor),
            ),
            const SizedBox(width: 16),
            // Tag & Value
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    fact.tag,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.1,
                      color: fact.accentColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    fact.value,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryNavy,
                      letterSpacing: -0.2,
                    ),
                  ),
                ],
              ),
            ),
            // Subtle trailing chevron on hover
            AnimatedOpacity(
              duration: const Duration(milliseconds: 180),
              opacity: _isHovered ? 1.0 : 0.0,
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 13,
                color: fact.accentColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
