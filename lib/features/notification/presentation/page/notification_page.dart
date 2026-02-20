import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_mate_app/core/di/di.dart';
import 'package:social_mate_app/core/l10n/generated/l10n.dart';
import 'package:social_mate_app/core/services/toast_service.dart';
import 'package:social_mate_app/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:social_mate_app/features/notification/presentation/views/notification_list.dart';
import 'package:social_mate_app/features/notification/presentation/views/shimmer_notifications.dart';
import 'package:social_mate_app/global/widgets/retry.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationBloc>().add(LoadNotificationsEvent());
    context.read<NotificationBloc>().add(MarkAllAsReadEvent());
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final strings = AppStrings.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.notifications),
        actions: [
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: colorScheme.onSurface,
              size: 27.w,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocConsumer<NotificationBloc, NotificationState>(
        listenWhen: (previous, current) => current is NotificationError,
        listener: (context, state) {
          if (state is NotificationError) {
            getIt<ToastService>().showErrorToast(
              context: context,
              message: state.message,
            );
          }
        },
        builder: (context, state) {
          if (state is NotificationLoading) {
            return const ShimmerNotificaions();
          }

          if (state is NotificationError) {
            return Retry(
              onTap: () {
                context.read<NotificationBloc>().add(LoadNotificationsEvent());
              },
            );
          }

          if (state is NotificationLoaded) {
            if (state.notifications.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.notifications_none,
                      size: 64.w,
                      color: Colors.grey,
                    ),
                    16.verticalSpace,
                    Text(
                      strings.noNotifications,
                      style: textTheme.bodyLarge?.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: () async {
                context.read<NotificationBloc>().add(LoadNotificationsEvent());
              },
              child: NotificationList(notifications: state.notifications),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}