import 'package:fit_training_clean/app/core/modules/connection/domain/usecases/has_connection_usecase.dart';

class Connection {
  const Connection();

  Future<bool> hasConnection(HasConnectionUsecase hasConnectionUsecase) async {
    var result = await hasConnectionUsecase();
    return result.fold(
      (_) => false,
      (hasConnection) => hasConnection,
    );
  }
}
