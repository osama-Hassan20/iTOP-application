// ignore_for_file: must_be_immutable, avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/layout/cubit/cubit.dart';
import 'package:social_application/shared/components/components.dart';
import '../../layout/cubit/states.dart';
import '../../models/post_model.dart';
import '../../shared/styles/icon_broken.dart';
import '../new_post/new_post_screen.dart';
import '../new_story/new_story_screen.dart';
import '../new_story/story_view.dart';

class FeedsScreen extends StatelessWidget {
   FeedsScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SocialCubit cubit = SocialCubit.get(context);
        return ConditionalBuilder(
          condition:cubit.posts.isNotEmpty && cubit.userModel != null,
          // condition: true,
          builder: (context) => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  height: 180,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 10.0,
                    ),

                    itemBuilder: (context, index)
                    {
                      if(index == 0 ){
                        return InkWell(
                          onTap: (){
                            navigateTo(context, NewStoryScreen());
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 15
                            ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey[300],
                          ),
                          height: 180,
                          child: Stack(
                            children: [
                              Container(

                                width: 100,
                                height: 120,
                                child: Image(
                                  image: NetworkImage(
                                    '${cubit.userModel!.image}',
                                  ),
                                  fit: BoxFit.fill,
                                ),

                              ),
                              Positioned(
                                bottom: 45,
                                left: 30,
                                child: CircleAvatar(
                                  radius: 18,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    radius: 16.0,
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 5,
                                left: 15,
                                child: Container(
                                  width: 70,
                                  child: Text(
                                    'Create Story',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ),
                        );
                      }else
                      {
                        return InkWell(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyStoryPage(
                                    storyImagePath:'${cubit.stories[index-1].storyImage}',
                                    name:'${cubit.stories[index-1].name}',
                                    imagePath:'${cubit.stories[index-1].image}',
                                ),
                              ),
                            );
                          },
                          child: Stack(
                    children: [
                      Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey[300],
                          ),
                          width: 100,
                          height: 180,
                          child: Image(
                            image: NetworkImage(
                              '${cubit.stories[index-1].storyImage}',
                            ),
                            fit: BoxFit.fill,
                          ),

                      ),
                      Positioned(
                          top: 5,
                          left: 5,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.blue,
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage: NetworkImage('${cubit.stories[index-1].image}'),
                              radius: 18.0,
                            ),
                          ),
                      ),
                      Positioned(
                          bottom: 5,
                          left: 5,
                          child: Container(
                            width: 90,
                            child: Text(
                              '${cubit.stories[index-1].name}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.white
                              ),
                            ),
                          ),
                      ),
                    ],
                    ),
                        );
                      }
                    },
                    itemCount: cubit.stories.length +1,
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(
                      vertical: 20
                  ),
                  width: double.infinity,
                  height: 10,
                  color: Colors.grey,
                ),
                if(cubit.posts.isNotEmpty)
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 8.0,
                    ),
                    itemBuilder: (context, index) =>
                        buildPostItem(cubit.posts[index], context, index),
                    itemCount: cubit.posts.length,
                  ),
                if(cubit.posts.isEmpty)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20,),
                      Icon(
                        Icons.post_add,
                        size: 100,
                        color: Colors.grey[300],

                      ),
                      SizedBox(height: 20,),
                      Text(
                        'No Posts yet',
                        style: TextStyle(
                            fontSize: 18
                        ),
                      ),
                      Text('Be the frist Posts',
                        style: TextStyle(
                            fontSize: 18
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: OutlinedButton(
                          onPressed: () {
                            navigateTo(context, NewPostScreen());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Upload Posts',
                              ),
                              SizedBox(width: 5,),
                              Icon(
                                IconBroken.Upload,
                                size: 16.0,
                              ),
                            ],
                          ),

                        ),
                      ),

                    ],
                  ),


                const SizedBox(
                  height: 8.0,
                ),
              ],
            ),
          ),
          fallback: (context) =>
          const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}