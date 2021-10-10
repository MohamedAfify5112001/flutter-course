import 'package:bloc/bloc.dart';
import 'package:course_flutter/modules/social_app/social_register_screen/social_register_cubits/social_register_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates>{
  SocialRegisterCubit() : super(InitialSocialRegisterStates());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);
  bool isSecure = true;
  IconData iconForPassword = Icons.visibility;
  void changeIcon(){
    isSecure = !isSecure;
    iconForPassword = (isSecure) ? Icons.visibility : Icons.visibility_off_outlined ;
    emit(ShowPasswordSocialRegisterStates());
  }

  /*void userRegister({
     required String email
    , required String password,
      required String phone
    , required String name,
  }){
    emit(LoadingSocialRegisterStates());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    ).then((value){
      print(value.user!.email);
      print(value.user!.uid);
      print(SuccessfulSocialRegisterStates());
    }).catchError((onError){
      print(onError.toString());
      emit(ErrorSocialRegisterStates());
    });

}*/

}