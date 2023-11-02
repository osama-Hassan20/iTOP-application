import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/screens/login/cubit/states.dart';


class LoginCubit extends Cubit<LoginStates>{
  LoginCubit():super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);


  void userLogin({
    required String email ,
    required String password ,

  })
  {
    emit(LoginLoadingState());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(
        email: email,
      password: password,
    ).then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      emit(LoginSuccessState(value.user!.uid));
    }).catchError((error){
      emit(LoginErrorState(error.toString()));
    });
    // DioHelper.postData(
    //     url: LOGIN,
    //     data: {
    //       'email':email,
    //       'password':password,
    //     },
    // ).then((value) {
    //   print(value?.data);
    //   loginModel = LoginModel.fromJson(value?.data);
    //
    //   emit(LoginSuccessState(loginModel!));
    // }).catchError((error){
    //   print('error ====================');
    //   print(error.toString());
    //   print('error ====================');
    //
    //   emit(LoginErrorState(error.toString()));
    //
    // });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;

    emit(ChangePasswordVisibilityState());
      }
}