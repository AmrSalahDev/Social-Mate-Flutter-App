import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_mate_app/core/di/di.dart';
import 'package:social_mate_app/core/services/toast_service.dart';
import 'package:social_mate_app/features/home/presentation/bloc/post_bloc.dart';
import 'package:social_mate_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:social_mate_app/features/profile/presentation/tabs/details_tab.dart';
import 'package:social_mate_app/features/profile/presentation/tabs/posts_tab.dart';
import 'package:social_mate_app/features/profile/presentation/views/profile_actions.dart';
import 'package:social_mate_app/features/profile/presentation/views/profile_follow_button.dart';
import 'package:social_mate_app/features/profile/presentation/views/profile_header.dart';
import 'package:social_mate_app/features/profile/presentation/views/profile_info.dart';
import 'package:social_mate_app/features/profile/presentation/views/profile_stats.dart';

class ProfilePage extends StatefulWidget {
  final String? userId;
  const ProfilePage({super.key, this.userId});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    final profileBloc = context.read<ProfileBloc>();
    if (profileBloc.state is! ProfileLoaded || widget.userId != null) {
      profileBloc.add(GetProfileEvent(userId: widget.userId));
    }

    if (widget.userId != null) {
      profileBloc.add(TrackProfileViewEvent(widget.userId!));
    }

    final postBloc = context.read<PostBloc>();
    if (postBloc.state is! PostLoaded) {
      postBloc.add(GetAuthorPostsEvent(widget.userId));
    }
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: BlocConsumer<ProfileBloc, ProfileState>(
          listenWhen: (previous, current) => current is ProfileError,
          listener: (context, state) {
            if (state is ProfileError) {
              getIt<ToastService>().showErrorToast(
                context: context,
                message: state.message,
              );
            }
          },
          buildWhen: (previous, current) =>
              current is ProfileLoaded || current is ProfileLoading,
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ProfileError) {
              return const SizedBox.shrink();
            }
            if (state is ProfileLoaded) {
              return NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          ProfileHeader(profile: state.profile),
                          70.verticalSpace,
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Column(
                              children: [
                                ProfileInfo(profile: state.profile),
                                16.verticalSpace,
                                if (widget.userId == null) ...[
                                  const ProfileActions(),
                                  24.verticalSpace,
                                ],
                                if (widget.userId != null) ...[
                                  ProfileFollowButton(userId: widget.userId!),
                                  16.verticalSpace,
                                ],
                                ProfileStats(profile: state.profile),
                                24.verticalSpace,
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 35.w,
                                  ),
                                  child: TabBar(
                                    controller: _tabController,
                                    indicatorColor: colorScheme.onSurface,
                                    labelColor: colorScheme.onSurface,
                                    unselectedLabelColor: Colors.grey.shade400,
                                    labelStyle: textTheme.titleLarge?.copyWith(
                                      color: colorScheme.onSurface,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    unselectedLabelStyle: textTheme.titleLarge
                                        ?.copyWith(
                                          color: Colors.grey.shade400,
                                          fontWeight: FontWeight.w500,
                                        ),
                                    indicatorSize: TabBarIndicatorSize.tab,
                                    tabs: const [
                                      Tab(text: 'Posts'),
                                      Tab(text: 'Details'),
                                    ],
                                  ),
                                ),
                                24.verticalSpace,
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ];
                },
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      PostsTab(profile: state.profile),
                      DetailsTab(profile: state.profile),
                    ],
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
