// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginStore on _LoginStoreBase, Store {
  Computed<LoginCredentials>? _$credentialComputed;

  @override
  LoginCredentials get credential => (_$credentialComputed ??=
          Computed<LoginCredentials>(() => super.credential,
              name: '_LoginStoreBase.credential'))
      .value;
  Computed<bool>? _$isValidComputed;

  @override
  bool get isValid => (_$isValidComputed ??=
          Computed<bool>(() => super.isValid, name: '_LoginStoreBase.isValid'))
      .value;

  late final _$emailAtom =
      Atom(name: '_LoginStoreBase.email', context: context);

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$registerEmailStatusAtom =
      Atom(name: '_LoginStoreBase.registerEmailStatus', context: context);

  @override
  Status get registerEmailStatus {
    _$registerEmailStatusAtom.reportRead();
    return super.registerEmailStatus;
  }

  @override
  set registerEmailStatus(Status value) {
    _$registerEmailStatusAtom.reportWrite(value, super.registerEmailStatus, () {
      super.registerEmailStatus = value;
    });
  }

  late final _$passwordAtom =
      Atom(name: '_LoginStoreBase.password', context: context);

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  late final _$_LoginStoreBaseActionController =
      ActionController(name: '_LoginStoreBase', context: context);

  @override
  dynamic setEmail(String value) {
    final _$actionInfo = _$_LoginStoreBaseActionController.startAction(
        name: '_LoginStoreBase.setEmail');
    try {
      return super.setEmail(value);
    } finally {
      _$_LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setPassword(String value) {
    final _$actionInfo = _$_LoginStoreBaseActionController.startAction(
        name: '_LoginStoreBase.setPassword');
    try {
      return super.setPassword(value);
    } finally {
      _$_LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
email: ${email},
registerEmailStatus: ${registerEmailStatus},
password: ${password},
credential: ${credential},
isValid: ${isValid}
    ''';
  }
}
