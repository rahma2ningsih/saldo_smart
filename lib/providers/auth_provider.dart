import 'package:appwrite/models.dart' as models;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../utils/provider.dart';
import '../models/user_profile_model.dart';
import '../services/auth_service.dart';
import 'user_profile_provider.dart';

part 'auth_provider.g.dart';

@riverpod
class Auth extends _$Auth {
  late final AuthService _authService =
      AuthService(account: ref.read(appwriteAccountProvider));
  late final UserProfileNotifier _userProfileNotifier =
      ref.read(userProfileNotifierProvider.notifier);

  @override
  Future<models.User?> build() async {
    return checkSession();
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    final result = await _authService.login(email: email, password: password);
    if (result.isSuccess) {
      state = AsyncValue.data(result.resultValue);
    } else {
      state = AsyncValue.error(result.errorMessage!, StackTrace.current);
      resetState();
    }
  }

  Future<void> register(
      String email, String password, String nama,String nomor,String alamat, String kota, String provinsi, String kodepos,) async {
    state = const AsyncValue.loading();

    final authResult =
        await _authService.createAccount(email: email, password: password, name: nama);

    if (authResult.isSuccess) {
      final userId = authResult.resultValue?.$id ?? '';
      final userProfile = UserProfile(
        id: userId,
        nama: nama,
        email: email,
        nomor: nomor,
        alamat: alamat,
        kota: kota,
        provinsi: provinsi,
        kodePos: kodepos,
        logo: 'kosong',
      );

      await _userProfileNotifier.createUserProfile(userProfile);

      await login(email, password);
    } else {
      state = AsyncValue.error(authResult.errorMessage!, StackTrace.current);
      resetState();
    }
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    final result = await _authService.logout();
    if (result.isSuccess) {
      state = const AsyncValue.data(null);
    } else {
      state = AsyncValue.error(result.errorMessage!, StackTrace.current);
      resetState();
    }
  }

  void resetState() async {
    Future.delayed(const Duration(seconds: 1), () {
      state = const AsyncValue.data(null);
    });
  }

  Future<models.User?> checkSession() async {
    try {
      final sessionResult = await _authService.getCurrentSession();

      if (sessionResult.isSuccess) {
        final userResult = await _authService.getCurrentUser();
        if (userResult.isSuccess) {
          return userResult.resultValue; 
        }
      }
    } catch (e) {
      print('Error checking session: $e');
    }
    return null;
  }
}