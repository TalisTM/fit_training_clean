import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_training_clean/app/modules/create_user_data/data/datasources/create_user_data_datasource.dart';
import 'package:fit_training_clean/app/modules/create_user_data/external/datasources/firebase_firestore_datasource_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class FirebaseFirestoreMock extends Mock implements FirebaseFirestore {}

void main() {
  FirebaseFirestore instance;
  // ignore: unused_local_variable
  CreateUserDataDatasouce datasouce;

  setUp(() {
    instance = FirebaseFirestoreMock();
    datasouce = FirebaseFirestoreDatasourceImpl(instance: instance);
  });

  group("Quando o datasource.checkUserExists() for chamado,", () {
    test("Deve retornar um bool", () async {
      // when(() => firestore.collection("user").get(),).thenAnswer((_) async => );
    });
  });
}
