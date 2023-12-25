import 'package:injectable/injectable.dart';

abstract class AuthRepository {
  Future<String> testString();
  Future<String> signIn(String email, String password);
  Future<String> signUp(String email, String password);
  Future<void> signOut();
}

@Injectable(as: AuthRepository)
class SupabaseAuth implements AuthRepository { 
  @override
  Future<String> testString() {
    return Future.delayed(
      const Duration(seconds: 1),
      () => 'Test SupabaseAuth'
    );
  }

  @override
  Future<String> signIn(String email, String password) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<String> signUp(String email, String password) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}

@Injectable(as: AuthRepository)
class FirebaseAuth implements AuthRepository {
  @override
  Future<String> testString() {
    Future.delayed(
      const Duration(seconds: 1),
      () => 'Test FirebaseAuth'
    );
    throw UnimplementedError();
  }

  @override
  Future<String> signIn(String email, String password) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<String> signUp(String email, String password) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}