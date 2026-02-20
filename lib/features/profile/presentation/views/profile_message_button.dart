import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:social_mate_app/core/di/di.dart';
import 'package:social_mate_app/core/routes/app_paths.dart';
import 'package:social_mate_app/core/services/toast_service.dart';
class MessageButton extends StatefulWidget {
  final String userId;
  final double? width;

  const MessageButton({super.key, required this.userId, this.width});

  @override
  State<MessageButton> createState() => _MessageButtonState();
}

class _MessageButtonState extends State<MessageButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? 100.w,
      height: 45.h,
      child: ElevatedButton(
        onPressed: _isLoading ? null : () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF007BFF).withOpacity(0.1),
          foregroundColor: const Color(0xFF007BFF),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          padding: EdgeInsets.zero,
        ),
        child: _isLoading
            ? SizedBox(
                width: 20.w,
                height: 20.w,
                child: const CircularProgressIndicator(strokeWidth: 2),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.mail_outline, size: 18.w),
                  8.horizontalSpace,
                  const Text('Message'),
                ],
              ),
      ),
    );
  }
}
