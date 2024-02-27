import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/posts_model/posts_model.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/cubit/social_cubit.dart';
import '../../shared/cubit/social_states.dart';
import '../../shared/styles/icon_broken.dart';


class FeedsScreen extends StatelessWidget {
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SocialCubit cubitVar = SocialCubit.get(context);
        return ConditionalBuilder(
          condition: cubitVar.posts.length > 0 && cubitVar.userModel != null,
          fallback: (context) => Center(child: CircularProgressIndicator()),
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                    elevation: 10,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    margin: EdgeInsets.all(8),
                    child: Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
                        Image(
                          image: NetworkImage(
                              'https://img.freepik.com/free-photo/full-shot-woman-reading-with-smartphone_23-2149629602.jpg?w=900&t=st=1696401099~exp=1696401699~hmac=c1798a60da1fa9f3297868284be1bd56288daeb0709aa7fc06b2454f028208c4'),
                          width: double.infinity,
                          fit: BoxFit.cover,
                          height: 200,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            'Communicate with friends',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color: Colors.white,
                                  fontFamily: 'Jannah',
                                ),
                          ),
                        )
                      ],
                    )),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => postItemBuilder(
                      model: cubitVar.posts[index], context: context,index: index),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 8,
                  ),
                  itemCount: cubitVar.posts.length,
                ),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget postItemBuilder({required PostModel model, required context,required index}) => Card(
        elevation: 10,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage('${model.profile}'),
                    radius: 25,
                  ),
                  SizedBox(
                    width: 15,
                  ),

                  //name

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${model.name}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(height: 1.3),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Icon(
                              Icons.check_circle_sharp,
                              color: defaultColor,
                              size: 16,
                            ),
                          ],
                        ),
                        Text(
                          '${model.dateTime}',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(height: 1.3),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.more_horiz_sharp,
                      )),
                ],
              ),
              mySeparator(),
              // post text
              Text(
                '${model.text}',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              // Padding(
              //   padding: const EdgeInsetsDirectional.only(bottom: 5),
              //   child: Container(
              //     width: double.infinity,
              //     child: Wrap(
              //       children: [
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(
              //             end: 5,
              //           ),
              //           child: Container(
              //             height: 25,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               child: Text(
              //                 '#Softagi',
              //                 style: Theme
              //                     .of(context)
              //                     .textTheme
              //                     .bodySmall!
              //                     .copyWith(
              //                   color: defaultColor,
              //                 ),
              //               ),
              //               minWidth: 1,
              //               padding: EdgeInsets.zero,
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(
              //             end: 5,
              //           ),
              //           child: Container(
              //             height: 25,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               child: Text(
              //                 '#Helpo',
              //                 style: Theme
              //                     .of(context)
              //                     .textTheme
              //                     .bodySmall!
              //                     .copyWith(
              //                   color: defaultColor,
              //                 ),
              //               ),
              //               minWidth: 1,
              //               padding: EdgeInsets.zero,
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(
              //             end: 5,
              //           ),
              //           child: Container(
              //             height: 25,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               child: Text(
              //                 '#3almashy',
              //                 style: Theme
              //                     .of(context)
              //                     .textTheme
              //                     .bodySmall!
              //                     .copyWith(
              //                   color: defaultColor,
              //                 ),
              //               ),
              //               minWidth: 1,
              //               padding: EdgeInsets.zero,
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(
              //             end: 5,
              //           ),
              //           child: Container(
              //             height: 25,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               child: Text(
              //                 '#Flutter_Software_House',
              //                 style: Theme
              //                     .of(context)
              //                     .textTheme
              //                     .bodySmall!
              //                     .copyWith(
              //                   color: defaultColor,
              //                 ),
              //               ),
              //               minWidth: 1,
              //               padding: EdgeInsets.zero,
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),

              if (model.postImage != "")
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      image: DecorationImage(
                        image: NetworkImage('${model.postImage}'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            children: [
                              Icon(
                                IconBroken.Heart,
                                color: Colors.deepOrange,
                                size: 20,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${SocialCubit.get(context).likes[index]}',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                IconBroken.Chat,
                                color: Colors.deepOrange,
                                size: 20,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '120 comments',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://img.freepik.com/free-photo/person-enjoying-warm-nostalgic-sunset_52683-100695.jpg?w=996&t=st=1696399104~exp=1696399704~hmac=80ecd7257165cc6474a611c48b1d13ec6ab1a05a9dece5bcc92cc0f69f47c42b'),
                              radius: 15,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              'Write a comment...',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      SocialCubit.get(context).likePost(postID: SocialCubit.get(context).postsID[index]);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children: [
                          Icon(
                            IconBroken.Heart,
                            color: Colors.deepOrange,
                            size: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Like',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
