import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/message_model/message_model.dart';
import '../../models/user_model/user_model.dart';
import '../../shared/components/constants.dart';
import '../../shared/cubit/social_cubit.dart';
import '../../shared/cubit/social_states.dart';
import '../../shared/styles/icon_broken.dart';


class UserChatScreen extends StatelessWidget {
  final UserModel receiverModel;

  UserChatScreen({required this.receiverModel});

  @override
  Widget build(BuildContext context) {
    var messageController = TextEditingController();

    return Builder(
      builder: (context) {
        SocialCubit.get(context).getMessages(receiverId: receiverModel.uId!);
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(IconBroken.Arrow___Left_2),
                ),
                titleSpacing: 2,
                title: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage('${receiverModel.profile}'),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('${receiverModel.name}'),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Expanded(
                      child: ConditionalBuilder(
                        condition: SocialCubit.get(context).messages.length > 0,
                        builder: (context) => ListView.separated(
                          itemBuilder: (context, index) {
                            var message =
                                SocialCubit.get(context).messages[index];
                            if (SocialCubit.get(context).userModel!.uId ==
                                message.senderID)
                              return sentMessageBuilder(message);

                            return receivedMessageBuilder(message);
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            height: 10,
                          ),
                          itemCount: SocialCubit.get(context).messages.length,
                        ),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0),
                              child: TextFormField(
                                controller: messageController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Write your message here...',
                                ),
                              ),
                            ),
                          ),
                          Container(
                            color: defaultColor,
                            height: 60,
                            child: MaterialButton(
                              onPressed: () {
                                SocialCubit.get(context).sendMesssage(
                                    messageText: messageController.text,
                                    receiverId: receiverModel.uId!,
                                    messageDateTime:
                                    DateTime.now().toString());
                                messageController.text = '';
                              },
                              minWidth: 1,
                              child: Icon(
                                IconBroken.Send,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget receivedMessageBuilder(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          decoration: BoxDecoration(
              color: Colors.blueGrey.withOpacity(0.5),
              borderRadius: BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(10),
                topEnd: Radius.circular(10),
                topStart: Radius.circular(10),
              )),
          child: Text('${model.messageText}'),
        ),
      );

  Widget sentMessageBuilder(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          decoration: BoxDecoration(
              color: defaultColor.withOpacity(0.3),
              borderRadius: BorderRadiusDirectional.only(
                bottomStart: Radius.circular(10),
                topEnd: Radius.circular(10),
                topStart: Radius.circular(10),
              )),
          child: Text('${model.messageText}'),
        ),
      );
}
