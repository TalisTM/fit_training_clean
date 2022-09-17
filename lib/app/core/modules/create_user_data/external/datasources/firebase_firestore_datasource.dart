import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_training_clean/app/core/modules/auth/data/models/user_model.dart';
import 'package:fit_training_clean/app/core/modules/create_user_data/data/datasources/create_user_data_datasource.dart';

class FirebaseFirestoreUserDatasource implements CreateUserDataDatasouce {
  final FirebaseFirestore firestore;
  FirebaseFirestoreUserDatasource({required this.firestore});

  @override
  Future<UserModel> createUserData({required UserModel user}) async {
    //Buscar a lista de usuarios salvo no banco
    var listUser = await firestore.collection("user").get();
    //rodando a lista de usuarios do banco
    for (var u in listUser.docs) {
      //verificando se o uid do usuario ja foi salvo no banco
      if (u.id == user.uid) {
        //retornando o usuario do banco caso esteja salvo la
        return UserModel.fromMap(u.data());
      }
    }
    //salvando um novo usuario que ainda nao estava no banco
    await firestore.collection("user").doc(user.uid).set(user.toMap());
    //retornando usiaruo q foi salvo
    return user;
  }
}
