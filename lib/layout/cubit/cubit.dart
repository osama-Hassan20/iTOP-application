
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_application/layout/cubit/states.dart';
import 'package:social_application/models/user_model.dart';
import 'package:social_application/screens/chats/chats_screen.dart';
import 'package:social_application/screens/feeds/feeds_screen.dart';
import 'package:social_application/screens/settings/settings_screen.dart';
import 'package:social_application/shared/components/constant.dart';
import '../../models/comment_models.dart';
import '../../models/message_model.dart';
import '../../models/post_model.dart';
import '../../models/story_image.dart';
import '../../screens/users/users_screen.dart';
import '../../shared/styles/icon_broken.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates>
{
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  var scaffoldKey = GlobalKey<ScaffoldState>();

  bool isBottomSheetShow = false;


  bool isExpanded = false;
  void changeTextShowMore(){
    isExpanded = !isExpanded;
    emit(ChangeTextShowMoreState());
  }

  void changeBottomSheetState({
    required bool isShow,

  }) {
    isBottomSheetShow = isShow;

    emit(AppChangeBottomSheetState());
  }


  int currentIndex = 0;


  List<BottomNavigationBarItem> bottomItem = [
    BottomNavigationBarItem(
        icon: Icon(
            IconBroken.Home,
        ),
        label:'Home'
    ),
    BottomNavigationBarItem(
        icon: Icon(
          IconBroken.Chat,
        ),
        label:'Chats'
    ),
    BottomNavigationBarItem(
        icon: Icon(
          IconBroken.User,
        ),
        label:'Users'
    ),
    BottomNavigationBarItem(
      icon: Icon(
        IconBroken.Setting,
      ),
      label:'Settings',
    ),
  ];

  List<Widget> screen = [
    FeedsScreen(),
    ChatsScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> titles =
  [
    'Home',
    'Chat',
    'Users',
    'Setting',
  ];
  void changeBottomNav(int index)
  {
    if (index == 0) {
      getPosts();
      getStory();
      getUserData();
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
    if (index == 1 || index == 2) {
      currentIndex = index;
      getUsers();
      emit(SocialChangeBottomNavState());
    } else {
      currentIndex = index;
      getUserData();
      emit(SocialChangeBottomNavState());
    }
  }


  UserModel? userModel;

  void getUserData()
  {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance
        .collection('user')
        .doc(uId)
        .get()
        .then((value){
      print(value.data());
      userModel = UserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
    })
        .catchError((error){
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    }
    );
  }



  File? profileImage;

  ImagePicker picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ProfileImagePickedSuccessState());
    } else {
      emit(ProfileImagePickedErrorState());
    }
  }

  ////select from camera
  Future<void> getProfileImageFromCamera() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ProfileImagePickedSuccessState());
    } else {
      emit(ProfileImagePickedErrorState());
    }
  }
