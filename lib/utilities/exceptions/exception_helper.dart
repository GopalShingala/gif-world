// ignore_for_file: avoid_print



import 'package:gif_world/utilities/api_utilities/alert_massage_utils.dart';

import 'custom_exception.dart';
import 'exception_type.dart';

class ExceptionHelper {
  Exception handleExceptions(ExceptionType type) {
 
    switch (type) {
      case ExceptionType.NetworkException:
        return NetworkException(AlertMassageUtils.noInternetTitleMsg!);
        // ignore: dead_code
        break;
      case ExceptionType.TokenExpiredException:
        return TokenExpiredException(AlertMassageUtils.tokenExpiredTitleMsg!);
        // ignore: dead_code
        break;
      case ExceptionType.EmailAlreadyRegisterd:
        return EmailAlreadyRegisterdException(AlertMassageUtils.emailAlreadyRagisterd!);
      case ExceptionType.InavalidEmailorPassword:
        return InavalidEmailorPasswordException(AlertMassageUtils.invalidEmailAndPassword!);
      default:
        return HttpException(AlertMassageUtils.someThingWrongMsg!);
        // ignore: dead_code
        break;
    }
  }
}
