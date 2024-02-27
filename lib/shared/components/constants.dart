
import 'package:flutter/material.dart';

import '../../modules/login/login.dart';
import '../network/local/app_cache_helper.dart';
import 'components.dart';


const defaultColor = Colors.blue;


// logout button with uId
void logOut({required BuildContext context})
{

      CacheHelper.removeToken(key: 'uId').then((value){
        if(value!){
          pushAndRemoveNavigateTo(context, SocialLoginScreen());
        }
      });
}
// logout button with token
void signOut({required BuildContext context})
{

      CacheHelper.removeToken(key: 'token').then((value){
        if(value!){
          pushAndRemoveNavigateTo(context, SocialLoginScreen());
        }
      });
}


// String? token='';

String? uId='';