//*********************************************
  File? coverImage;

  void getCoverImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(CoverImagePickedSuccessState());
    } else {
      emit(CoverImagePickedErrorState(pickedFile.toString()));
    }
  }

  //select from camera
  void getCoverImageFromCamera() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(CoverImagePickedSuccessState());
    } else {
      emit(CoverImagePickedErrorState(pickedFile.toString()));
    }
  }
  //*******************************************




  String profileImageUrl ='';
  Future<void> uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
})async{
    emit(UserUpdateLoadingState());
    await firebase_storage.FirebaseStorage.instance
        .ref() 
        .child('user/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
          value.ref
              .getDownloadURL()
              .then((value)async{
                profileImageUrl = value;
                await updateUserData(name: name, phone: phone, bio: bio, image: value);
                emit(UploadProfileImageSuccessState());

          })
              .catchError((error){
                emit(UploadProfileImageErrorState(error.toString()));
          });
        })
        .catchError((error){
          emit(UploadProfileImageErrorState(error.toString()));
    });
  }



  String coverImageUrl ='';
  Future<void> uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
})async{
    emit(UserUpdateLoadingState());
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('user/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref
          .getDownloadURL()
          .then((value)async{
          coverImageUrl = value;
          await updateUserData(name: name, phone: phone, bio: bio, cover: value);
          emit(UploadCoverImageSuccessState());

      })
          .catchError((error){
        emit(UploadCoverImageErrorState());
      });
    })
        .catchError((error){
      emit(UploadCoverImageErrorState());
    });
  }




  Future<void> updateUserData({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
})
  async{
    emit(UserUpdateLoadingState());
    UserModel modelUpdate = UserModel(
      name: name,
      phone: phone,
      bio: bio,
      email: userModel!.email,
      image: image ?? userModel!.image,
      coverImage: cover ?? userModel!.coverImage,
      uId: userModel!.uId,
      isEmailVerified: false,
    );

    await FirebaseFirestore.instance.collection('user').doc(uId)
        .update(modelUpdate.toMap())
        .then((value) {
      getUserData();
      emit(UserUpdateSuccessState());
    })
        .catchError((error){
          print(error.toString());
      emit(UserUpdateErrorState());
    });
  }

  File? postImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(PostImagePickedSuccessState());
    } else {
      emit(PostImagePickedErrorState(pickedFile.toString()));
    }
  }


  File? storyImage;
  Future<void> getStoryImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      storyImage = File(pickedFile.path);
      emit(StoryImagePickedSuccessState());
    } else {
      emit(StoryImagePickedErrorState(pickedFile.toString()));
    }
  }
  List<TextEditingController> commentControllers = [];
  List<Color> sendIconColors = [];


  void changeTextField() {
    emit(ChangeTextFieldState());
  }




  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
    String? tags,
  }) {
    emit(CreatePostLoadingState());

    PostModel model = PostModel(
      name: userModel!.name,
      image: userModel!.image,
      uId: userModel!.uId,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
      tags: tags ?? '',

    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(CreatePostSuccessState());
    }).catchError((error) {
      emit(CreatePostErrorState());
    });
  }


  void uploadPostImage({
    required String dateTime,
    required String text,
     String? tags,
  }) {
    emit(CreatePostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createPost(
          text: text,
          dateTime: dateTime,
          postImage: value,
          tags: tags ?? '',
        );
      }).catchError((error) {
        emit(CreatePostErrorState());
        print("-------------------");
        print(error.toString());
        print("-------------------");
      });
    }).catchError((error) {
      emit(CreatePostErrorState());
      print("-------------------");
      print(error.toString());
      print("-------------------");
    });
  }

  void removePostImage() {
    postImage = null;
    emit(RemovePostImageState());
  }

  void createStoryImage() {
    emit(CreateStoryLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('story/${Uri.file(storyImage!.path).pathSegments.last}')
        .putFile(storyImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        StoryModel model = StoryModel(
          name: userModel!.name,
          image: userModel!.image,
          uId: userModel!.uId,
          storyImage: value,
        );
        FirebaseFirestore.instance
            .collection('story')
            .add(model.toMap())
            .then((value) {
          emit(CreateStorySuccessState());
        }).catchError((error) {
          emit(CreateStoryErrorState());
          print("---------1----------");
          print(error.toString());
          print("---------1----------");
        });
      }).catchError((error) {
        emit(CreateStoryErrorState());
        print("---------2----------");
        print(error.toString());
        print("---------2----------");
      });
    }).catchError((error) {
      emit(CreateStoryErrorState());
      print("---------3----------");
      print(error.toString());
      print("---------3----------");
    });
  }

  List<StoryModel> stories = [];
  List<String> storyId = [];

  Future<void> getStory() async {
    emit(GetStoryLoadingState());
    stories = [];
    storyId = [];


    await FirebaseFirestore.instance
        .collection('story')
        .get()
        .then((value) async {

      value.docs.forEach((element)
      async{

        storyId.add(element.id);
        StoryModel story = StoryModel.fromJson(element.data());
        // story.add(story);

        await FirebaseFirestore.instance
            .collection('user')
            .doc(story.uId)
            .get()
            .then((value) {
          story.name = value.data()!['name'];
          story.image = value.data()!['image'];
          stories.add(story);
          // Print();
          emit(GetStorySuccessState());
        }).catchError((error){
          print(error.toString());
          emit(GetStoryErrorState(error.toString()));
        });
      },
      );


      emit(GetStorySuccessState());
    },)
        .catchError((error){
      emit(GetStoryErrorState(error.toString()));
    });



  }

  void removeStoryImage() {
    storyImage = null;
    emit(RemoveStoryImageState());
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  List<int> comments = [];


  Future<void> getPosts() async {
    emit(GetPostsLoadingState());
    posts = [];
    postsId = [];
    likes = [];
    comments = [];
    commentControllers = [];
    sendIconColors = [];


    await FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((value) async {
      final futures = <Future>[];

      value.docs.forEach((element)
       async{

        final likesFuture = element.reference.collection('Likes').get();
        final commentsFuture = element.reference.collection('Comments').get();

        futures.add(likesFuture);
        futures.add(commentsFuture);

        postsId.add(element.id);
        PostModel post = PostModel.fromJson(element.data());
        // posts.add(post);

        await FirebaseFirestore.instance
            .collection('user')
            .doc(post.uId)
            .get()
            .then((value) {
          post.name = value.data()!['name'];
          post.image = value.data()!['image'];
          posts.add(post);
          // Print();
          emit(GetPostsSuccessTestState());
        }).catchError((error){
          print(error.toString());
          emit(GetPostsErrorTestState(error.toString()));
        });
         },
      );

      final results = await Future.wait(futures);

      for (var i = 0; i < results.length; i += 2) {
        final likesResult = results[i] as QuerySnapshot<Map<String, dynamic>>;
        final commentsResult =
        results[i + 1] as QuerySnapshot<Map<String, dynamic>>;

        likes.add(likesResult.docs.length);
        comments.add(commentsResult.docs.length);
      }


          emit(GetPostsSuccessState());
    },)
        .catchError((error){
          emit(GetPostsErrorState(error.toString()));
        });



  }




  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection("posts")
        .doc(postId)
        .collection("Likes")
        .doc(userModel!.uId)
        .set({'like': true}).then((value) {
      getPosts();
      emit(LikePostSuccessState());
    }).catchError((error) {
      emit(LikePostErrorState(error.toString()));
    });
  }

  void commentButtonChanged() {
    emit(CommentButtonChangedState());
  }

  List<CommentModels> commentView = [];

  Future<void> getAllComment({
    required String postId
  }) async{
    commentView = [];

      await FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .collection("Comments")
          .get()
          .then((value) {
        for (var element in value.docs) {
            commentView.add(CommentModels.fromJson(element.data()));
        }
        print("${commentView}");
        emit(CommentViewPostSuccessState());
      }).catchError((error) {
        emit(CommentViewPostErrorState(error.toString()));
      });

  }


  void createCommentPost({
    required String comment,
    required String postId
  }) {
    emit(CreatePostLoadingState());

    CommentModels model = CommentModels(
      name: userModel!.name,
      image: userModel!.image,
      uId: userModel!.uId,
      comment: comment,
      postId: postId,

    );

    FirebaseFirestore.instance
        .collection("posts")
        .doc(postId)
        .collection("Comments")
        .doc(userModel!.uId)
        .set(model.toMap()).then((value) {
      // commentTransfer = " Write Comment ... ";
      emit(CommentPostSuccessState());
    }).catchError((error) {
      emit(CommentPostErrorState(error.toString()));
    });
  }



  List<UserModel> users = [];
  void getUsers() {

    if (users.length ==0 ) {
      FirebaseFirestore.instance.collection('user').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != userModel?.uId) {
            print("${element.data()['uId']}");
            print("${userModel?.uId}");
            users.add(UserModel.fromJson(element.data()));
        }
        },
        );
        emit(GetAllUsersSuccessState());
      }).catchError((error) {
        emit(GetAllUsersErrorState(error.toString()));
      });
    }
  }


  Future<int> getMessageCount(String receiverId) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("user")
        .doc(userModel!.uId)
        .collection("Chats")
        .doc(receiverId)
        .collection("messages")
        .get();

    int messageCount = querySnapshot.size;
    return messageCount;
  }

  Future<void> sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
    String? imageUrl,
  }) async {

    MessageModel modelMessage = MessageModel(
      senderId: userModel!.uId,
      receiverId: receiverId,
      dateTime: dateTime,
      imageUrl: imageUrl ?? "",
      text: text,
      name: userModel!.name
    );
    //set my chats
    await FirebaseFirestore.instance
        .collection("user")
        .doc(userModel!.uId)
        .collection("Chats")
        .doc(receiverId)
        .collection("messages")
        .add(modelMessage.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });

    //set receiver chats

    await FirebaseFirestore.instance
        .collection("user")
        .doc(receiverId)
        .collection("Chats")
        .doc(userModel!.uId)
        .collection("messages")
        .add(modelMessage.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];
  void getMessages({
    required String? receiverId,
  }) {
    FirebaseFirestore.instance
        .collection("user")
        .doc(receiverId)
        .collection("Chats")
        .doc(userModel!.uId)
        .collection("messages")
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(GetMessageSuccessState());
    });
  }


  void uploadImageMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    emit(UserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
        'messagesImages/${Uri.file(chatImage!.path).pathSegments.last}')
        .putFile(chatImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        sendMessage(
          text: text,
          dateTime: dateTime,
          receiverId: receiverId,
          imageUrl: value,
        );
      }).catchError((error) {
        emit(UploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(UploadCoverImageErrorState());
    });
  }

  File? chatImage;

  Future<void> getChatImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      chatImage = File(pickedFile.path);
      emit(ChatImagePickedSuccessState());
    } else {
      emit(ChatImagePickedErrorState());
    }
  }

  void removeChatImage() {
    chatImage = null;
    emit(RemoveChatImageState());
  }


}