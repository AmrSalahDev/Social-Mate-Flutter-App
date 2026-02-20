import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:retry/retry.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  SupabaseClient get supabaseClient => Supabase.instance.client;

  @lazySingleton
  ImagePicker get imagePicker => ImagePicker();

  @lazySingleton
  RetryOptions get retryOptions => RetryOptions(
    maxAttempts: 5,
    delayFactor: const Duration(seconds: 1),
    maxDelay: const Duration(seconds: 8),
  );

  @lazySingleton
  Logger get logger => Logger(
    filter: null, // Use the default LogFilter (-> only log in debug mode)
    printer: PrettyPrinter(), // Use the PrettyPrinter to format and print log
    output: null, // Use the default LogOutput (-> send everything to console)
  );
}
