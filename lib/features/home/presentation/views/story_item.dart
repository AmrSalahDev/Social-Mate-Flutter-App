import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_mate_app/global/widgets/shimmer_avater.dart';

class StoryItem extends StatelessWidget {
  final String name;
  final String? imageUrl;
  final String? text;
  final Color? bgColor;
  final String type;

  final bool hasUpdate;
  final VoidCallback? onTap;
  final bool isLoading;

  const StoryItem({
    super.key,
    required this.name,
    required this.type,
    this.imageUrl,
    this.text,
    this.bgColor,
    this.hasUpdate = false,
    this.isLoading = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DottedBorder(
            options: CircularDottedBorderOptions(
              strokeWidth: 3,
              padding: EdgeInsets.zero,
              color: colorScheme.secondary,
            ),
            child: _buildStoryPreview(colorScheme, textTheme, isLoading),
          ),
          8.verticalSpace,
          SizedBox(
            width: 60.w,
            child: Text(
              name,
              style: textTheme.labelMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoryPreview(
    ColorScheme colorScheme,
    TextTheme textTheme,
    bool isLoading,
  ) {
    if (type == 'image' && imageUrl != null) {
      return Stack(
        children: [
          ShimmerAvater(size: 56.w, imageUrl: imageUrl!),
          if (isLoading) ...[
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: const Center(child: CircularProgressIndicator()),
              ),
            ),
          ],
        ],
      );
    }

    if (type == 'text') {
      return Stack(
        children: [
          Container(
            width: 56.w,
            height: 56.w,
            decoration: BoxDecoration(
              color: bgColor ?? colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            padding: EdgeInsets.all(6.w),
            child: Text(
              text ?? '',
              style: textTheme.labelSmall?.copyWith(
                color: colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          if (isLoading) ...[
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: const Center(child: CircularProgressIndicator()),
              ),
            ),
          ],
        ],
      );
    }

    // fallback
    return Container(
      width: 56.w,
      height: 56.w,
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant,
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.image, color: colorScheme.onSurfaceVariant),
    );
  }
}
