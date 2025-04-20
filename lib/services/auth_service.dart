// auth_service.dart (simplifié)
class AuthService {
  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    return email == "test@obesmart.com" && password == "123456";
  }
}