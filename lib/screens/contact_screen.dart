import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/constants/app_colors.dart';
import '../models/profile_model.dart';
import '../widgets/common/app_header.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
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

  void _copyToClipboard(BuildContext context, String label, String value) {
    Clipboard.setData(ClipboardData(text: value));
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: Colors.white, size: 18),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Copied $label to clipboard!',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        backgroundColor: AppColors.primaryNavy,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const profile = ProfileModel.instance;

    final contactItems = [
      _ContactItemData(
        icon: Icons.email_rounded,
        tag: 'EMAIL ADDRESS',
        value: profile.email,
        accentColor: const Color(0xFFEC4899),
        actionHint: 'Click to copy email',
      ),
      _ContactItemData(
        icon: Icons.phone_rounded,
        tag: 'PHONE NUMBER',
        value: profile.phone,
        accentColor: const Color(0xFF10B981),
        actionHint: 'Click to copy phone',
      ),
      _ContactItemData(
        icon: Icons.location_on_rounded,
        tag: 'LOCATION / BASE',
        value: profile.location,
        accentColor: const Color(0xFF3B82F6),
        actionHint: 'Click to copy location',
      ),
      _ContactItemData(
        icon: Icons.code_rounded,
        tag: 'GITHUB REPOSITORY',
        value: profile.github,
        accentColor: AppColors.primaryPurple,
        actionHint: 'Click to copy link',
      ),
      _ContactItemData(
        icon: Icons.business_center_rounded,
        tag: 'LINKEDIN NETWORK',
        value: profile.linkedin,
        accentColor: const Color(0xFF06B6D4),
        actionHint: 'Click to copy profile',
      ),
    ];

    return Column(
      children: [
        const AppHeader(title: 'Contact'),
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
                    // 1. WELCOME BANNER (GLOWING PURPLE GRADIENT)
                    // ==========================================
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(28),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF4C1D95), Color(0xFF6D28D9), Color(0xFF7C3AED)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.cardContactGlow.withValues(alpha: 0.35),
                            blurRadius: 32,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  children: [
                                    Text(
                                      "Let's Connect! 🚀",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: -0.4,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Have an opportunity, a project idea, or just want to discuss AI and software engineering? Reach out through any channel below.",
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.8),
                                    fontSize: 13.5,
                                    height: 1.55,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.12),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.2),
                                width: 1.5,
                              ),
                            ),
                            child: const Icon(
                              Icons.waving_hand_rounded,
                              color: Colors.amber,
                              size: 34,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 36),

                    // ==========================================
                    // 2. SECTION HEADER
                    // ==========================================
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: AppColors.primaryPurple.withValues(alpha: 0.12),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.contact_phone_rounded,
                            size: 18,
                            color: AppColors.primaryPurple,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Direct Contact Channels',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryNavy,
                            letterSpacing: -0.3,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.only(left: 35),
                      child: Text(
                        'Click on any channel to copy its details directly to your clipboard',
                        style: TextStyle(
                          fontSize: 12.5,
                          color: Colors.blueGrey.shade500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // ==========================================
                    // 3. REMAINING OPTIONS IN VERTICAL FLOW
                    // ==========================================
                    Column(
                      children: contactItems
                          .map(
                            (item) => Padding(
                              padding: const EdgeInsets.only(bottom: 14),
                              child: _VerticalContactTile(
                                item: item,
                                onTap: () => _copyToClipboard(
                                  context,
                                  item.tag.toLowerCase(),
                                  item.value,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 28),

                    // ==========================================
                    // 4. AMBIENT COLLABORATION CALLOUT
                    // ==========================================
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.75),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.primaryPurple.withValues(alpha: 0.2),
                          width: 1.2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.02),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color(0xFF10B981).withValues(alpha: 0.12),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.bolt_rounded,
                              size: 20,
                              color: Color(0xFF10B981),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Fast Response Commitment',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryNavy,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  'Usually responds within 24 hours for internship opportunities, project collaborations, and inquiries.',
                                  style: TextStyle(
                                    fontSize: 12.5,
                                    color: Colors.blueGrey.shade600,
                                    height: 1.45,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ==========================================
// DATA MODEL & VERTICAL CONTACT TILE COMPONENT
// ==========================================

class _ContactItemData {
  final IconData icon;
  final String tag;
  final String value;
  final Color accentColor;
  final String actionHint;

  const _ContactItemData({
    required this.icon,
    required this.tag,
    required this.value,
    required this.accentColor,
    required this.actionHint,
  });
}

class _VerticalContactTile extends StatefulWidget {
  final _ContactItemData item;
  final VoidCallback onTap;

  const _VerticalContactTile({
    required this.item,
    required this.onTap,
  });

  @override
  State<_VerticalContactTile> createState() => _VerticalContactTileState();
}

class _VerticalContactTileState extends State<_VerticalContactTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          transform: Matrix4.translationValues(_isHovered ? 6 : 0, 0, 0),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: _isHovered ? Colors.white : Colors.white.withValues(alpha: 0.75),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: _isHovered
                  ? item.accentColor.withValues(alpha: 0.5)
                  : Colors.blueGrey.shade100.withValues(alpha: 0.5),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? item.accentColor.withValues(alpha: 0.18)
                    : Colors.black.withValues(alpha: 0.025),
                blurRadius: _isHovered ? 20 : 6,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              // Glowing circular icon badge
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: item.accentColor.withValues(alpha: _isHovered ? 0.18 : 0.1),
                  boxShadow: _isHovered
                      ? [
                          BoxShadow(
                            color: item.accentColor.withValues(alpha: 0.35),
                            blurRadius: 10,
                          ),
                        ]
                      : null,
                ),
                child: Icon(
                  item.icon,
                  size: 20,
                  color: item.accentColor,
                ),
              ),
              const SizedBox(width: 18),

              // Detail Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item.tag,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                        color: item.accentColor,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      item.value,
                      style: const TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryNavy,
                        letterSpacing: -0.2,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              // Copy Chip / Badge with Animated Hover Effect
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                decoration: BoxDecoration(
                  color: _isHovered
                      ? item.accentColor.withValues(alpha: 0.12)
                      : Colors.blueGrey.shade50,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: _isHovered
                        ? item.accentColor.withValues(alpha: 0.3)
                        : Colors.transparent,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.copy_rounded,
                      size: 14,
                      color: _isHovered ? item.accentColor : Colors.blueGrey.shade500,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Copy',
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: _isHovered ? item.accentColor : Colors.blueGrey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
