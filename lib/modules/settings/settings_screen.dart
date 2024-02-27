import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';
import '../../shared/cubit/social_cubit.dart';
import '../../shared/cubit/social_states.dart';
import '../../shared/styles/icon_broken.dart';
import '../edit_profile/edit_profile_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var user=SocialCubit.get(context).userModel!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 220,
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(
                            '${user.cover}',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 10),
                    child: CircleAvatar(
                      radius: 65,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          '${user.profile}',
                        ),
                        radius: 62,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 10,end: 10,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // name and bio
                  Text(
                    '${user.name}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    ' ${user.bio}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  //info
                  Row(
                    children: [
                      //posts
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text(
                                '214',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: Colors.blueGrey[900],
                                    ),
                              ),
                              Text(
                                'Posts',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ),
                      ),
                      //photos
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text(
                                '123',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: Colors.blueGrey[900],
                                    ),
                              ),
                              Text(
                                'Photos',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ),
                      ),
                      //following
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text(
                                '555',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: Colors.blueGrey[900],
                                    ),
                              ),
                              Text(
                                'Following',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ),
                      ),
                      //followers
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text(
                                '5K',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: Colors.blueGrey[900],
                                    ),
                              ),
                              Text(
                                'Followers',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  //buttons
                  Row(
                    children: [
                      //add Story
                      Expanded(
                          child: OutlinedButton(
                              onPressed: () {},
                            child: Row(
                                children: [
                                  Icon(IconBroken.Plus,size: 15,),
                                  SizedBox(width: 5,),
                                  Expanded(child: Text('Add to story')),
                                ],
                              ),
                          ),
                      ),

                      SizedBox(width: 5,),

                      //edit profile
                      Expanded(
                          child: OutlinedButton(
                              onPressed: () {
                                pushNavigateTo(context, EditProfileScreen());
                                //SocialCubit.get(context).getUserInfo();
                              }, child: Row(
                                children: [
                                  Icon(IconBroken.Edit_Square,size: 15,),
                                  SizedBox(width: 5,),
                                  Expanded(child: Text('Edit profile')),
                                ],
                              ),
                          ),
                      ),

                      SizedBox(width: 5,),

                      OutlinedButton(
                          onPressed: () {},
                          child: Icon(IconBroken.More_Square)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
