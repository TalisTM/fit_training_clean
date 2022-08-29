// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recover_password_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RecoverPasswordStore on _RecoverPasswordStoreBase, Store {
  late final _$emailAtom =
      Atom(name: '_RecoverPasswordStoreBase.email', context: context);

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

  late final _$statusAtom =
      Atom(name: '_RecoverPasswordStoreBase.status', context: context);

  @override
  Status get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(Status value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  late final _$failureTextAtom =
      Atom(name: '_RecoverPasswordStoreBase.failureText', context: context);

  @override
  String? get failureText {
    _$failureTextAtom.reportRead();
    return super.failureText;
  }

  @override
  set failureText(String? value) {
    _$failureTextAtom.reportWrite(value, super.failureText, () {
      super.failureText = value;
    });
  }

  late final _$_RecoverPasswordStoreBaseActionController =
      ActionController(name: '_RecoverPasswordStoreBase', context: context);

  @override
  void setEmail(String value) {
    final _$actionInfo = _$_RecoverPasswordStoreBaseActionController
        .startAction(name: '_RecoverPasswordStoreBase.setEmail');
    try {
      return super.setEmail(value);
    } finally {
      _$_RecoverPasswordStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setStatus(Status value) {
    final _$actionInfo = _$_RecoverPasswordStoreBaseActionController
        .startAction(name: '_RecoverPasswordStoreBase.setStatus');
    try {
      return super.setStatus(value);
    } finally {
      _$_RecoverPasswordStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFailureText(String value) {
    final _$actionInfo = _$_RecoverPasswordStoreBaseActionController
        .startAction(name: '_RecoverPasswordStoreBase.setFailureText');
    try {
      return super.setFailureText(value);
    } finally {
      _$_RecoverPasswordStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
email: ${email},
status: ${status},
failureText: ${failureText}
    ''';
  }
}
