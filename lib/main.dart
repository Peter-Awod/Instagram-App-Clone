import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_observer.dart';
import 'firebase_options.dart';
import 'layouts/home_layout/home_layout.dart';
import 'modules/login/login.dart';
import 'shared/components/components.dart';
import 'shared/components/constants.dart';
import 'shared/cubit/main_cubit.dart';
import 'shared/cubit/main_states.dart';
import 'shared/cubit/social_cubit.dart';
import 'shared/network/local/app_cache_helper.dart';
import 'shared/styles/themes.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('On background message');
  print(message.data.toString());
  showToast(msg: 'On background message', status: MsgState.SUCCESS);
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Bloc.observer = MyBlocObserver();

  await CacheHelper.init();

  ///////////////////////////////////


  var token=await FirebaseMessaging.instance.getToken();
  print('Token      : ${token}');

  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    print(event.notification.toString());
    showToast(msg: 'On Message', status: MsgState.SUCCESS);

  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    print(event.notification!.toMap());
    showToast(msg: 'On Message Opened App', status: MsgState.SUCCESS);


  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  /////////////////////////////////
  Widget startPoint;

  bool? isDark = CacheHelper.getData(key: 'isDark');



// //////////////////////////

  uId = CacheHelper.getData(key: 'uId');
  if(uId!=null){
    startPoint = HomeLayout();
  }else{
    startPoint = SocialLoginScreen();
  }

  if(isDark==null){
    isDark =false;
  }

// //////////////////////////
  runApp(MyApp(
    isDark: isDark,
    startPoint: startPoint,
  ));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startPoint;
  const MyApp({required this.isDark, required this.startPoint});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) {
            return MainCubit()
              ..changeAppMode(
                fromShared: isDark,
              );
          },
        ),

        BlocProvider(
          create: (BuildContext context) {
            return SocialCubit()
              ..getUserInfo()
              ..getPosts();
          },
        ),

      ],
      child: BlocConsumer<MainCubit, AppMainStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: MainCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            home: startPoint,
          );
        },
      ),
    );
  }
}