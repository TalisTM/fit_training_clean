import 'package:fit_training_clean/app/modules/auth/domain/entities/google_authentication_entity.dart';

class GoogleAuthenticationModel extends GoogleAuthenticationEntity {
  GoogleAuthenticationModel({
    required String idToken,
    required String accessToken,
  }) : super(
          idToken: idToken,
          accessToken: accessToken,
        );
}
