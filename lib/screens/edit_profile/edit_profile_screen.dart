import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_application/layout/cubit/cubit.dart';
import 'package:social_application/layout/cubit/states.dart';
import 'package:social_application/shared/components/components.dart';
import 'package:social_application/shared/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
   EditProfileScreen({Key? key}) : super(key: key);

  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();
   var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit , SocialStates>(
      listener: (context , state) {},
      builder: (context , state) {
        SocialCubit cubit = SocialCubit.get(context);
        var userModel = SocialCubit.get(context).userModel!;
        File? profileImage = SocialCubit.get(context).profileImage;
        File? coverImage = SocialCubit.get(context).coverImage;
        nameController.text = '${userModel.name}';
        bioController.text = '${userModel.bio}';
        phoneController.text = '${userModel.phone}';
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text('Edit Profile'),
            actions: [
              defaultTextButton(
                  text: 'update',color: Colors.white,
              function: () async {
                if (cubit.profileImage == null && cubit.coverImage == null)
                {
                  await cubit.updateUserData(
                    name: nameController.text,
                    phone: phoneController.text,
                    bio: bioController.text,
                  );
                }
                else if (cubit.profileImage != null && cubit.coverImage == null)
                {
                  await cubit.uploadProfileImage(
                    name: nameController.text,
                    phone: phoneController.text,
                    bio: bioController.text,
                  );
                }
                else if (cubit.profileImage == null && cubit.coverImage != null)
                {
                  await cubit.uploadCoverImage(
                    name: nameController.text,
                    phone: phoneController.text,
                    bio: bioController.text,
                  );
                  nameController.text = '${userModel.name}';
                  bioController.text = '${userModel.bio}';
                  phoneController.text = '${userModel.phone}';
                }
                else if (cubit.profileImage != null && cubit.coverImage != null)
                {
                  await cubit.uploadProfileImage(
                    name: nameController.text,
                    phone: phoneController.text,
                    bio: bioController.text,
                  );
                  await cubit.uploadCoverImage(
                    name: nameController.text,
                    phone: phoneController.text,
                    bio: bioController.text,
                  );
                }

                Navigator.pop(context);
              },
              ),
              const SizedBox(
                width: 15.0,
              ),
            ],
          ),

          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if(state is UserUpdateLoadingState)
                    LinearProgressIndicator(),
                  if(state is UserUpdateLoadingState)
                    SizedBox(height: 10,),
                  SizedBox(
                    height: 250.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              Container(
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
                                    image: coverImage == null ?NetworkImage(
                                      '${userModel.coverImage}',
                                    ) : FileImage(coverImage) as ImageProvider<Object>,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20.0,right: 10),
                                child: CircleAvatar(

                                  backgroundColor: Colors.grey,
                                  child: IconButton(
                                    onPressed: (){
                                      if (cubit.isBottomSheetShow == false)
                                      {
                                        scaffoldKey.currentState
                                            ?.showBottomSheet(
                                              (context) => Container(
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius:
                                                BorderRadius.only(
                                                  topRight:
                                                  Radius.circular(50),
                                                  topLeft:
                                                  Radius.circular(50),
                                                )),
                                            height: 200,
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.of(context).pop();
                                                          cubit.changeBottomSheetState(
                                                            isShow: false,
                                                          );
                                                          cubit.getCoverImageFromCamera();

                                                        },
                                                        child: Stack(
                                                          alignment:
                                                          AlignmentDirectional
                                                              .center,
                                                          children: [
                                                            CircleAvatar(
                                                              radius: 34,
                                                              backgroundColor:
                                                              Colors
                                                                  .white,
                                                            ),
                                                            CircleAvatar(
                                                              radius: 32,
                                                              backgroundColor:
                                                              Colors
                                                                  .grey,
                                                              child: Icon(
                                                                Icons
                                                                    .camera_alt,
                                                                color: Colors
                                                                    .black,
                                                                size: 32,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        'Camira',
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color: Colors
                                                                .black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.of(context).pop();
                                                          cubit.changeBottomSheetState(
                                                            isShow: false,
                                                          );
                                                          cubit.getCoverImage();
                                                        },
                                                        child: Stack(
                                                          alignment:
                                                          AlignmentDirectional
                                                              .center,
                                                          children: [
                                                            CircleAvatar(
                                                              radius: 34,
                                                              backgroundColor:
                                                              Colors
                                                                  .white,
                                                            ),
                                                            CircleAvatar(
                                                              backgroundColor:
                                                              Colors
                                                                  .grey,
                                                              radius: 32,
                                                              child: Icon(
                                                                Icons
                                                                    .photo_camera_back_outlined,
                                                                size: 32,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        'Gallery',
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color: Colors
                                                                .black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.of(context).pop();
                                                          cubit.changeBottomSheetState(
                                                            isShow: false,
                                                          );
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) => FullScreenImage(imagePath:'${userModel.coverImage}'),
                                                            ),
                                                          );
                                                        },
                                                        child: Stack(
                                                          alignment:
                                                          AlignmentDirectional
                                                              .center,
                                                          children: [
                                                            CircleAvatar(
                                                              radius: 34,
                                                              backgroundColor:
                                                              Colors
                                                                  .white,
                                                            ),
                                                            CircleAvatar(
                                                              backgroundColor:
                                                              Colors
                                                                  .grey,
                                                              radius: 32,
                                                              child: Icon(
                                                                Icons.remove_red_eye,
                                                                size: 32,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        'See Picture',
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color: Colors
                                                                .black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                            .closed
                                            .then((value) {
                                          cubit.changeBottomSheetState(
                                            isShow: false,
                                          );
                                        });
                                      }
                                      // cubit.getCoverImage();
                                    },
                                    icon: Icon(Icons.camera_alt_rounded,size: 20,color: Colors.white,),),
                                ),
                              ),

                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 78.0,
                                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  radius: 70.0,
                                  backgroundImage: profileImage == null ? NetworkImage('${userModel.image}'): FileImage(profileImage) as ImageProvider<Object>?,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0,right: 5),                              child: CircleAvatar(
                                  radius: 18,
                                  backgroundColor: Colors.grey,
                                  child: IconButton(
                                    onPressed: (){
                                      if (cubit.isBottomSheetShow == false)
                                      {
                                        scaffoldKey.currentState
                                            ?.showBottomSheet(
                                              (context) => Container(
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[300],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(50),
                                                      topLeft:
                                                          Radius.circular(50),
                                                    )),
                                                height: 200,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              Navigator.of(context).pop();
                                                              cubit.changeBottomSheetState(
                                                                isShow: false,
                                                              );
                                                              cubit.getProfileImageFromCamera();

                                                            },
                                                            child: Stack(
                                                              alignment:
                                                                  AlignmentDirectional
                                                                      .center,
                                                              children: [
                                                                CircleAvatar(
                                                                  radius: 34,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .white,
                                                                ),
                                                                CircleAvatar(
                                                                  radius: 32,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .grey,
                                                                  child: Icon(
                                                                    Icons
                                                                        .camera_alt,
                                                                    color: Colors
                                                                        .black,
                                                                    size: 32,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            'Camira',
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              Navigator.of(context).pop();
                                                              cubit.changeBottomSheetState(
                                                                isShow: false,
                                                              );
                                                              cubit.getProfileImage();
                                                            },
                                                            child: Stack(
                                                              alignment:
                                                                  AlignmentDirectional
                                                                      .center,
                                                              children: [
                                                                CircleAvatar(
                                                                  radius: 34,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .white,
                                                                ),
                                                                CircleAvatar(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .grey,
                                                                  radius: 32,
                                                                  child: Icon(
                                                                    Icons
                                                                        .photo_camera_back_outlined,
                                                                    size: 32,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            'Gallery',
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              Navigator.of(context).pop();
                                                              cubit.changeBottomSheetState(
                                                                isShow: false,
                                                              );
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder: (context) => FullScreenImage(imagePath:'${userModel.image}'),
                                                                ),
                                                              );
                                                            },
                                                            child: Stack(
                                                              alignment:
                                                              AlignmentDirectional
                                                                  .center,
                                                              children: [
                                                                CircleAvatar(
                                                                  radius: 34,
                                                                  backgroundColor:
                                                                  Colors
                                                                      .white,
                                                                ),
                                                                CircleAvatar(
                                                                  backgroundColor:
                                                                  Colors
                                                                      .grey,
                                                                  radius: 32,
                                                                  child: Icon(
                                                                    Icons.remove_red_eye,
                                                                    size: 32,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            'See Picture',
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                            .closed
                                            .then((value) {
                                          cubit.changeBottomSheetState(
                                            isShow: false,
                                          );
                                        });
                                      }
                                      // cubit.getProfileImage();
                                    },
                                    icon: Icon(Icons.camera_alt_rounded,size: 20,color: Colors.white,),),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (String? value)
                      {
                        if(value!.isEmpty){
                          return 'name must not be empty';
                        }
                        return null;
                      },
                      label: 'Name',
                      prefix: IconBroken.User,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  defaultFormField(
                    controller: bioController,
                    type: TextInputType.text,
                    validate: (String? value)
                    {
                      if(value!.isEmpty){
                        return 'bio must not be empty';
                      }
                      return null;
                    },
                    label: 'Bio',
                    prefix: IconBroken.Info_Circle,
                  ),

                  const SizedBox(
                    height: 10.0,
                  ),
                  defaultFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate: (String? value)
                    {
                      if(value!.isEmpty){
                        return 'phone must not be empty';
                      }
                      return null;
                    },
                    label: 'Phone',
                    prefix: IconBroken.Info_Circle,
                  ),

                ],
              ),
            ),
          ),
        );
      },
    );
  }
}