import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modules/add_post/add_post_screen.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/cubit/social_cubit.dart';
import '../../shared/cubit/social_states.dart';
import '../../shared/styles/icon_broken.dart';


class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is BottomNavAddPostState){
          pushNavigateTo(context, AddPostScreen());
        }
      },
      builder: (context, state) {
        SocialCubit cubitVar = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubitVar.titles[cubitVar.currentIndex]),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(IconBroken.Notification),
              ),
              IconButton(
                onPressed: () {
                  logOut(context: context);
                },
                icon: Icon(IconBroken.Logout),
              ),
            ],
          ),
          body: cubitVar.screens[cubitVar.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
           currentIndex: cubitVar.currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Chat),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Upload),
                label: 'Post',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Location),
                label: 'Users',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Setting),
                label: 'Settings',
              ),
            ],
            onTap: (index) {
              cubitVar.changeIndex(index);
            },
          ),
        );
      },
    );
  }
}
