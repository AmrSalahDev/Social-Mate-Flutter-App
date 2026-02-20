// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:image_picker/image_picker.dart' as _i183;
import 'package:injectable/injectable.dart' as _i526;
import 'package:retry/retry.dart' as _i689;
import 'package:social_mate_app/core/di/register_module.dart' as _i124;
import 'package:social_mate_app/core/services/auth_listener.dart' as _i859;
import 'package:social_mate_app/core/services/toast_service.dart' as _i169;
import 'package:social_mate_app/features/auth/bloc/auth_bloc.dart' as _i944;
import 'package:social_mate_app/features/auth/data/remote/auth_remote_datasource.dart'
    as _i250;
import 'package:social_mate_app/features/auth/data/remote/auth_remote_datasource_impl.dart'
    as _i633;
import 'package:social_mate_app/features/auth/data/repos/auth_repo_impl.dart'
    as _i375;
import 'package:social_mate_app/features/auth/domain/repos/auth_repo.dart'
    as _i358;
import 'package:social_mate_app/features/auth/domain/usecases/sign_in_usecase.dart'
    as _i525;
import 'package:social_mate_app/features/auth/domain/usecases/sign_out_usecase.dart'
    as _i691;
import 'package:social_mate_app/features/auth/domain/usecases/sign_up_usecase.dart'
    as _i424;
import 'package:social_mate_app/features/create_post/data/local/media_picker_local_datasource.dart'
    as _i498;
import 'package:social_mate_app/features/create_post/data/local/media_picker_local_datasource_impl.dart'
    as _i67;
import 'package:social_mate_app/features/create_post/data/remote/create_post_remote_datasource.dart'
    as _i285;
import 'package:social_mate_app/features/create_post/data/remote/create_post_remote_datasource_impl.dart'
    as _i861;
import 'package:social_mate_app/features/create_post/data/repos/create_post_repo_impl.dart'
    as _i971;
import 'package:social_mate_app/features/create_post/data/repos/media_picker_repo_impl.dart'
    as _i842;
import 'package:social_mate_app/features/create_post/domain/repos/create_post_repo.dart'
    as _i80;
import 'package:social_mate_app/features/create_post/domain/repos/media_picker_repo.dart'
    as _i206;
import 'package:social_mate_app/features/create_post/domain/usecases/create_post_usecase.dart'
    as _i76;
import 'package:social_mate_app/features/create_post/domain/usecases/pick_document_usecase.dart'
    as _i297;
import 'package:social_mate_app/features/create_post/domain/usecases/pick_image_from_camera_usecase.dart'
    as _i838;
import 'package:social_mate_app/features/create_post/domain/usecases/pick_image_from_gallery_usecase.dart'
    as _i365;
import 'package:social_mate_app/features/create_post/domain/usecases/pick_video_from_camera_usecase.dart'
    as _i1013;
import 'package:social_mate_app/features/create_post/domain/usecases/pick_video_from_gallery_usecase.dart'
    as _i437;
import 'package:social_mate_app/features/create_post/presentation/bloc/create_post_bloc.dart'
    as _i312;
import 'package:social_mate_app/features/create_post/presentation/bloc/media_picker_bloc.dart'
    as _i76;
import 'package:social_mate_app/features/create_story/data/local/gallery_local_datasource.dart'
    as _i164;
import 'package:social_mate_app/features/create_story/data/local/gallery_local_datasource_impl.dart'
    as _i860;
import 'package:social_mate_app/features/create_story/data/repos/gallery_repo_impl.dart'
    as _i925;
import 'package:social_mate_app/features/create_story/domain/repos/gallery_repo.dart'
    as _i579;
import 'package:social_mate_app/features/create_story/domain/usecases/get_photos_usecase.dart'
    as _i540;
import 'package:social_mate_app/features/create_story/presentation/bloc/gallery_bloc.dart'
    as _i853;
import 'package:social_mate_app/features/create_story/presentation/cubit/story_bg_controller_cubit.dart'
    as _i698;
import 'package:social_mate_app/features/discover_people/data/remote/discover_people_remote_datasource.dart'
    as _i176;
import 'package:social_mate_app/features/discover_people/data/remote/discover_people_remote_datasource_impl.dart'
    as _i153;
import 'package:social_mate_app/features/discover_people/data/repos/discover_people_repo_impl.dart'
    as _i296;
import 'package:social_mate_app/features/discover_people/domain/repos/discover_people_repo.dart'
    as _i977;
import 'package:social_mate_app/features/discover_people/domain/usecases/follow_user_usecase.dart'
    as _i575;
