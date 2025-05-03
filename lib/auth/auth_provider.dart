import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_repository.dart';

final authRepoProvider = Provider<AuthRepository>((_) => AuthRepository());

final authStateProvider =
StreamProvider<User?>((ref) => ref.watch(authRepoProvider).authStateChanges());
