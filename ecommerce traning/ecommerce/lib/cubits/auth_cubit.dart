// cubits/auth_cubit.dart
import 'package:ecommerce/services/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthState {
  final bool isLoading;
  final String? errorMessage;

  AuthState({this.isLoading = false, this.errorMessage});
}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(ApiService of) : super(AuthState()); 


  Future<void> login(String email, String password) async {
    emit(AuthState(isLoading: true));

    try {
      // Handle successful login (e.g., save token)
      emit(AuthState());
    } on AuthenticationException catch (e) {
      emit(AuthState(errorMessage: e.message));
    } on ServerException catch (e) {
      emit(AuthState(errorMessage: e.message));
    } on NetworkException catch (e) {
      emit(AuthState(errorMessage: e.message));
    } catch (e) {
      emit(AuthState(errorMessage: "An unexpected error occurred."));
    }
  }
}