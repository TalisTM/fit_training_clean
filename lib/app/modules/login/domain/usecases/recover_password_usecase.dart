import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/core/modules/connection/domain/usecases/has_connection_usecase.dart';
import 'package:fit_training_clean/app/core/utils/utils.dart';
import 'package:fit_training_clean/app/modules/login/domain/errors/errors.dart';
import 'package:fit_training_clean/app/modules/login/domain/repositories/login_repository.dart';
import 'package:string_validator/string_validator.dart' as validator;

abstract class RecoverPasswordUsecase {
  Future<Either<FailureLogin, Unit>> call({required String email});
}

class RecoverPasswordUsecaseImpl implements RecoverPasswordUsecase {
  final LoginRepository repository;
  final HasConnectionUsecase hasConnectionUsecase;
  RecoverPasswordUsecaseImpl({required this.repository, required this.hasConnectionUsecase});

  @override
  Future<Either<FailureLogin, Unit>> call({required String email}) async {
    String? hasConnection = await Utils.connection.hasConnection(hasConnectionUsecase);
    if (hasConnection != null) {
      return Left(ErrorRecoverPassword(message: hasConnection));
    }

    if (validator.isEmail(email)) {
      var result = await repository.recoverPassword(email: email);
      return result;
    } else {
      return Left(ErrorRecoverPassword(message: "Error recover passord"));
    }
  }
}
