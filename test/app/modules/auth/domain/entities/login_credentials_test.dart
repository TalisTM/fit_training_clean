import 'package:fit_training_clean/app/modules/auth/domain/entities/login_credentials.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  

  group("Verificar se os campos são validos,", () {
    test("email e senha", () {
      expect(
        LoginCredentials.withEmailAndPassword(email: "", password: "1234").isValidEmail,
        equals(false)
      );

      expect(
        LoginCredentials.withEmailAndPassword(email: "dgfdsgsdfg", password: "1234").isValidEmail,
        equals(false)
      );

      expect(
        LoginCredentials.withEmailAndPassword(email: "12341", password: "1234").isValidEmail,
        equals(false)
      );

      expect(
        LoginCredentials.withEmailAndPassword(email: "talis@gmail.com", password: "1234").isValidEmail,
        equals(true)
      );

      expect(
        LoginCredentials.withEmailAndPassword(email: "talis@gmail.com", password: "").isValidPassword,
        equals(false)
      );

      expect(
        LoginCredentials.withEmailAndPassword(email: "talis@gmail.com", password: "123").isValidPassword,
        equals(false)
      );

      expect(
        LoginCredentials.withEmailAndPassword(email: "talis@gmail.com", password: "123456").isValidPassword,
        equals(true)
      );
    });

    test("google", () {
      expect(
        LoginCredentials.withGoogle(idToken: "", accessToken: "").isvalidIdToken,
        equals(false)
      );

      expect(
        LoginCredentials.withGoogle(idToken: "534534-35434-35534", accessToken: "").isvalidIdToken,
        equals(true)
      );

      expect(
        LoginCredentials.withGoogle(idToken: "", accessToken: "").isvalidAccessToken,
        equals(false)
      );

      expect(
        LoginCredentials.withGoogle(idToken: "", accessToken: "5343459-53453-2555").isvalidAccessToken,
        equals(true)
      );
    });
  });
}