import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final _storage = const FlutterSecureStorage();

  static const _keyToken = 'access_token';
  static const _keyUserId = 'user_id';

  Future<void> saveToken(String token) async {
    await _storage.write(key: _keyToken, value: token);
  }

  Future<void> saveUserId(int userId) async {
    await _storage.write(key: _keyUserId, value: userId.toString());
  }

  Future<String?> readToken() async {
    return await _storage.read(key: _keyToken);
  }

  Future<int?> readUserId() async {
    final val = await _storage.read(key: _keyUserId);
    return val == null ? null : int.tryParse(val);
  }

  Future<void> clearAll() async {
    await _storage.delete(key: _keyToken);
    await _storage.delete(key: _keyUserId);
  }
}
