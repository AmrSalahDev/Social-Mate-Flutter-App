import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_mate_app/core/l10n/generated/l10n.dart';
import 'package:social_mate_app/features/home/presentation/bloc/post_bloc.dart';
import 'package:social_mate_app/features/home/presentation/bloc/story_bloc.dart';
import 'package:social_mate_app/features/home/presentation/views/home_app_bar.dart';
import 'package:social_mate_app/features/home/presentation/views/post_writing_card.dart';
import 'package:social_mate_app/features/home/presentation/views/post_card.dart';
import 'package:social_mate_app/features/home/presentation/views/shimmer_posts.dart';
import 'package:social_mate_app/features/home/presentation/views/stories_section.dart';
import 'package:social_mate_app/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:social_mate_app/features/profile/presentation/bloc/profile_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    context.read<NotificationBloc>().add(LoadNotificationsEvent());
    
    final profileBloc = context.read<ProfileBloc>();
    if (profileBloc.state is! ProfileLoaded) {
      profileBloc.add(GetProfileEvent());
    }
    final storyBloc = context.read<StoryBloc>();
    if (storyBloc.state is! StoryLoaded) {
      storyBloc.add(GetStoriesEvent());
    }
    final postBloc = context.read<PostBloc>();
    if (postBloc.state is! PostLoaded) {
      postBloc.add(GetPostsEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final strings = AppStrings.of(context);

    return Scaffold(
      appBar: HomeAppBar(colorScheme: colorScheme),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<ProfileBloc>().add(GetProfileEvent());
          context.read<StoryBloc>().add(GetStoriesEvent());
          context.read<PostBloc>().add(GetPostsEvent());
          context.read<NotificationBloc>().add(LoadNotificationsEvent());
        },
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    24.verticalSpace,
                    PostWritingCard(
                      colorScheme: colorScheme,
                      textTheme: textTheme,
                      strings: strings,
                    ),
                    30.verticalSpace,
                    const StoriesSection(),
                    30.verticalSpace,
                  ],
                ),
              ),
            ),

            BlocBuilder<PostBloc, PostState>(
              builder: (context, state) {
                return SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  sliver: state is PostLoading
                      ? const SliverToBoxAdapter(child: ShimmerPosts())
                      : state is PostLoaded
                      ? SliverList.builder(
                          itemCount: state.posts.length,
                          itemBuilder: (context, index) {
                            final post = state.posts[index];
                            return PostCard(post: post);
                          },
                        )
                      : const SliverToBoxAdapter(child: SizedBox.shrink()),
                );
              },
            ),
            SliverToBoxAdapter(child: 50.verticalSpace),
          ],
        ),
      ),
    );
  }
}
