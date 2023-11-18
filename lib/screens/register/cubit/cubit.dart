import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/models/user_model.dart';
import 'package:social_application/screens/register/cubit/states.dart';


class RegisterCubit extends Cubit<RegisterStates>
{
  RegisterCubit():super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);


  void userRegister({
    required String name ,
    required String email ,
    required String password ,
    required String phone ,

  })
  {
    emit(RegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email: email,
        password: password,

    ).then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      print('start userCreate');
      userCreate(
          name: name,
          email: email,
          phone: phone,
          uId: value.user!.uid,
      );
    }).catchError((error){
      emit(RegisterErrorState(error.toString()));
    });
  }


  void userCreate({
    required String? name ,
    required String email ,
    required String phone ,
    required String uId ,
  }){
    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      bio: 'Write Your bio ...',
      image: 'https://img.freepik.com/free-vector/hand-drawn-flat-design-salat-illustration_23-2149283922.jpg?w=740&t=st=1697145530~exp=1697146130~hmac=e92359dbc880aa0e1bba202ee65f06f1cf721efb2df9ee9de4019046003cd550',
      coverImage: 'https://img.freepik.com/free-photo/beautiful-serene-mosque-night-blessed-month-ramadan-illuminated-generative-ai_1258-166479.jpg?t=st=1697184735~exp=1697188335~hmac=f5c9553d872c2a5b1d9da2b8ccf564a9da667feb793e56433214ae5b6050026f&w=1380',
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('user')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
          emit(CreateSuccessState(uId));
    }).catchError((error){
      emit(CreateErrorState(error.toString()));
      print(error.toString());
    });

  }


  bool isPassword = true;
  IconData suffix = Icons.visibility_off_outlined;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;

    emit(RChangePasswordVisibilityState());
      }
}