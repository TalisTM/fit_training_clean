import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/modules/login/domain/errors/errors.dart';
import 'package:fit_training_clean/app/modules/login/domain/repositories/login_repository.dart';
import 'package:string_validator/string_validator.dart' as validator;

abstract class RecoverPasswordUsecase {
  Future<Either<FailureLogin, Unit>> call({required String email});
}

class RecoverPasswordUsecaseImpl implements RecoverPasswordUsecase {
  final LoginRepository repository;
  RecoverPasswordUsecaseImpl({required this.repository});

  @override
  Future<Either<FailureLogin, Unit>> call({required String email}) async {
    if (validator.isEmail(email)) {
      var result = await repository.recoverPassword(email: email);
      return result;
    } else {
      return Left(ErrorRecoverPassword(message: "Error recover passord"));
    }
  }
}
