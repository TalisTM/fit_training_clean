import 'package:fit_training_clean/app/core/modules/connection/domain/usecases/has_connection_usecase.dart';

class Connection {
  const Connection();

  Future<String?> hasConnection(HasConnectionUsecase hasConnectionUsecase) async {
    var result = await hasConnectionUsecase();
    return result.fold(
      (_) => "Verifique sua conexão e tente novamente",
      (hasConnection) {
        if (!hasConnection) {
          return "Verifique sua conexão e tente novamente";
        }
        return null;
      },
    );
  }
}
