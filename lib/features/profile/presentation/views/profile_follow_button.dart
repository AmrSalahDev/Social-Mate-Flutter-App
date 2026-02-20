import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_mate_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:social_mate_app/global/widgets/follow_button.dart';
import 'package:social_mate_app/features/profile/presentation/views/profile_message_button.dart';

class ProfileFollowButton extends StatelessWidget {
  const ProfileFollowButton({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProfileBloc, ProfileState, bool>(
      selector: (state) {
        if (state is ProfileLoaded) {
          return state.profile.isFollowing;
        }
        return false;
      },
      builder: (context, isFollowing) {
        return Row(
          children: [
            Expanded(
              child: FollowButton(
                userId: userId,
                isFollowing: isFollowing,
                width: double.infinity,
                onFollow: () {
                  context.read<ProfileBloc>().add(FollowUserEvent(userId));
                },
                onUnfollow: () {
                  context.read<ProfileBloc>().add(UnfollowUserEvent(userId));
                },
              ),
            ),
            12.horizontalSpace,
            Expanded(
              child: MessageButton(userId: userId, width: double.infinity),
            ),
          ],
        );
      },
    );
  }
}
