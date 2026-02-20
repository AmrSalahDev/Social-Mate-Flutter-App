import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:social_mate_app/core/assets_gen/assets.gen.dart';
import 'package:social_mate_app/core/routes/app_paths.dart';
import 'package:social_mate_app/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:social_mate_app/global/widgets/svg_icon.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key, required this.colorScheme});
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Assets.images.appLogoWithoutSearch.image(height: 27.w),
      actions: [
        IconButton(
          onPressed: () {},
          icon: SvgIcon(
            path: Assets.icons.search.path,
            size: 24.w,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        BlocBuilder<NotificationBloc, NotificationState>(
          builder: (context, state) {
            int unreadCount = 0;
            if (state is NotificationLoaded) {
              unreadCount = state.notifications.where((n) => !n.isRead).length;
            }

            return Badge(
              label: Text(unreadCount > 99 ? '99+' : unreadCount.toString()),
              padding: EdgeInsets.all(unreadCount > 99 ? 3.w : 1.5.w),
              offset: Offset(-8.w, 6.h),
              isLabelVisible: unreadCount > 0,
              backgroundColor: colorScheme.error,
              textStyle: TextTheme.of(context).bodySmall?.copyWith(
                color: colorScheme.onError,
                fontWeight: FontWeight.w500,
              ),
              child: IconButton(
                onPressed: () {
                  context.push(AppPaths.notification);
                },
                icon: SvgIcon(
                  path: Assets.icons.bellRinging.path,
                  size: 24.w,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            );
          },
        ),
        IconButton(
          onPressed: () {
            context.push(AppPaths.inbox);
          },
          icon: SvgIcon(
            path: Assets.icons.send.path,
            size: 24.w,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
