import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';
import '../../shared/cubit/social_cubit.dart';
import '../../shared/cubit/social_states.dart';
import '../../shared/styles/icon_broken.dart';


class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) => {},
      builder: (context, state) {
        var cubitVar = SocialCubit.get(context);

        var user = cubitVar.userModel!;

        nameController.text = user.name!;
        bioController.text = user.bio!;
        phoneController.text = user.phone!;

        var profileImage = cubitVar.profileImage;
        var coverImage = cubitVar.coverImage;

        return Form(
          key: formKey,
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(IconBroken.Arrow___Left_Circle),
                onPressed: () {
                  Navigator.pop(context);
                  SocialCubit.get(context).getUserInfo();
                },
              ),
              title: Text('Edit profile'),
              titleSpacing: 5,
              actions: [
                //                  update     button
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 10),
                  child: defaultTextButton(
                      function: () {
                        cubitVar.updateUserInfo(
                            name: nameController.text,
                            phone: phoneController.text,
                            bio: bioController.text);
                      },
                      text: 'Update'),
                ),
                ///////////////////////////////////////////////
              ],
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  if (state is UpdateUserInfoLoadingState || state is GetUserLoadingState)
                    LinearProgressIndicator(),
                  if (state is UpdateUserInfoLoadingState || state is GetUserLoadingState)
                    SizedBox(
                      height: 10,
                    ),
                  Container(
                    height: 220,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topStart,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              Container(
                                height: 180,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4),
                                    topRight: Radius.circular(4),
                                  ),
                                  image: DecorationImage(
                                    image: coverImage == null
                                        ? NetworkImage('${user.cover}')
                                        : FileImage(coverImage)
                                            as ImageProvider<Object>,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.grey.withOpacity(0.3),
                                  child: IconButton(
                                    icon: Icon(
                                      IconBroken.Camera,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      cubitVar.getCoverImage();
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 10),
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 65,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  backgroundImage: profileImage == null
                                      ? NetworkImage('${user.profile}')
                                      : FileImage(profileImage)
                                          as ImageProvider<Object>?,
                                  radius: 62,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.grey.withOpacity(0.3),
                                  child: IconButton(
                                    icon: Icon(
                                      IconBroken.Camera,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      cubitVar.getProfileImage();
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  // upload buttons
                  if (cubitVar.profileImage != null ||
                      cubitVar.coverImage != null)
                    Row(
                      children: [
                        if (cubitVar.profileImage != null)
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                OutlinedButton(
                                  onPressed: () {
                                    cubitVar.uploadProfileImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text);
                                  },
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.grey[100]
                                  ),
                                  child: Text('Upload Profile Image'),
                                ),
                                if (state is UploadImageLoadingState)
                                  SizedBox(
                                    height: 5,
                                  ),
                                if (state is UploadImageLoadingState)
                                  LinearProgressIndicator(),
                              ],
                            ),
                          ),
                        if (cubitVar.coverImage != null)
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                OutlinedButton(
                                  onPressed: () {
                                    cubitVar.uploadCoverImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text);
                                  },
                                  style: OutlinedButton.styleFrom(
                                      backgroundColor: Colors.grey[100]
                                  ),
                                  child: Text('Upload Cover Image'),
                                ),
                                if (state is UploadImageLoadingState)
                                  SizedBox(
                                    height: 5,
                                  ),
                                if (state is UploadImageLoadingState)
                                  LinearProgressIndicator(),
                              ],
                            ),
                          ),
                      ],
                    ),
                  // Info
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        defaultTextFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          label: 'Name',
                          prefix: IconBroken.User,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Name must not be empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        defaultTextFormField(
                          controller: bioController,
                          type: TextInputType.text,
                          label: 'Bio',
                          prefix: IconBroken.Info_Circle,
                          validate: (value) {
                            if (value!.isEmpty) {
                              value =
                                  bioController.text = 'Describe yourself ...';
                              return null;
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultTextFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          label: 'Phone',
                          prefix: IconBroken.Call,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Phone number must not be empty';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
