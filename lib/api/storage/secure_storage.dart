import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

const _keyId = 'KEY_ID';
const _keyTokenType = 'KEY_TOKEN_TYPE';
const _keyAccessToken = 'KEY_ACCESS_TOKEN';
const _keyExpiresIn = 'KEY_EXPIRES_IN';
const _keyRefreshToken = 'KEY_REFRESH_TOKEN';

abstract class SecureStorage {
  Future<String?> get id;

  Future<String?> get tokenType;

  Future<String?> get accessToken;

  Future<String?> get expiresIn;

  Future<String?> get refreshToken;

  Future<void> storeId(String id);

  Future<void> storeTokenType(String tokenType);

  Future<void> storeAccessToken(String accessToken);

  Future<void> storeExpiresIn(String expiresIn);

  Future<void> storeRefreshToken(String refreshToken);

  Future<void> clearAllStorage();
}

@Singleton(as: SecureStorage)
class SecureStorageImpl extends SecureStorage {
  final FlutterSecureStorage _storage;

  SecureStorageImpl(this._storage);

  @override
  Future<String?> get id => _storage.read(key: _keyId);

  @override
  Future<String?> get tokenType => _storage.read(key: _keyTokenType);

  @override
  Future<String?> get accessToken => _storage.read(key: _keyAccessToken);

  @override
  Future<String?> get expiresIn => _storage.read(key: _keyExpiresIn);

  @override
  Future<String?> get refreshToken => _storage.read(key: _keyRefreshToken);

  @override
  Future<void> storeId(String id) {
    return _storage.write(key: _keyId, value: id);
  }

  @override
  Future<void> storeTokenType(String tokenType) {
    return _storage.write(key: _keyTokenType, value: tokenType);
  }

  @override
  Future<void> storeAccessToken(String accessToken) {
    return _storage.write(key: _keyAccessToken, value: accessToken);
  }

  @override
  Future<void> storeExpiresIn(String expiresIn) {
    return _storage.write(key: _keyExpiresIn, value: '$expiresIn');
  }

  @override
  Future<void> storeRefreshToken(String refreshToken) {
    return _storage.write(key: _keyRefreshToken, value: refreshToken);
  }

  @override
  Future<void> clearAllStorage() {
    return _storage.deleteAll();
  }
}
