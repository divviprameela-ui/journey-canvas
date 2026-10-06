import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../models/journey_model.dart';
import '../widgets/common/app_header.dart';

class QualificationScreen extends StatefulWidget {
  const QualificationScreen({super.key});

  @override
  State<QualificationScreen> createState() => _QualificationScreenState();
}

class _QualificationScreenState extends State<QualificationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const educations = JourneyModel.educationList;

    return Column(
      children: [
        const AppHeader(title: 'Qualifications'),
        Expanded(
          child: FadeTransition(
            opacity: _fadeAnim,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header banner
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF064E3B), Color(0xFF065F46)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.cardQualGlow.withValues(alpha: 0.3),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(Icons.school_rounded,
                              color: Colors.white, size: 30),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Educational Journey',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Academic milestones & achievements',
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.65),
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${educations.length} Milestones',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  // Timeline
                  const Text(
                    'Timeline',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryNavy,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildTimeline(educations),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeline(List<JourneyModel> educations) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: educations.length,
      itemBuilder: (context, index) {
        final edu = educations[index];
        final isLast = index == educations.length - 1;
        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Timeline line + dot
              SizedBox(
                width: 40,
                child: Column(
                  children: [
                    Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [AppColors.cardQualGlow, Color(0xFF06B6D4)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.cardQualGlow.withValues(alpha: 0.5),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    ),
                    if (!isLast)
                      Expanded(
                        child: Container(
                          width: 2,
                          color: AppColors.cardQualGlow.withValues(alpha: 0.2),
                        ),
                      ),
                  ],
                ),
              ),
              // Card
              Expanded(
                child: _TimelineCard(
                  edu: edu,
                  index: index,
                  controller: _controller,
                  isLast: isLast,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TimelineCard extends StatefulWidget {
  final JourneyModel edu;
  final int index;
  final AnimationController controller;
  final bool isLast;

  const _TimelineCard({
    required this.edu,
    required this.index,
    required this.controller,
    required this.isLast,
  });

  @override
  State<_TimelineCard> createState() => _TimelineCardState();
}

class _TimelineCardState extends State<_TimelineCard> {
  bool _expanded = false;
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => setState(() => _expanded = !_expanded),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: EdgeInsets.only(left: 12, bottom: widget.isLast ? 0 : 16),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _hovered || _expanded
                  ? AppColors.cardQualGlow.withValues(alpha: 0.4)
                  : Colors.transparent,
            ),
            boxShadow: [
              BoxShadow(
                color: _hovered
                    ? AppColors.cardQualGlow.withValues(alpha: 0.2)
                    : Colors.black.withValues(alpha: 0.06),
                blurRadius: _hovered ? 24 : 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.edu.degree,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AppColors.primaryNavy,
                      ),
                    ),
                  ),
                  Icon(
                    _expanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: AppColors.cardQualGlow,
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.business_rounded,
                      size: 13, color: Colors.blueGrey),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      widget.edu.institution,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ],
              ),
              AnimatedCrossFade(
                duration: const Duration(milliseconds: 250),
                crossFadeState: _expanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                firstChild: const SizedBox.shrink(),
                secondChild: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Row(
                    children: [
                      _InfoChip(
                        icon: Icons.calendar_today_rounded,
                        label: widget.edu.duration,
                        color: AppColors.cardQualGlow,
                      ),
                      const SizedBox(width: 8),
                      _InfoChip(
                        icon: Icons.grade_rounded,
                        label: widget.edu.grade,
                        color: AppColors.primaryPurple,
                      ),
                    ],
                  ),
                ),
              ),
              // Always show chips if not expanded in a smaller format
              if (!_expanded) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.access_time_rounded,
                        size: 12, color: Colors.blueGrey),
                    const SizedBox(width: 4),
                    Text(
                      widget.edu.duration,
                      style: const TextStyle(
                          fontSize: 11, color: Colors.blueGrey),
                    ),
                    const SizedBox(width: 12),
                    const Icon(Icons.stars_rounded,
                        size: 12, color: AppColors.cardQualGlow),
                    const SizedBox(width: 4),
                    Text(
                      widget.edu.grade,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.cardQualGlow,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Tap to expand',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.blueGrey.shade300,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _InfoChip({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
