import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';
import '../../shared/cubit/social_cubit.dart';
import '../../shared/cubit/social_states.dart';
import '../../shared/styles/icon_broken.dart';


class AddPostScreen extends StatelessWidget {
  var postTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SocialCubit cubitVar = SocialCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(IconBroken.Arrow___Left_2),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            titleSpacing: 5,
            title: Text('Create post'),
            actions: [
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 5),
                child: defaultTextButton(
                    function: () {
                      var postTimae = DateTime.now();
                      if (cubitVar.postImage == null) {
                        cubitVar.createNewPost(
                            text: postTextController.text,
                            dateTime: postTimae.toString());
                      } else {
                        cubitVar.uploadPostImage(
                            text: postTextController.text,
                            dateTime: postTimae.toString());
                      }
                    },
                    text: 'Post'),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [

                if(state is CreatePostLoadingState)
                  LinearProgressIndicator(),
                if(state is CreatePostLoadingState)
                  SizedBox(height: 20,),//name and profile image
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                      '${cubitVar.userModel!.profile}'
                      ),
                      radius: 25,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                        '${cubitVar.userModel!.name}',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(height: 1.3),
                      ),
                    ),
                  ],
                ),

                // Text area (post)

                Expanded(
                  child: TextFormField(
                    controller: postTextController,
                    decoration: InputDecoration(
                      hintText: 'What\'s in your mind...',
                      border: InputBorder.none,
                    ),
                  ),
                ),

                //post picture

                SizedBox(height: 20,),

                if (cubitVar.postImage != null)

                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 180,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          image: DecorationImage(
                            image: FileImage(cubitVar.postImage!)
                            as ImageProvider<Object>,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white.withOpacity(0.5),
                        child: IconButton(
                          icon: Icon(
                            IconBroken.Close_Square,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            cubitVar.removePostImage();
                          },
                        ),
                      ),
                    ],
                  ),

                // add picture button and tags

                SizedBox(height: 20,),

                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          cubitVar.getPostImage();
                        },
                        child: Row(
                          children: [
                            Icon(IconBroken.Image_2),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Add picture')
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Text('# tags'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
