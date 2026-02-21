import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:injectable/injectable.dart';
import 'package:social_mate_app/core/services/auth_listener.dart';
import 'package:social_mate_app/core/services/fcm_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'app_flow_state.dart';

@LazySingleton()
class AppFlowBloc extends Cubit<AppFlowState> {
  final AuthListener authListener;
  final FcmService fcmService;

  late final StreamSubscription _sub;

  AppFlowBloc(this.authListener, this.fcmService)
    : super(
        authListener.currentSession != null
            ? AppFlowState(
                status: AppFlowStatus.authenticated,
                session: authListener.currentSession,
              )
            : const AppFlowState(status: AppFlowStatus.unknown),
      ) {
    _sub = authListener.listen().listen((data) async {
      final event = data.event;
      final session = data.session;

      if (session != null) {
        emit(
          AppFlowState(status: AppFlowStatus.authenticated, session: session),
        );
        // Initialize FCM on login
        fcmService.init();
      } else {
        if (event == AuthChangeEvent.initialSession ||
            event == AuthChangeEvent.signedOut) {
          emit(const AppFlowState(status: AppFlowStatus.unauthenticated));
          // Delete FCM token on logout
          if (event == AuthChangeEvent.signedOut) {
            fcmService.deleteToken();
          }
        }
      }
    });
    
    FlutterNativeSplash.remove();
  }

  @override
  Future<void> close() {
    _sub.cancel();
    return super.close();
  }
}
