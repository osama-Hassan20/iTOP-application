import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../models/user_model.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constant.dart';
import '../../shared/styles/icon_broken.dart';
import '../chats/chat_details_screen.dart';
import '../edit_profile/edit_profile_screen.dart';
import '../new_post/new_post_screen.dart';

class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({Key? key, required this.userModel}) : super(key: key);
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        // UserModel userModel = SocialCubit.get(context).userModel!;
        SocialCubit cubit = SocialCubit.get(context);

        return ConditionalBuilder(
          condition: state != GetPostsLoadingState && cubit.userModel != null,
          builder: (context) => Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  IconBroken.Arrow___Left_2,
                  color: Colors.black,
                ),
              ),
            ),
            body: SingleChildScrollView(

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 250.0,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomStart,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: InkWell(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FullScreenImage(imagePath:'${userModel.coverImage}'),
                                  ),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 10.0,
                                ),
                                height: 180.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      '${userModel.coverImage}',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: CircleAvatar(
                              radius: 66.0,
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FullScreenImage(imagePath:'${userModel.image}'),
                                    ),
                                  );
                                },
                                child: CircleAvatar(
                                  radius: 60.0,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: NetworkImage('${userModel.image}'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      '${userModel.name}',
                      style:TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                    ),
                    Text(
                      '${userModel.bio}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              child: Column(
                                children: [
                                  Text(
                                    '180',
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                  Text(
                                    'Posts',
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                              onTap: () {comingSoon();},
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              child: Column(
                                children: [
                                  Text(
                                    '265',
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                  Text(
                                    'Photos',
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                              onTap: () {comingSoon();},
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              child: Column(
                                children: [
                                  Text(
                                    '10k',
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                  Text(
                                    'Followers',
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                              onTap: () {comingSoon();},
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              child: Column(
                                children: [
                                  Text(
                                    '64',
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                  Text(
                                    'Followings',
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                              onTap: () {comingSoon();},
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              comingSoon();
                            },
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Add Friend',
                                ),
                                SizedBox(width: 10,),
                                Icon(
                                  Icons.person_add,
                                  size: 16.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              side: BorderSide.none,
                            ),
                            onPressed: () {
                              navigateTo(context, ChatDetailsScreen(userModel: userModel));                            },
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Message',
                                  style: TextStyle(
                                    color: Colors.white
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Icon(
                                  color: Colors.white,
                                  IconBroken.Chat,
                                  size: 16.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Container(
                          child: OutlinedButton(
                            style: ButtonStyle(

                                padding: MaterialStateProperty.all(EdgeInsets.zero),
                                minimumSize: MaterialStateProperty.all(Size(35, 35))
                            ),
                            onPressed: () {
                              comingSoon();
                            },
                            child:  Icon(
                              Icons.menu_outlined,
                              size: 18.0,
                            ),
                          ),
                        ),
                      ],
                    ),




                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 20
                      ),
                      width: double.infinity,
                      height: 10,
                      color: Colors.grey,
                    ),


                    Text(
                      'Posts',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {navigateTo(context, NewPostScreen());},
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                    NetworkImage('${userModel.image}'),
                                    radius: 24.0,
                                  ),
                                  const SizedBox(
                                    width: 15.0,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'What\'s on your mind?',
                                    ),
                                  ),
                                  Icon(
                                    IconBroken.Image,
                                    size: 24.0,
                                    color: Colors.green,
                                  ),                            ],
                              ),

                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(width: 10,),
                        InkWell(
                          onTap: (){
                            comingSoon();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(20)
                            ),

                            padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.video_library,
                                  size: 16.0,
                                  color: Colors.red,
                                ),
                                SizedBox(width: 5,),
                                Text(
                                  'Reel',
                                ),


                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 25,),
                        InkWell(
                          onTap: (){
                            comingSoon();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(20)
                            ),

                            padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.video_camera_front,
                                  size: 16.0,
                                  color: Colors.red,
                                ),
                                SizedBox(width: 5,),
                                Text(
                                  'Live',
                                ),


                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 20
                      ),
                      width: double.infinity,
                      height: 5,
                      color: Colors.grey,
                    ),

                    if(cubit.posts.isNotEmpty)
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 8.0,
                        ),
                        itemBuilder: (context, index)
                        {
                          if(userModel.uId == cubit.posts[index].uId)
                            return buildPostItem(cubit.posts[index], context, index);
                          else
                            return Container();
                        },

                        itemCount: cubit.posts.length,
                      ),


                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}