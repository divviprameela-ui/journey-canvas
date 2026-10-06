import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/constants/app_colors.dart';
import '../models/profile_model.dart';
import '../widgets/common/app_header.dart';
import '../widgets/dashboard/hero_banner.dart';

class DashboardScreen extends StatelessWidget {
  final ValueChanged<int> onNavigate;

  const DashboardScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    const profile = ProfileModel.instance;

    return Column(
      children: [
        const AppHeader(title: 'Portfolio Dashboard'),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Panoramic Hero with Profile Pic & Glowing Hologram
                HeroBanner(
                  onExploreSkills: () => onNavigate(2),
                  onContact: () => onNavigate(4),
                ),
                const SizedBox(height: 36),

                // 2. Fluid Milestone Trajectory (Horizontal Flow, NOT square boxes)
                _buildTrajectorySection(context),
                const SizedBox(height: 36),

                // 3. Featured Focus Strengths & Arsenal Constellation (Organic Badges)
                _buildArsenalConstellation(context),
                const SizedBox(height: 36),

                // 4. Creative Vision & Philosophy Banner (Curved Glassmorphic Ribbon)
                _buildVisionRibbon(context),
                const SizedBox(height: 36),

                // 5. Connect & Social Dock (Rounded Capsule)
                _buildConnectDock(context, profile),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Trajectory Section: A timeline flow with connecting lines and glowing nodes
  Widget _buildTrajectorySection(BuildContext context) {
    final milestones = [
      {
        'year': 'Phase 1',
        'title': 'Foundations & Problem Solving',
        'desc': 'Data structures, C++, Python algorithmic thinking & OOP principles.',
        'icon': Icons.psychology_outlined,
        'color': const Color(0xFF3B82F6),
      },
      {
        'year': 'Phase 2',
        'title': 'Full-Stack & Flutter Engineering',
        'desc': 'Cross-platform reactive mobile & web apps, state management & UI.',
        'icon': Icons.devices_rounded,
        'color': const Color(0xFF6366F1),
      },
      {
        'year': 'Phase 3',
        'title': 'AI & Intelligent Systems',
        'desc': 'Exploration of prompt engineering, LLM integration & modern cloud.',
        'icon': Icons.auto_awesome_rounded,
        'color': const Color(0xFF06B6D4),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Journey Trajectory',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryNavy,
                    letterSpacing: -0.4,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'The evolution of technical exploration & milestones',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
            TextButton.icon(
              onPressed: () => onNavigate(3),
              icon: const Icon(Icons.timeline_rounded, size: 16),
              label: const Text('Full Qualifications'),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primaryPurple,
                textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        LayoutBuilder(
          builder: (context, constraints) {
            final isCompact = constraints.maxWidth < 750;
            return Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: Colors.blueGrey.shade100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: isCompact
                  ? Column(
                      children: milestones.map((m) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: _MilestoneItem(data: m),
                        );
                      }).toList(),
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (int i = 0; i < milestones.length; i++) ...[
                          Expanded(child: _MilestoneItem(data: milestones[i])),
                          if (i < milestones.length - 1)
                            Padding(
                              padding: const EdgeInsets.only(top: 24, left: 8, right: 8),
                              child: Icon(
                                Icons.arrow_forward_rounded,
                                color: Colors.blueGrey.shade300,
                                size: 18,
                              ),
                            ),
                        ],
                      ],
                    ),
            );
          },
        ),
      ],
    );
  }

  // Arsenal Constellation: Organic glowing tags & skill preview
  Widget _buildArsenalConstellation(BuildContext context) {
    final focusPillars = [
      {
        'title': 'Cross-Platform UI/UX',
        'subtitle': 'Flutter • Reactive State • 60fps Glassmorphic Animations',
        'icon': Icons.flutter_dash,
        'color': const Color(0xFF6366F1),
      },
      {
        'title': 'Core Languages & Algorithms',
        'subtitle': 'Python • Java • C++ • Efficient Data Structures',
        'icon': Icons.code_rounded,
        'color': const Color(0xFF3B82F6),
      },
      {
        'title': 'Modern Web & Data Design',
        'subtitle': 'HTML5 / CSS3 • Responsive Design • SQL Normalization',
        'icon': Icons.layers_rounded,
        'color': const Color(0xFFF59E0B),
      },
      {
        'title': 'DevOps & Tooling Flow',
        'subtitle': 'Git CLI • GitHub Workflows • VS Code Optimization',
        'icon': Icons.terminal_rounded,
        'color': const Color(0xFF10B981),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Creative Arsenal & Focus Domains',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryNavy,
                    letterSpacing: -0.4,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Core disciplines cultivated through active building',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
            TextButton.icon(
              onPressed: () => onNavigate(2),
              icon: const Icon(Icons.bolt_rounded, size: 16),
              label: const Text('View All Skills'),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primaryPurple,
                textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        LayoutBuilder(
          builder: (context, constraints) {
            final isCompact = constraints.maxWidth < 750;
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: focusPillars.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isCompact ? 1 : 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: isCompact ? 3.4 : 2.8,
              ),
              itemBuilder: (context, index) {
                final item = focusPillars[index];
                return _PillarCard(
                  data: item,
                  onTap: () => onNavigate(2),
                );
              },
            );
          },
        ),
      ],
    );
  }

  // Vision Ribbon: Sleek curved glassmorphic quote banner
  Widget _buildVisionRibbon(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF1E1B4B),
            Color(0xFF312E81),
            Color(0xFF0F172A),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryPurple.withValues(alpha: 0.25),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.1),
              border: Border.all(
                color: AppColors.accentCyan.withValues(alpha: 0.5),
              ),
            ),
            child: const Icon(
              Icons.format_quote_rounded,
              color: AppColors.accentCyan,
              size: 28,
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Philosophy & Vision',
                  style: TextStyle(
                    color: AppColors.accentCyan,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  '"Software is the canvas where engineering logic and human imagination unite to solve real-world problems."',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () => onNavigate(1),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Read full bio & aspirations',
                        style: TextStyle(
                          color: Color(0xFF818CF8),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(Icons.arrow_forward_rounded,
                          color: Color(0xFF818CF8), size: 14),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Connect Dock: Sleek pill-shaped dock with direct triggers
  Widget _buildConnectDock(BuildContext context, ProfileModel profile) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blueGrey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 16,
        runSpacing: 12,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF10B981),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Open to collaborations & software engineering opportunities',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryNavy,
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              OutlinedButton.icon(
                onPressed: () => onNavigate(4),
                icon: const Icon(Icons.mail_outline_rounded, size: 15),
                label: const Text('Contact Directly'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primaryPurple,
                  side: const BorderSide(color: AppColors.primaryPurple),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: () => onNavigate(1),
                icon: const Icon(Icons.person_outline_rounded, size: 15),
                label: const Text('About Me'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: AppColors.primaryPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: profile.github));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('GitHub link copied: ${profile.github}'),
                      duration: const Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(Icons.code_rounded, size: 15),
                label: const Text('GitHub'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFF0F172A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MilestoneItem extends StatelessWidget {
  final Map<String, dynamic> data;

  const _MilestoneItem({required this.data});

  @override
  Widget build(BuildContext context) {
    final color = data['color'] as Color;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(data['icon'] as IconData, color: color, size: 20),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data['year'] as String,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: color,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                data['title'] as String,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryNavy,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                data['desc'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.blueGrey.shade600,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PillarCard extends StatefulWidget {
  final Map<String, dynamic> data;
  final VoidCallback onTap;

  const _PillarCard({required this.data, required this.onTap});

  @override
  State<_PillarCard> createState() => _PillarCardState();
}

class _PillarCardState extends State<_PillarCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final color = widget.data['color'] as Color;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(0.0, _isHovered ? -3.0 : 0.0, 0.0),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: _isHovered
                  ? color.withValues(alpha: 0.8)
                  : Colors.blueGrey.shade100,
              width: _isHovered ? 1.5 : 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? color.withValues(alpha: 0.18)
                    : Colors.black.withValues(alpha: 0.03),
                blurRadius: _isHovered ? 16 : 8,
                offset: Offset(0, _isHovered ? 6 : 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(widget.data['icon'] as IconData, color: color, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.data['title'] as String,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryNavy,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      widget.data['subtitle'] as String,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.blueGrey.shade600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 13,
                color: _isHovered ? color : Colors.blueGrey.shade300,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
