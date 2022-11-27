import 'package:dartz/dartz.dart';
import 'package:ecomerce/Data/Network/failure.dart';
import 'package:ecomerce/Presentations/resources/string_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum DataSource {
  //FIREBASE EXCEPTIONS
  INVALID_CREDENTIAL,
  NETWORK_ERROR,
  USER_DISABLED,
  INAVLID_VERIFICATION_ID,
  INVALID_VARIFICATION_CODE,
  TOO_MANY_REQUESTS,
  DEFAULT
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.INVALID_CREDENTIAL:
        return Failure(responseCodes.INVALID_CREDENTIAL,
            responseMessages.INVALID_CREDENTAIL);
      case DataSource.NETWORK_ERROR:
        return Failure(
            responseCodes.NETWORK_ERROR, responseMessages.NETWORK_ERROR);
      case DataSource.USER_DISABLED:
        return Failure(
            responseCodes.DISABLED_USER, responseMessages.DISABLED_USER);
      case DataSource.INVALID_VARIFICATION_CODE:
        return Failure(responseCodes.INVALID_VERIFICATION_CODE,
            responseMessages.INVALID_VERIFICATION_CODE);
      case DataSource.INAVLID_VERIFICATION_ID:
        return Failure(responseCodes.INVALID_VERIFICATION_ID,
            responseMessages.INVALID_VERIFICATION_ID);
      case DataSource.TOO_MANY_REQUESTS:
        return Failure(responseCodes.TOO_MANY_REQUESTS,
            responseMessages.TOO_MANY_REQUESTS_MESSAGE);
      default:
        return Failure(responseCodes.DEFAULT, responseMessages.DEFAULT);
    }
  }
}

class ErrorHandler implements Exception {
  late Failure failure;
  ErrorHandler(dynamic error) {
    if (error is FirebaseAuthException) {
      failure = handleFirebaseError(error);
    } else {
      failure = DataSource.DEFAULT.getFailure();
    }
  }
  Failure handleFirebaseError(FirebaseAuthException error) {
    switch (error.code) {
      case AppStrings.invalid_verification_id:
        return DataSource.INAVLID_VERIFICATION_ID.getFailure();
      case AppStrings.network_error:
        return DataSource.NETWORK_ERROR.getFailure();
      case AppStrings.invalid_verification_code:
        return DataSource.INVALID_VARIFICATION_CODE.getFailure();
      case AppStrings.disabled_user:
        return DataSource.USER_DISABLED.getFailure();
      case AppStrings.invalid_credential:
        return DataSource.INVALID_CREDENTIAL.getFailure();
      case AppStrings.too_many_requests:
        return DataSource.TOO_MANY_REQUESTS.getFailure();
      default:
        return DataSource.DEFAULT.getFailure();
    }
  }
}

class responseCodes {
  //firebase auth exeption codes
  static const String INVALID_CREDENTIAL = AppStrings.invalid_credential;
  static const String NETWORK_ERROR = AppStrings.network_error;
  static const String INVALID_VERIFICATION_ID =
      AppStrings.invalid_verification_id;
  static const String INVALID_VERIFICATION_CODE =
      AppStrings.invalid_verification_code;
  static const String DISABLED_USER = AppStrings.disabled_user;
  static const String TOO_MANY_REQUESTS = AppStrings.too_many_requests;

//local status codes
  static const int DEFAULT = -1;
}

class responseMessages {
  static const String INVALID_CREDENTAIL =
      AppStrings.invalid_credential_message;
  static const String NETWORK_ERROR = AppStrings.network_error_message;
  static const String INVALID_VERIFICATION_ID =
      AppStrings.invalid_verification_id_message;
  static const String INVALID_VERIFICATION_CODE =
      AppStrings.invalid_verification_code_message;
  static const String DISABLED_USER = AppStrings.disable_user_message;
  static const String TOO_MANY_REQUESTS_MESSAGE =
      AppStrings.too_many_requests_message;

  static const String DEFAULT = AppStrings.default_exception_message;
}
