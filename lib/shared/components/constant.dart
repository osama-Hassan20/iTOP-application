import 'package:bloc/bloc.dart';
import 'package:social_application/screens/login/login_screen.dart';
import 'package:social_application/shared/components/components.dart';

import '../network/local/cach_helper.dart';

String? uId;

void signOut(context) {
  CacheHelper.removeDate(key: 'uId',).then((value) {
    if(value!){
      navigateAndFinish(context, LoginScreen());
    }
  });
}


class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }
}