import 'package:social_mate_app/features/discover_people/domain/usecases/get_suggested_users_usecase.dart'
    as _i69;
import 'package:social_mate_app/features/discover_people/domain/usecases/unfollow_user_usecase.dart'
    as _i995;
import 'package:social_mate_app/features/discover_people/presentation/bloc/discover_people_bloc.dart'
    as _i419;
import 'package:social_mate_app/features/home/data/local/post_local_datasource.dart'
    as _i531;
import 'package:social_mate_app/features/home/data/local/post_local_datasource_impl.dart'
    as _i84;
import 'package:social_mate_app/features/home/data/remote/post_remote_datasource.dart'
    as _i284;
import 'package:social_mate_app/features/home/data/remote/post_remote_datasource_impl.dart'
    as _i134;
import 'package:social_mate_app/features/home/data/remote/story_remote_datasource.dart'
    as _i915;
import 'package:social_mate_app/features/home/data/remote/story_remote_datasource_impl.dart'
    as _i24;
import 'package:social_mate_app/features/home/data/repos/post_repo_impl.dart'
    as _i520;
import 'package:social_mate_app/features/home/data/repos/story_repo_impl.dart'
    as _i444;
import 'package:social_mate_app/features/home/domain/repos/post_repo.dart'
    as _i358;
import 'package:social_mate_app/features/home/domain/repos/story_repo.dart'
    as _i590;
import 'package:social_mate_app/features/home/domain/usecases/get_author_posts_usecase.dart'
    as _i892;
import 'package:social_mate_app/features/home/domain/usecases/get_posts_usecse.dart'
    as _i817;
import 'package:social_mate_app/features/home/domain/usecases/get_stories_usecase.dart'
    as _i580;
import 'package:social_mate_app/features/home/domain/usecases/toggle_dislike_usecase.dart'
    as _i183;
import 'package:social_mate_app/features/home/domain/usecases/toggle_like_usecase.dart'
    as _i854;
import 'package:social_mate_app/features/home/presentation/bloc/post_bloc.dart'
    as _i853;
import 'package:social_mate_app/features/home/presentation/bloc/story_bloc.dart'
    as _i200;
import 'package:social_mate_app/features/inbox/data/datasources/inbox_remote_data_source.dart'
    as _i762;
import 'package:social_mate_app/features/inbox/data/datasources/inbox_remote_data_source_impl.dart'
    as _i222;
import 'package:social_mate_app/features/inbox/data/repos/inbox_repo_impl.dart'
    as _i1040;
import 'package:social_mate_app/features/inbox/domain/repos/inbox_repository.dart'
    as _i182;
import 'package:social_mate_app/features/inbox/domain/usecases/delete_chat_room_usecase.dart'
    as _i44;
import 'package:social_mate_app/features/inbox/domain/usecases/get_or_create_chat_room_usecase.dart'
    as _i23;
import 'package:social_mate_app/features/inbox/domain/usecases/send_message_usecase.dart'
    as _i300;
import 'package:social_mate_app/features/inbox/domain/usecases/stream_chat_rooms_usecase.dart'
    as _i46;
import 'package:social_mate_app/features/inbox/domain/usecases/stream_messages_usecase.dart'
    as _i869;
import 'package:social_mate_app/features/inbox/presentation/bloc/communication_bloc.dart'
    as _i664;
import 'package:social_mate_app/features/inbox/presentation/bloc/inbox_bloc.dart'
    as _i1024;
import 'package:social_mate_app/features/notification/data/remote/notification_remote_datasource.dart'
    as _i564;
import 'package:social_mate_app/features/notification/data/remote/notification_remote_datasource_impl.dart'
    as _i93;
import 'package:social_mate_app/features/notification/data/repos/notification_repo_impl.dart'
    as _i482;
import 'package:social_mate_app/features/notification/domain/repos/notification_repo.dart'
    as _i737;
import 'package:social_mate_app/features/notification/domain/usecases/get_notifications_usecase.dart'
    as _i516;
import 'package:social_mate_app/features/notification/presentation/bloc/notification_bloc.dart'
    as _i834;
import 'package:social_mate_app/features/profile/data/remote/profile_remote_datasource.dart'
    as _i716;
import 'package:social_mate_app/features/profile/data/remote/profile_remote_datasource_impl.dart'
    as _i1016;
import 'package:social_mate_app/features/profile/data/repos/profile_repo_impl.dart'
    as _i589;
import 'package:social_mate_app/features/profile/domain/repos/profile_repo.dart'
    as _i792;
