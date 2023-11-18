import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/layout/cubit/cubit.dart';
import 'package:social_application/screens/splash_screen/splash_screen.dart';
import '../../shared/components/components.dart';
import '../../shared/network/local/cach_helper.dart';
import '../register/register_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';



class LoginScreen extends StatelessWidget {


  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit , LoginStates>(

        listener: (BuildContext context, Object? state) {
          if(state is LoginErrorState){
            ShowToast(
                text: state.error,
                state: ToastState.ERROR
            );
          }
          if (state is LoginSuccessState)
          {

            CacheHelper.saveData(
              key: 'uId',
              value: state.uId,
            ).then((value) {
              print(state.uId);
              print('${CacheHelper.getData(key:'uId')}');
              navigateAndFinish(context, SplashScreen());
            });
            SocialCubit.get(context).getUserData();
            ShowToast(
                text: 'Login Success',
                state: ToastState.SUCCESS
            );
          }
        },
        builder: (BuildContext context, state)
        {
          return Scaffold(
            body: Stack(
              children: [
                Container(
                  width: double.infinity,
                decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Colors.teal,
                      Color(0xFF43658b),

                    ]
                ),
              ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 80,left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'login now to communicate with friends',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40),
                      )
                    ),
                    margin: EdgeInsets.only(top: 200),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding:const EdgeInsets.all(20),
                          child: Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [


                                defaultFormField(
                                    controller: emailController,
                                    type: TextInputType.emailAddress,
                                    label: 'Email Address',
                                    prefix: Icons.email_outlined,
                                    validate: (String? value){
                                      if(value!.isEmpty){
                                        return'please enter your email address';
                                      }
                                      return null;
                                    }
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                defaultFormField(
                                    controller: passwordController,
                                    type: TextInputType.emailAddress,
                                    label: 'Password',
                                    prefix: Icons.lock_outline,
                                    suffix: LoginCubit.get(context).suffix,
                                    isPassword: LoginCubit.get(context).isPassword,
                                    suffixPressed: (){
                                      LoginCubit.get(context).changePasswordVisibility();
                                    },
                                    onSubmit: (value){
                                      // if(formKey.currentState!.validate()){
                                      //   LoginCubit.get(context).userLogin(
                                      //     email: emailController.text,
                                      //     password: passwordController.text,);
                                      // }
                                    },
                                    validate: (String? value){
                                      if(value!.isEmpty){
                                        return'password is too short';
                                      }
                                      return null;
                                    }
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Center(
                                  child: ConditionalBuilder(
                                    condition: state is! LoginLoadingState,
                                    builder:(context) => defaultButton(
                                      function:(){
                                        if(formKey.currentState!.validate()){
                                          LoginCubit.get(context).userLogin(
                                            email: emailController.text,
                                            password: passwordController.text,);
                                        }

                                      },
                                      text: 'login',
                                      isUpperCase: true,

                                    ),
                                    fallback:(context) => CircularProgressIndicator() ,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Don\'t have an account?',
                                    ),
                                    defaultTextButton(
                                      function: (){

                                        navigateTo(context, RegisterScreen());
                                      },
                                      text: 'register',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

              ],
            ),
          );
        },

      ),
    );
  }
}
