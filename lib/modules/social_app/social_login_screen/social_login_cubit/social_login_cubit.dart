import 'package:course_flutter/modules/social_app/social_login_screen/social_login_cubit/social_login_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(InitialSocialLoginStates());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  bool isSecure = true;
  IconData iconForPassword = Icons.visibility;

  void changeIcon() {
    isSecure = !isSecure;
    iconForPassword =
        (isSecure) ? Icons.visibility : Icons.visibility_off_outlined;
    emit(ShowPasswordSocialLoginStates());
  }

  /*void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoadingSocialLoginStates());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    ).then((value){
      print(value.user!.email);
      emit(SuccessfulSocialLoginStates());
    }).catchError((e){
      print(e.toString());
      emit(ErrorSocialLoginStates());
    });
  }*/
}
