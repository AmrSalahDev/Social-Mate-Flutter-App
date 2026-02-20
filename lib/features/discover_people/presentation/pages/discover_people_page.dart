import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_mate_app/core/di/di.dart';
import 'package:social_mate_app/core/l10n/generated/l10n.dart';
import 'package:social_mate_app/core/services/toast_service.dart';
import 'package:social_mate_app/features/discover_people/presentation/bloc/discover_people_bloc.dart';
import 'package:social_mate_app/features/discover_people/presentation/views/discover_people_item.dart';
import 'package:social_mate_app/features/discover_people/presentation/views/shimmer_people.dart';

class DiscoverPeoplePage extends StatefulWidget {
  const DiscoverPeoplePage({super.key});

  @override
  State<DiscoverPeoplePage> createState() => _DiscoverPeoplePageState();
}

class _DiscoverPeoplePageState extends State<DiscoverPeoplePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    final bloc = context.read<DiscoverPeopleBloc>();
    if (bloc.state is! DiscoverPeopleLoaded) {
      bloc.add(GetDiscoverPeopleEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final colorScheme = Theme.of(context).colorScheme;
    final strings = AppStrings.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(strings.discoverPeople),
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
      body: BlocConsumer<DiscoverPeopleBloc, DiscoverPeopleState>(
        listenWhen: (previous, current) {
          return current is DiscoverPeopleError;
        },
        listener: (context, state) {
          if (state is DiscoverPeopleError) {
            getIt<ToastService>().showErrorToast(
              context: context,
              message: state.message,
            );
          }
        },
        buildWhen: (previous, current) {
          return current is DiscoverPeopleLoading ||
              current is DiscoverPeopleLoaded ||
              current is DiscoverPeopleError;
        },
        builder: (context, state) {
          if (state is DiscoverPeopleLoading) {
            return const ShimmerPeople();
          }
          if (state is DiscoverPeopleError) {
            return const SizedBox.shrink();
          }
          if (state is DiscoverPeopleLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<DiscoverPeopleBloc>().add(
                  GetDiscoverPeopleEvent(),
                );
              },
              child: ListView.builder(
                key: const PageStorageKey(
                  'discover_people_scroll_key',
                ), // Save scroll position because of when exit the page and come back it will be at the same position
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                itemCount: state.users.length,
 
                itemBuilder: (context, index) {
                  return DiscoverPeopleItem(
                    key: ValueKey(state.users[index].id),
                    user: state.users[index],
                  );
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
