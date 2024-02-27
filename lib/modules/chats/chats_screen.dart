import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/user_model/user_model.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/cubit/social_cubit.dart';
import '../../shared/cubit/social_states.dart';
import 'user_chat_screen.dart';


class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SocialCubit cubitVar = SocialCubit.get(context);
        return ConditionalBuilder(
          condition: cubitVar.users.length>0,
          builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              if(cubitVar.users[index].uId==uId)
                return null;
              else
                return  buildUserItem(model: cubitVar.users[index],context: context);
            },
            separatorBuilder:(context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: mySeparator(),
            ),
            itemCount: cubitVar.users.length,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildUserItem({required context, required UserModel model}) => InkWell(
        onTap: () {
          pushNavigateTo(context, UserChatScreen(receiverModel: model));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    '${model.profile}'),
                radius: 25,
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Text(
                  '${model.name}',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(height: 1.3),
                ),
              ),
            ],
          ),
        ),
      );
}
