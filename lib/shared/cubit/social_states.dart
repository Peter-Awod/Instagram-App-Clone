abstract class SocialStates{}

class SocialInitialState extends SocialStates{}

// Get Single User

class GetUserLoadingState extends SocialStates{}
class GetUserSuccessState extends SocialStates{}
class GetUserErrorState extends SocialStates{
  final String error;
  GetUserErrorState(this.error);
}


// Get All Users
class GetAllUsersLoadingState extends SocialStates{}
class GetAllUsersSuccessState extends SocialStates{}
class GetAllUsersErrorState extends SocialStates{
  final String error;
  GetAllUsersErrorState(this.error);
}

class ChangeBottomNavState extends SocialStates{}

class BottomNavAddPostState extends SocialStates{}


class PickProfileImageSuccessState extends SocialStates{}
class PickProfileImageErrorState extends SocialStates{}

class PickCoverImageSuccessState extends SocialStates{}
class PickCoverImageErrorState extends SocialStates{}


class UploadImageLoadingState extends SocialStates{}

class UploadProfileImageSuccessState extends SocialStates{}
class UploadProfileImageErrorState extends SocialStates{}

class UploadCoverImageSuccessState extends SocialStates{}
class UploadCoverImageErrorState extends SocialStates{}


class UpdateUserInfoLoadingState extends SocialStates{}
class UpdateUserInfoErrorState extends SocialStates{}


// Create Post
class CreatePostLoadingState extends SocialStates{}
class CreatePostSuccessState extends SocialStates{}
class CreatePostErrorState extends SocialStates{}

class PickPostImageSuccessState extends SocialStates{}
class PickPostImageErrorState extends SocialStates{}

class UploadPostImageSuccessState extends SocialStates{}
class UploadPostImageErrorState extends SocialStates{}

class RemovePostImageState extends SocialStates{}



// get posts

class GetPostsLoadingState extends SocialStates{}
class GetPostsSuccessState extends SocialStates{}
class GetPostsErrorState extends SocialStates{
  final String error;
  GetPostsErrorState(this.error);
}

class LikePostSuccessState extends SocialStates{}
class LikePostErrorState extends SocialStates{
  final String error;
  LikePostErrorState(this.error);
}


// Chat Messages

class SendMessagesSuccessState extends SocialStates{}
class SendMessagesErrorState extends SocialStates{}

class GetMessagesSuccessState extends SocialStates{}