import 'package:social_mate_app/features/profile/domain/usecases/get_profile_usecase.dart'
    as _i694;
import 'package:social_mate_app/features/profile/domain/usecases/track_profile_view_usecase.dart'
    as _i241;
import 'package:social_mate_app/features/profile/presentation/bloc/profile_bloc.dart'
    as _i863;
import 'package:social_mate_app/features/story_viewer/data/remote/story_viewer_remote_datasource.dart'
    as _i954;
import 'package:social_mate_app/features/story_viewer/data/remote/story_viewer_remote_datasource_impl.dart'
    as _i852;
import 'package:social_mate_app/features/story_viewer/data/repos/story_viewer_repo_impl.dart'
    as _i249;
import 'package:social_mate_app/features/story_viewer/domain/repos/story_viewer_repo.dart'
    as _i351;
import 'package:social_mate_app/features/story_viewer/domain/usecases/get_author_stories_usecase.dart'
    as _i473;
import 'package:social_mate_app/features/story_viewer/presentation/bloc/story_viewer_bloc.dart'
    as _i206;
import 'package:social_mate_app/global/bloc/app_flow_bloc.dart' as _i845;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.factory<_i698.StoryBgControllerCubit>(
      () => _i698.StoryBgControllerCubit(),
    );
    gh.lazySingleton<_i454.SupabaseClient>(() => registerModule.supabaseClient);
    gh.lazySingleton<_i183.ImagePicker>(() => registerModule.imagePicker);
    gh.lazySingleton<_i689.RetryOptions>(() => registerModule.retryOptions);
    gh.lazySingleton<_i169.ToastService>(() => _i169.ToastService());
    gh.lazySingleton<_i954.StoryViewerRemoteDatasource>(
      () => _i852.StoryViewerRemoteDatasourceImpl(
        supabaseClient: gh<_i454.SupabaseClient>(),
      ),
    );
    gh.lazySingleton<_i164.GalleryLocalDataSource>(
      () => _i860.GalleryLocalDatasourceImpl(),
    );
    gh.lazySingleton<_i579.GalleryRepo>(
      () => _i925.GalleryRepoImpl(
        galleryLocalDataSource: gh<_i164.GalleryLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i915.StoryRemoteDataSource>(
      () => _i24.StoryRemoteDatasourceImpl(
        supabaseClient: gh<_i454.SupabaseClient>(),
      ),
    );
    gh.lazySingleton<_i250.AuthRemoteDataSource>(
      () => _i633.AuthRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i531.PostLocalDatasource>(
      () => _i84.PostLocalDatasourceImpl(),
    );
    gh.lazySingleton<_i284.PostRemoteDatasource>(
      () => _i134.PostRemoteDatasourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i285.CreatePostRemoteDataSource>(
      () => _i861.CreatePostRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i540.GetPhotosUsecase>(
      () => _i540.GetPhotosUsecase(galleryRepo: gh<_i579.GalleryRepo>()),
    );
    gh.lazySingleton<_i859.AuthListener>(
      () => _i859.AuthListener(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i762.InboxRemoteDataSource>(
      () => _i222.InboxRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i351.StoryViewerRepo>(
      () => _i249.StoryViewerRepoImpl(
        remoteDatasource: gh<_i954.StoryViewerRemoteDatasource>(),
      ),
    );
    gh.lazySingleton<_i358.PostRepo>(
      () => _i520.PostRepoImpl(
        gh<_i284.PostRemoteDatasource>(),
        gh<_i531.PostLocalDatasource>(),
      ),
    );
    gh.factory<_i183.ToggleDislikeUsecase>(
      () => _i183.ToggleDislikeUsecase(gh<_i358.PostRepo>()),
    );
    gh.factory<_i854.ToggleLikeUsecase>(
      () => _i854.ToggleLikeUsecase(gh<_i358.PostRepo>()),
    );
    gh.lazySingleton<_i817.GetPostsUsecse>(
      () => _i817.GetPostsUsecse(gh<_i358.PostRepo>()),
    );
    gh.lazySingleton<_i564.NotificationRemoteDataSource>(
      () => _i93.NotificationRemoteDataSourceImpl(
        gh<_i454.SupabaseClient>(),
        gh<_i689.RetryOptions>(),
      ),
    );
    gh.lazySingleton<_i845.AppFlowBloc>(
      () => _i845.AppFlowBloc(gh<_i859.AuthListener>()),
    );
    gh.lazySingleton<_i716.ProfileRemoteDatasource>(
      () => _i1016.ProfileRemoteDatasourceImpl(
        gh<_i454.SupabaseClient>(),
        gh<_i689.RetryOptions>(),
      ),
    );
    gh.lazySingleton<_i176.DiscoverPeopleRemoteDataSource>(
      () =>
          _i153.DiscoverPeopleRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i80.CreatePostRepo>(
      () => _i971.CreatePostRepoImpl(gh<_i285.CreatePostRemoteDataSource>()),
    );
    gh.lazySingleton<_i498.MediaPickerLocalDataSource>(
      () => _i67.MediaPickerLocalDataSourceImpl(gh<_i183.ImagePicker>()),
    );
    gh.lazySingleton<_i737.NotificationRepo>(
      () =>
          _i482.NotificationRepoImpl(gh<_i564.NotificationRemoteDataSource>()),
    );
    gh.lazySingleton<_i473.GetAuthorStoriesUseCase>(
      () => _i473.GetAuthorStoriesUseCase(
        repository: gh<_i351.StoryViewerRepo>(),
      ),
    );
    gh.lazySingleton<_i977.DiscoverPeopleRepo>(
      () => _i296.DiscoverPeopleRepoImpl(
        gh<_i176.DiscoverPeopleRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i590.StoryRepo>(
      () => _i444.StoryRepoImpl(
        storyRemoteDataSource: gh<_i915.StoryRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i358.AuthRepo>(
      () => _i375.AuthRepoImpl(gh<_i250.AuthRemoteDataSource>()),
    );
    gh.lazySingleton<_i525.SignInUsecase>(
      () => _i525.SignInUsecase(gh<_i358.AuthRepo>()),
    );
    gh.lazySingleton<_i424.SignUpUsecase>(
      () => _i424.SignUpUsecase(gh<_i358.AuthRepo>()),
    );
    gh.lazySingleton<_i516.GetNotificationsUseCase>(
      () => _i516.GetNotificationsUseCase(gh<_i737.NotificationRepo>()),
    );
    gh.factory<_i206.StoryViewerBloc>(
      () => _i206.StoryViewerBloc(
        getAuthorStoriesUseCase: gh<_i473.GetAuthorStoriesUseCase>(),
      ),
    );
    gh.lazySingleton<_i76.CreatePostUsecase>(
      () => _i76.CreatePostUsecase(gh<_i80.CreatePostRepo>()),
    );
    gh.lazySingleton<_i892.GetAuthorPostsUseCase>(
      () => _i892.GetAuthorPostsUseCase(gh<_i358.PostRepo>()),
    );
    gh.lazySingleton<_i792.ProfileRepo>(
      () => _i589.ProfileRepoImpl(gh<_i716.ProfileRemoteDatasource>()),
    );
    gh.factory<_i853.GalleryBloc>(
      () => _i853.GalleryBloc(getPhotosUsecase: gh<_i540.GetPhotosUsecase>()),
    );
    gh.lazySingleton<_i575.FollowUserUseCase>(
      () => _i575.FollowUserUseCase(gh<_i977.DiscoverPeopleRepo>()),
    );
    gh.lazySingleton<_i69.GetSuggestedUsersUseCase>(
      () => _i69.GetSuggestedUsersUseCase(gh<_i977.DiscoverPeopleRepo>()),
    );
    gh.lazySingleton<_i995.UnfollowUserUseCase>(
      () => _i995.UnfollowUserUseCase(gh<_i977.DiscoverPeopleRepo>()),
    );
    gh.lazySingleton<_i206.MediaPickerRepo>(
      () => _i842.MediaPickerRepoImpl(gh<_i498.MediaPickerLocalDataSource>()),
    );
    gh.lazySingleton<_i182.InboxRepository>(
      () => _i1040.InboxRepositoryImpl(
        gh<_i762.InboxRemoteDataSource>(),
        gh<_i454.SupabaseClient>(),
      ),
    );
    gh.factory<_i853.PostBloc>(
      () => _i853.PostBloc(
        gh<_i817.GetPostsUsecse>(),
        gh<_i854.ToggleLikeUsecase>(),
        gh<_i183.ToggleDislikeUsecase>(),
        gh<_i892.GetAuthorPostsUseCase>(),
      ),
    );
    gh.factory<_i694.GetProfileUsecase>(
      () => _i694.GetProfileUsecase(gh<_i792.ProfileRepo>()),
    );
    gh.factory<_i312.CreatePostBloc>(
      () => _i312.CreatePostBloc(gh<_i76.CreatePostUsecase>()),
    );
    gh.lazySingleton<_i691.SignOutUsecase>(
      () => _i691.SignOutUsecase(gh<_i358.AuthRepo>(), gh<_i358.PostRepo>()),
    );
    gh.lazySingleton<_i580.GetStoriesUseCase>(
      () => _i580.GetStoriesUseCase(gh<_i590.StoryRepo>()),
    );
    gh.lazySingleton<_i297.PickDocumentUsecase>(
      () => _i297.PickDocumentUsecase(gh<_i206.MediaPickerRepo>()),
    );
    gh.lazySingleton<_i838.PickImageFromCameraUsecase>(
      () => _i838.PickImageFromCameraUsecase(gh<_i206.MediaPickerRepo>()),
    );
    gh.lazySingleton<_i365.PickImageFromGalleryUsecase>(
      () => _i365.PickImageFromGalleryUsecase(gh<_i206.MediaPickerRepo>()),
    );
    gh.lazySingleton<_i1013.PickVideoFromCameraUsecase>(
      () => _i1013.PickVideoFromCameraUsecase(gh<_i206.MediaPickerRepo>()),
    );
    gh.lazySingleton<_i437.PickVideoFromGalleryUsecase>(
      () => _i437.PickVideoFromGalleryUsecase(gh<_i206.MediaPickerRepo>()),
    );
    gh.factory<_i834.NotificationBloc>(
      () => _i834.NotificationBloc(gh<_i516.GetNotificationsUseCase>()),
    );
    gh.lazySingleton<_i241.TrackProfileViewUseCase>(
      () => _i241.TrackProfileViewUseCase(gh<_i792.ProfileRepo>()),
    );
    gh.lazySingleton<_i23.GetOrCreateChatRoomUsecase>(
      () => _i23.GetOrCreateChatRoomUsecase(gh<_i182.InboxRepository>()),
    );
    gh.lazySingleton<_i300.SendMessageUsecase>(
      () => _i300.SendMessageUsecase(gh<_i182.InboxRepository>()),
    );
    gh.lazySingleton<_i869.StreamMessagesUsecase>(
      () => _i869.StreamMessagesUsecase(gh<_i182.InboxRepository>()),
    );
    gh.factory<_i419.DiscoverPeopleBloc>(
      () => _i419.DiscoverPeopleBloc(
        gh<_i69.GetSuggestedUsersUseCase>(),
        gh<_i575.FollowUserUseCase>(),
        gh<_i995.UnfollowUserUseCase>(),
      ),
    );
    gh.lazySingleton<_i44.DeleteChatRoomUsecase>(
      () => _i44.DeleteChatRoomUsecase(gh<_i182.InboxRepository>()),
    );
    gh.lazySingleton<_i46.StreamChatRoomsUsecase>(
      () => _i46.StreamChatRoomsUsecase(gh<_i182.InboxRepository>()),
    );
    gh.factory<_i1024.InboxBloc>(
      () => _i1024.InboxBloc(
        gh<_i46.StreamChatRoomsUsecase>(),
        gh<_i44.DeleteChatRoomUsecase>(),
      ),
    );
    gh.factory<_i200.StoryBloc>(
      () => _i200.StoryBloc(getStoriesUseCase: gh<_i580.GetStoriesUseCase>()),
    );
    gh.factory<_i863.ProfileBloc>(
      () => _i863.ProfileBloc(
        gh<_i694.GetProfileUsecase>(),
        gh<_i575.FollowUserUseCase>(),
        gh<_i995.UnfollowUserUseCase>(),
        gh<_i241.TrackProfileViewUseCase>(),
      ),
    );
    gh.factory<_i944.AuthBloc>(
      () => _i944.AuthBloc(
        gh<_i525.SignInUsecase>(),
        gh<_i424.SignUpUsecase>(),
        gh<_i691.SignOutUsecase>(),
      ),
    );
    gh.factory<_i76.MediaPickerBloc>(
      () => _i76.MediaPickerBloc(
        gh<_i838.PickImageFromCameraUsecase>(),
        gh<_i365.PickImageFromGalleryUsecase>(),
        gh<_i1013.PickVideoFromCameraUsecase>(),
        gh<_i437.PickVideoFromGalleryUsecase>(),
        gh<_i297.PickDocumentUsecase>(),
      ),
    );
    gh.factory<_i664.CommunicationBloc>(
      () => _i664.CommunicationBloc(
        gh<_i869.StreamMessagesUsecase>(),
        gh<_i300.SendMessageUsecase>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i124.RegisterModule {}
