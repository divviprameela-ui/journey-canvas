import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/profile_image_data.dart';

class ProfileAvatar extends StatelessWidget {
  final double size;
  final bool hasGlow;
  final BoxBorder? border;
  final bool enableViewer;

  const ProfileAvatar({
    super.key,
    required this.size,
    this.hasGlow = false,
    this.border,
    this.enableViewer = true,
  });

  void _openPhotoViewer(BuildContext context, Uint8List? bytes) {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) => _PhotoViewerDialog(imageBytes: bytes),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget avatarImage;
    Uint8List? bytes;

    try {
      bytes = base64Decode(kProfileImageBase64);
      avatarImage = Image.memory(
        bytes,
        width: size,
        height: size,
        fit: BoxFit.cover,
      );
    } catch (_) {
      avatarImage = Container(
        width: size,
        height: size,
        color: AppColors.primaryPurple,
        child: Icon(Icons.person, color: Colors.white, size: size * 0.6),
      );
    }

    final avatarWidget = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: border,
        boxShadow: hasGlow
            ? [
                BoxShadow(
                  color: AppColors.primaryPurple.withValues(alpha: 0.4),
                  blurRadius: size * 0.3,
                  spreadRadius: 2,
                ),
              ]
            : null,
      ),
      child: ClipOval(child: avatarImage),
    );

    if (!enableViewer) {
      return avatarWidget;
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _openPhotoViewer(context, bytes),
        child: Tooltip(
          message: 'Click to view photo',
          child: avatarWidget,
        ),
      ),
    );
  }
}

class _PhotoViewerDialog extends StatefulWidget {
  final Uint8List? imageBytes;

  const _PhotoViewerDialog({this.imageBytes});

  @override
  State<_PhotoViewerDialog> createState() => _PhotoViewerDialogState();
}

class _PhotoViewerDialogState extends State<_PhotoViewerDialog> {
  final TransformationController _transformationController =
      TransformationController();
  double _currentScale = 1.0;

  @override
  void initState() {
    super.initState();
    _transformationController.addListener(_onTransformationChanged);
  }

  @override
  void dispose() {
    _transformationController.removeListener(_onTransformationChanged);
    _transformationController.dispose();
    super.dispose();
  }

  void _onTransformationChanged() {
    final scale = _transformationController.value.getMaxScaleOnAxis();
    if ((scale - _currentScale).abs() > 0.02) {
      setState(() {
        _currentScale = scale;
      });
    }
  }

  void _zoom(double factor) {
    final currentScale = _transformationController.value.getMaxScaleOnAxis();
    final targetScale = (currentScale * factor).clamp(0.5, 6.0);
    final ratio = targetScale / currentScale;

    final matrix = _transformationController.value.clone();
    matrix.multiply(Matrix4.diagonal3Values(ratio, ratio, 1.0));
    _transformationController.value = matrix;
  }

  void _resetZoom() {
    _transformationController.value = Matrix4.identity();
  }

  void _handleDoubleTap() {
    if (_transformationController.value.getMaxScaleOnAxis() > 1.2) {
      _resetZoom();
    } else {
      final matrix = Matrix4.identity();
      matrix.multiply(Matrix4.diagonal3Values(2.2, 2.2, 1.0));
      _transformationController.value = matrix;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final maxPhotoSize = screenSize.shortestSide * 0.72;

    Widget photoContent;
    if (widget.imageBytes != null) {
      photoContent = Image.memory(
        widget.imageBytes!,
        fit: BoxFit.contain,
      );
    } else {
      photoContent = Container(
        width: 260,
        height: 260,
        color: AppColors.primaryPurple,
        child: const Icon(Icons.person, color: Colors.white, size: 120),
      );
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Blurred backdrop - click outside to dismiss
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black.withValues(alpha: 0.82),
              ),
            ),
          ),

          // Interactive Zoomable Photo Area
          Center(
            child: Listener(
              onPointerSignal: (pointerSignal) {
                if (pointerSignal is PointerScrollEvent) {
                  if (pointerSignal.scrollDelta.dy < 0) {
                    _zoom(1.15);
                  } else if (pointerSignal.scrollDelta.dy > 0) {
                    _zoom(1 / 1.15);
                  }
                }
              },
              child: InteractiveViewer(
                transformationController: _transformationController,
                minScale: 0.5,
                maxScale: 6.0,
                boundaryMargin: const EdgeInsets.all(350),
                clipBehavior: Clip.none,
                child: GestureDetector(
                  onTap: () {}, // Prevent tap propagation to backdrop
                  onDoubleTap: _handleDoubleTap,
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: maxPhotoSize.clamp(280.0, 560.0),
                      maxHeight: maxPhotoSize.clamp(280.0, 560.0),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.2),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryPurple.withValues(alpha: 0.45),
                          blurRadius: 40,
                          spreadRadius: 4,
                        ),
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.6),
                          blurRadius: 30,
                          offset: const Offset(0, 15),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(22),
                      child: photoContent,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Top Header Bar: Title and Close Button
          Positioned(
            top: 24,
            left: 24,
            right: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Title & instructions pill
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B).withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.15),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.photo_size_select_actual_outlined,
                        color: AppColors.accentCyan,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Photo Viewer',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.95),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '• Scroll or pinch to zoom • Drag to pan',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.6),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),

                // Close Button
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E293B).withValues(alpha: 0.8),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.2),
                        ),
                      ),
                      child: const Icon(
                        Icons.close_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom Floating Zoom Controls Bar
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A).withValues(alpha: 0.88),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.18),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.5),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Zoom Out Button
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline_rounded),
                      color: Colors.white,
                      iconSize: 22,
                      tooltip: 'Zoom Out (-)',
                      onPressed: () => _zoom(1 / 1.25),
                    ),

                    // Zoom Percentage Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primaryPurple.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.primaryPurple.withValues(alpha: 0.5),
                        ),
                      ),
                      child: Text(
                        '${(_currentScale * 100).round()}%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          fontFeatures: [FontFeature.tabularFigures()],
                        ),
                      ),
                    ),

                    // Zoom In Button
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline_rounded),
                      color: Colors.white,
                      iconSize: 22,
                      tooltip: 'Zoom In (+)',
                      onPressed: () => _zoom(1.25),
                    ),

                    const SizedBox(width: 4),
                    Container(
                      width: 1,
                      height: 22,
                      color: Colors.white.withValues(alpha: 0.2),
                    ),
                    const SizedBox(width: 4),

                    // Reset Zoom Button
                    IconButton(
                      icon: const Icon(Icons.restart_alt_rounded),
                      color: Colors.white70,
                      iconSize: 22,
                      tooltip: 'Reset Zoom (100%)',
                      onPressed: _resetZoom,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
