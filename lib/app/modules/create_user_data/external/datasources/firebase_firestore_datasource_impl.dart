import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_training_clean/app/core/data/models/user_model.dart';
import 'package:fit_training_clean/app/modules/create_user_data/data/datasources/create_user_data_datasource.dart';

class FirebaseFirestoreDatasourceImpl implements CreateUserDataDatasouce {
  final FirebaseFirestore firestore;
  FirebaseFirestoreDatasourceImpl({required this.firestore});

  @override
  Future<bool> checkUserExists({required String userId}) async {
    var result = await firestore.collection("user").get();

    for (var user in result.docs) {
      if (user.data()["uid"] == userId) {
        return true;
      }
    }
    return false;
  }

  @override
  Future<void> saveNewUser({required UserModel user}) async {
    await firestore.collection("user").doc(user.uid).set(user.toMap());
  }

  @override
  Future<UserModel> fetchExistingUser({required String userId}) async {
    var result = await firestore.collection("user").doc(userId).get();

    UserModel user = UserModel.fromMap(result.data()!);

    return user;
  }
}
