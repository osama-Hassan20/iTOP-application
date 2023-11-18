import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/components.dart';
import '../../shared/network/local/cach_helper.dart';
import '../login/login_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(BuildContext context) => RegisterCubit() ,
      child: BlocConsumer<RegisterCubit , RegisterStates>(
        listener: (BuildContext context, Object? state) {
          if (state is CreateSuccessState)
          {
            CacheHelper.saveData(
              key: 'uId',
              value: state.uId,
            ).then((value) {
              print(state.uId);
              print('${CacheHelper.getData(key:'uId')}');
              navigateAndFinish(context, LoginScreen());
            });
            navigateAndFinish(context, LoginScreen());
          }
        },
        builder: (context , state)
        {
          return Scaffold(
            body: Stack(
              children: [
                Container(
                  width: double.infinity,
                  // padding: EdgeInsets.only(top: 30,),
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
                          'REGISTER',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Register now to to communicate with friends',
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
                                  controller: nameController,
                                  type: TextInputType.name,
                                  label: 'User Name',
                                  prefix: Icons.person,
                                  validate: (String? value){
                                    if(value!.isEmpty){
                                      return'please enter your name';
                                    }
                                    return null;
                                  }
                              ),
                              const SizedBox(
                                height: 20,
                              ),
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
                              const SizedBox(
                                height: 20,
                              ),
                              defaultFormField(
                                  controller: passwordController,
                                  type: TextInputType.emailAddress,
                                  label: 'Password',
                                  prefix: Icons.lock_outline,
                                  suffix: RegisterCubit.get(context).suffix,
                                  onSubmit: (value){},
                                  isPassword: RegisterCubit.get(context).isPassword,
                                  suffixPressed: (){
                                    RegisterCubit.get(context).changePasswordVisibility();
                                  },
                                  validate: (String? value){
                                    if(value!.isEmpty){
                                      return'please enter your password';
                                    }
                                    if (value.length < 7) {
                                      return "password is too short";
                                    }
                                    return null;
                                  }
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              defaultFormField(
                                  controller: phoneController,
                                  type: TextInputType.phone,
                                  label: 'phone',
                                  prefix: Icons.phone,
                                  validate: (String? value){
                                    if(value!.isEmpty){
                                      return'please enter your phone';
                                    }
                                    return null;
                                  }
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Center(
                                child: ConditionalBuilder(
                                  condition: state is! RegisterLoadingState,
                                  builder:(context) => defaultButton(
                                    function:(){
                                      // CacheHelper.removeDate(key: 'token');
                                      if(formKey.currentState!.validate()){
                                        RegisterCubit.get(context).userRegister(
                                          name: nameController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                          phone: phoneController.text,
                                        );
                                      }

                                    },
                                    text: 'register',
                                    isUpperCase: true,

                                  ),
                                  fallback:(context) => const CircularProgressIndicator() ,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Do have an account?',
                                  ),
                                  defaultTextButton(
                                    function: (){

                                      navigateTo(context, LoginScreen());
                                    },
                                    text: 'login',
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

