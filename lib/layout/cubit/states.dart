abstract class SocialStates{}

class AppChangeBottomSheetState extends SocialStates{}


//GetUser

class SocialInitialState extends SocialStates{}

class SocialGetUserLoadingState extends SocialStates{}

class SocialGetUserSuccessState extends SocialStates{}

class SocialGetUserErrorState extends SocialStates
{
  final String error;

  SocialGetUserErrorState(this.error);
}

//GetAllUser
class GetAllUsersSuccessState extends SocialStates {}

class GetAllUsersLoadingState extends SocialStates {}

class GetAllUsersErrorState extends SocialStates {
  final String error;

  GetAllUsersErrorState(this.error);
}


class SocialChangeBottomNavState extends SocialStates{}

class SocialSocialNewPostsState extends SocialStates{}


//pick Profile Image
class ProfileImagePickedSuccessState extends SocialStates {}

class ProfileImagePickedErrorState extends SocialStates {}

//pick Cover Image
class CoverImagePickedSuccessState extends SocialStates {}

class CoverImagePickedErrorState extends SocialStates {
  final String error;

  CoverImagePickedErrorState(this.error);
}


//Upload Profile Image

class UploadProfileImageSuccessState extends SocialStates {}

class UploadProfileImageErrorState extends SocialStates {
  final String error;

  UploadProfileImageErrorState(this.error);
}

//Upload Cover Image

class UploadCoverImageSuccessState extends SocialStates {}

class UploadCoverImageErrorState extends SocialStates {}




class UserUpdateLoadingState extends SocialStates {}

class UserUpdateSuccessState extends SocialStates {}

class UserUpdateErrorState extends SocialStates {}

//change text field

class ChangeTextFieldState extends SocialStates {}


// PostImage

class PostImagePickedSuccessState extends SocialStates {}

class PostImagePickedErrorState extends SocialStates {
  final String error;

  PostImagePickedErrorState(this.error);
}

class RemovePostImageState extends SocialStates {}
// PostImage

class StoryImagePickedSuccessState extends SocialStates {}

class StoryImagePickedErrorState extends SocialStates {
  final String error;

  StoryImagePickedErrorState(this.error);
}

class RemoveStoryImageState extends SocialStates {}
//create Post

class CreatePostLoadingState extends SocialStates {}

class CreatePostSuccessState extends SocialStates {}

class CreatePostErrorState extends SocialStates {}


//create Story

class CreateStoryLoadingState extends SocialStates {}

class CreateStorySuccessState extends SocialStates {}

class CreateStoryErrorState extends SocialStates {}

//get Story
class GetStoryLoadingState extends SocialStates {}

class GetStorySuccessState extends SocialStates {}

class GetStoryErrorState extends SocialStates {
  final String error;

  GetStoryErrorState(this.error);
}

//get Posts
class GetPostsLoadingState extends SocialStates {}

class GetPostsSuccessState extends SocialStates {}

class GetPostsErrorState extends SocialStates {
  final String error;

  GetPostsErrorState(this.error);
}

class GetPostsSuccessTestState extends SocialStates {}

class GetPostsErrorTestState extends SocialStates {
  final String error;

  GetPostsErrorTestState(this.error);
}

class ChangeTextShowMoreState extends SocialStates {}



//get Likes
class GetPostsLikesSuccessState extends SocialStates {}

class GetPostsLikesErrorState extends SocialStates {
  final String error;

  GetPostsLikesErrorState(this.error);
}

//get Comments
class GetPostsCommentsSuccessState extends SocialStates {}

class GetPostsCommentsErrorState extends SocialStates {
  final String error;

  GetPostsCommentsErrorState(this.error);
}

//like Post
class LikePostSuccessState extends SocialStates {}

class LikePostErrorState extends SocialStates {
  final String error;

  LikePostErrorState(this.error);
}

class CommentButtonChangedState extends SocialStates {}

//Comment Post
class CommentPostLoadingState extends SocialStates {}
class CommentPostSuccessState extends SocialStates {}

class CommentPostErrorState extends SocialStates {
  final String error;

  CommentPostErrorState(this.error);
}

//CommentView Post


class CommentViewPostLoadingState extends SocialStates {}
class CommentViewPostSuccessState extends SocialStates {}

class CommentViewPostErrorState extends SocialStates {
  final String error;

  CommentViewPostErrorState(this.error);
}


//Likes Posts


class LikesViewPostLoadingState extends SocialStates {}
class LikesViewPostSuccessState extends SocialStates {}

class LikesViewPostErrorState extends SocialStates {
  final String error;

  LikesViewPostErrorState(this.error);
}

//Send Message

class SendMessageSuccessState extends SocialStates {}

class SendMessageErrorState extends SocialStates {}
//Get Message

class GetMessageSuccessState extends SocialStates {}

class GetMyMessageSuccessState extends SocialStates {}

//Get Chat Image

class ChatImagePickedSuccessState extends SocialStates {}

class ChatImagePickedErrorState extends SocialStates {}

class RemoveChatImageState extends SocialStates {}