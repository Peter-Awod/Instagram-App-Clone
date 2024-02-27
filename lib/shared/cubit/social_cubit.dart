import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/message_model/message_model.dart';
import '../../models/posts_model/posts_model.dart';
import '../../models/user_model/user_model.dart';
import '../../modules/add_post/add_post_screen.dart';
import '../../modules/chats/chats_screen.dart';
import '../../modules/news_feed/feeds_screen.dart';
import '../../modules/settings/settings_screen.dart';
import '../../modules/users/users_screen.dart';
import '../components/constants.dart';
import 'social_states.dart';


class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;

  void getUserInfo() {
    emit(GetUserLoadingState());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data()!);
      emit(GetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;

  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    AddPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];
  List<String> titles = [
    'Feeds',
    'Chats',
    'Posts',
    'Users',
    'Settings',
  ];

  void changeIndex(int index) {
    if (index == 1) {
      getAllUsers();
    }

    if (index == 2) {
      emit(BottomNavAddPostState());
    } else {
      currentIndex = index;
      emit(ChangeBottomNavState());
    }
  }

  File? profileImage;
  var profilePicker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile =
        await profilePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(PickProfileImageSuccessState());
    } else {
      print('no images selected');
      emit(PickProfileImageErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(UploadImageLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUserInfo(name: name, phone: phone, bio: bio, profile: value);
      }).catchError((error) {
        emit(UploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(UploadProfileImageErrorState());
    });
  }

  File? coverImage;
  var coverPicker = ImagePicker();

  Future<void> getCoverImage() async {
    final pickedFile = await coverPicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(PickCoverImageSuccessState());
    } else {
      print('no images selected');
      emit(PickCoverImageErrorState());
    }
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(UploadImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUserInfo(name: name, phone: phone, bio: bio, cover: value);
      }).catchError((error) {
        emit(UploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(UploadCoverImageErrorState());
    });
  }

  void updateUserInfo({
    required String name,
    required String phone,
    required String bio,
    String? profile,
    String? cover,
  }) {
    emit(UpdateUserInfoLoadingState());

    UserModel model = UserModel(
      uId: userModel!.uId,
      name: name,
      bio: bio,
      phone: phone,
      email: userModel!.email,
      profile: profile ?? userModel!.profile,
      cover: cover ?? userModel!.cover,
      isEmailVerified: userModel!.isEmailVerified,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(model.uId)
        .update(model.toMap())
        .then((value) {
      getUserInfo();
    }).catchError((error) {
      emit(UpdateUserInfoErrorState());
    });
  }

  // Create post

  File? postImage;
  var postPicker = ImagePicker();

  Future<void> getPostImage() async {
    final pickedFile = await postPicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(PickPostImageSuccessState());
    } else {
      print('no images selected');
      emit(PickPostImageErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(RemovePostImageState());
  }

  void uploadPostImage({
    required String text,
    required String dateTime,
  }) {
    emit(CreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createNewPost(text: text, dateTime: dateTime, postImage: value);
      }).catchError((error) {
        emit(CreatePostErrorState());
      });
    }).catchError((error) {
      emit(CreatePostErrorState());
    });
  }

  void createNewPost({
    required String text,
    required String dateTime,
    String? postImage,
  }) {
    emit(CreatePostLoadingState());

    PostModel model = PostModel(
      uId: userModel!.uId,
      name: userModel!.name,
      profile: userModel!.profile,
      text: text,
      dateTime: dateTime,
      postImage: postImage ?? '',
      postId: '',
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      // print(value.id);

      String pId=value.id;

      value.update({'postId':pId});

      emit(CreatePostSuccessState());
    }).catchError((error) {
      emit(CreatePostErrorState());
    });
  }

// get posts

  List<PostModel> posts = [];
  List<String> postsID = [];
  List<int> likes = [];

  void getPosts() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postsID.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
          emit(GetPostsSuccessState());
        }).catchError((error) {});
      });
    }).catchError((error) {
      emit(GetPostsErrorState(error));
    });
  }

  void likePost({required String postID}) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postID)
        .collection('likes')
        .doc(userModel!.uId)
        .set({'like': true}).then((value) {
      emit(LikePostSuccessState());
    }).catchError((error) {
      emit(LikePostErrorState(error));
    });
  }

  List<UserModel> users = [];

  void getAllUsers() {
    users = [];
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['uId'] != userModel!.uId)
          users.add(UserModel.fromJson(element.data()));
      });
      emit(GetAllUsersSuccessState());
    }).catchError((error) {
      emit(GetAllUsersErrorState(error.toString()));
    });
  }

  // Chat
  // Send message
  void sendMesssage({
    required String messageText,
    required String receiverId,
    required String messageDateTime,
  }) {
    MessageModel messageModel = MessageModel(
        messageText: messageText,
        messageDateTime: messageDateTime,
        receiverID: receiverId,
        senderID: userModel!.uId);

    // Set Sender Message
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessagesSuccessState());
    }).catchError((error) {
      emit(SendMessagesErrorState());
    });

    // Set Receiver Message
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessagesSuccessState());
    }).catchError((error) {
      emit(SendMessagesErrorState());
    });
  }

  // Get Message

  List<MessageModel>messages=[];
  void getMessages({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('messageDateTime')
        .snapshots()
        .listen((event) {
      messages=[];
          event.docs.forEach((element) {
            messages.add(MessageModel.fromJson(element.data()));
          });
          emit(GetMessagesSuccessState());
        });

  }

// Cubit class end
}
