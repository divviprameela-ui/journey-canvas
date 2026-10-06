import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../models/profile_model.dart';
import '../common/profile_avatar.dart';

class HeroBanner extends StatefulWidget {
  final VoidCallback? onExploreSkills;
  final VoidCallback? onContact;

  const HeroBanner({
    super.key,
    this.onExploreSkills,
    this.onContact,
  });

  @override
  State<HeroBanner> createState() => _HeroBannerState();
}

class _HeroBannerState extends State<HeroBanner>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _floatController;
  late AnimationController _rotateController;
  late Animation<Offset> _slideAnim;
  late Animation<double> _fadeAnim;
  late Animation<double> _floatAnim;

  @override
  void initState() {
    super.initState();

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();

    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));

    _fadeAnim = CurvedAnimation(parent: _slideController, curve: Curves.easeOut);

    _floatAnim = Tween<double>(begin: -6, end: 6).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _slideController.dispose();
    _floatController.dispose();
    _rotateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const profile = ProfileModel.instance;
    final isCompact = MediaQuery.of(context).size.width < 850;

    return FadeTransition(
      opacity: _fadeAnim,
      child: SlideTransition(
        position: _slideAnim,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(isCompact ? 24 : 36),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            gradient: const LinearGradient(
              colors: [
                Color(0xFF0F172A),
                Color(0xFF1E1B4B),
                Color(0xFF0D1527),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryPurple.withValues(alpha: 0.28),
                blurRadius: 40,
                spreadRadius: 2,
                offset: const Offset(0, 16),
              ),
            ],
          ),
          child: isCompact
              ? Column(
                  children: [
                    _buildAvatarProfile(profile),
                    const SizedBox(height: 24),
                    _buildTextContent(profile),
                  ],
                )
              : Row(
                  children: [
                    Expanded(child: _buildTextContent(profile)),
                    const SizedBox(width: 36),
                    _buildAvatarProfile(profile),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildTextContent(ProfileModel profile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tag chip
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [
                Color(0xFF6366F1),
                Color(0xFF06B6D4),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6366F1).withValues(alpha: 0.4),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.auto_awesome, color: Colors.white, size: 13),
              SizedBox(width: 6),
              Text(
                'AI & Full-Stack Creative Developer',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Name
        Text(
          profile.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 38,
            fontWeight: FontWeight.w800,
            letterSpacing: -1.2,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 8),
        // Title with gradient
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFF818CF8), Color(0xFF38BDF8)],
          ).createShader(bounds),
          child: Text(
            profile.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          profile.tagline,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.72),
            fontSize: 14,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 24),
        // Action buttons
        Wrap(
          spacing: 12,
          runSpacing: 10,
          children: [
            _GlassButton(
              label: 'Explore Arsenal',
              icon: Icons.bolt_rounded,
              isPrimary: true,
              onTap: widget.onExploreSkills ?? () {},
            ),
            _GlassButton(
              label: 'Get In Touch',
              icon: Icons.send_rounded,
              isPrimary: false,
              onTap: widget.onContact ?? () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAvatarProfile(ProfileModel profile) {
    return AnimatedBuilder(
      animation: _floatAnim,
      builder: (_, child) => Transform.translate(
        offset: Offset(0, _floatAnim.value),
        child: child,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Ambient Outer Glow
          Container(
            width: 190,
            height: 190,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryPurple.withValues(alpha: 0.35),
                  blurRadius: 50,
                  spreadRadius: 10,
                ),
                BoxShadow(
                  color: AppColors.accentCyan.withValues(alpha: 0.25),
                  blurRadius: 40,
                  spreadRadius: 4,
                ),
              ],
            ),
          ),
          // Rotating Futuristic Orbital Ring
          RotationTransition(
            turns: _rotateController,
            child: Container(
              width: 172,
              height: 172,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.transparent,
                  width: 2.5,
                ),
                gradient: const SweepGradient(
                  colors: [
                    Color(0xFF6366F1),
                    Color(0xFF06B6D4),
                    Colors.transparent,
                    Color(0xFF8B5CF6),
                  ],
                ),
              ),
            ),
          ),
          // Holographic Avatar Frame with User's Photo
          Container(
            width: 150,
            height: 150,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xFF6366F1), Color(0xFF06B6D4)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryPurple.withValues(alpha: 0.5),
                  blurRadius: 24,
                ),
              ],
            ),
            child: const ProfileAvatar(size: 142),
          ),
          // Active Status Badge
          Positioned(
            bottom: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF0F172A),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFF10B981),
                  width: 1.5,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFF10B981),
                    blurRadius: 8,
                    spreadRadius: 1,
                  )
                ],
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 3.5,
                    backgroundColor: Color(0xFF10B981),
                  ),
                  SizedBox(width: 4),
                  Text(
                    'ONLINE',
                    style: TextStyle(
                      color: Color(0xFF10B981),
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.6,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GlassButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool isPrimary;
  final VoidCallback onTap;

  const _GlassButton({
    required this.label,
    required this.icon,
    required this.isPrimary,
    required this.onTap,
  });

  @override
  State<_GlassButton> createState() => _GlassButtonState();
}

class _GlassButtonState extends State<_GlassButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: widget.isPrimary
                ? const LinearGradient(
                    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                  )
                : null,
            color: widget.isPrimary
                ? null
                : Colors.white.withValues(alpha: _hovered ? 0.18 : 0.08),
            border: Border.all(
              color: widget.isPrimary
                  ? Colors.transparent
                  : Colors.white.withValues(alpha: _hovered ? 0.5 : 0.2),
            ),
            boxShadow: widget.isPrimary && _hovered
                ? [
                    BoxShadow(
                      color: AppColors.primaryPurple.withValues(alpha: 0.55),
                      blurRadius: 18,
                      offset: const Offset(0, 4),
                    )
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, color: Colors.white, size: 16),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
