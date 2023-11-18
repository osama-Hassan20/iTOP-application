import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../models/post_model.dart';
import '../styles/icon_broken.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  ValueChanged? onSubmit,
  bool isPassword = false ,
  ValueChanged? onChanged,
  GestureTapCallback? onTap,
  required FormFieldValidator<String>? validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  VoidCallback? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted:onSubmit,
      onChanged: onChanged,
      validator:validate,
      onTap: onTap,
      enabled: isClickable,
      decoration: InputDecoration(
        labelText: label,

        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix !=null ? IconButton(
          onPressed:  suffixPressed,

          icon: Icon(
            suffix,
          ),
        ) :null,
        border: OutlineInputBorder() ,
      ),
    );


//******************************************************************************
//******************************************************************************


Widget defaultTextButton({
  required VoidCallback? function,
  required String text,
  Color? color ,
})=>TextButton(

  onPressed: function,
  child: Text(text.toUpperCase(),style: TextStyle(
    color: color??Colors.teal,
  ),),
);


//******************************************************************************

//******************************************************************************
Widget defaultButton ({
  Color background = Colors.blue,
  bool isUpperCase = true,
  required VoidCallback function,
  required String text,

}) =>
    Container(


      child: MaterialButton(
        onPressed: function ,
        child: Text(
          isUpperCase ? text.toUpperCase(): text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // color: background,
        gradient: LinearGradient(
          colors: [
            Colors.teal,
            Color(0xFF43658b),

          ],
        ),
      ),
    ) ;
//******************************************************************************
//******************************************************************************

void navigateTo(context ,widget ) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget ,
  ),
);

void navigateAndFinish(context ,widget ) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => widget ,
  ),
      (route) {
    return false;
  },
);


void ShowToast({
  required String text,
  required ToastState state,
}) => Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor:chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastState {SUCCESS , ERROR , WORNING , SOON}

Color? chooseToastColor (ToastState state)
{
  Color color;
  switch(state)
  {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
    case ToastState.WORNING:
      color = Colors.amber;
      break;
    case ToastState.SOON:
      color = Colors.grey;
      break;
  }
  return color;
}


void comingSoon(){
  ShowToast(text: 'Coming Soon', state: ToastState.SOON);
}

PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) =>
    AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          IconBroken.Arrow___Left_2,
        ),
      ),
      title: Text(title ?? ''),
      titleSpacing: 5.0,
      actions: actions,
    );





class FullScreenImage extends StatelessWidget {
  final String imagePath;

  FullScreenImage({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // لتحديد خلفية سوداء للشاشة الكاملة
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context); // لاغلاق الشاشة الكاملة عند النقر
        },
        child: Stack(
          children: [
            Center(
              child: Hero(
                tag: 'imageHero', // تعيين علامة لـ Hero لإظهار الصورة كاملة الشاشة بشكل سلس عند النقر
                child: Image.network(imagePath), // استخدام الصورة من الشبكة كمثال، يمكنك استبدالها بمسار محلي إذا لزم الأمر
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//***********show tags*************
Widget tagsPost(String text, context,cubit){
  List<TextSpan> getSpans() {
    List<TextSpan> spans = [];
    List<String> words = text.split(' ');

    for (String word in words) {
      if (word.startsWith('#')) {
        spans.add(
          TextSpan(
            text: word + ' ',
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      } else {
        spans.add(
          TextSpan(text: word + ' ',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        );
      }
    }

    return spans;
  }

  return RichText(
    text: TextSpan(
      children: getSpans(),
    ),
    // style: Theme.of(context).textTheme.titleMedium,
    maxLines: cubit.isExpanded ? 100 : 3,
    overflow: TextOverflow.ellipsis,
    textDirection: '${text}'.contains(RegExp(r'[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\uFB50-\uFDFF\uFE70-\uFEFF]')) ? TextDirection.rtl : TextDirection.ltr,
  );
}



//***********buildPostItem*************
Widget buildPostItem(PostModel model, context, index) {
  SocialCubit cubit = SocialCubit.get(context);

  if (cubit.commentControllers.length <= index) {
    cubit.commentControllers.add(TextEditingController());
    cubit.sendIconColors.add(Colors.grey);
  }
  TextEditingController commentController = cubit.commentControllers[index];

  Color color = cubit.sendIconColors[index];

  return BlocConsumer<SocialCubit, SocialStates>(
    listener: (context, state) {},
    builder: (context, state) {
      return Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5.0,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(
                      '${model.image}',
                    ),
                    radius: 25.0,
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${model.name}',
                              style: const TextStyle(
                                  height: 1.4,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                              ),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            const Icon(
                              Icons.public,
                              // color: defaultColor,
                              size: 16.0,
                            ),
                          ],
                        ),
                        Text(
                          '${model.dateTime}',
                          style:
                          Theme.of(context).textTheme.bodySmall!.copyWith(
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_horiz,
                      size: 24.0,
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 15.0,
                ),
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),


              // Text(
              //   '${model.text}',
              //   textDirection: '${model.text}'.contains(RegExp(r'[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\uFB50-\uFDFF\uFE70-\uFEFF]')) ? TextDirection.rtl : TextDirection.ltr,
              //   style: Theme.of(context).textTheme.titleMedium,
              //   maxLines: cubit.isExpanded ? 100 : 3,
              //   overflow: TextOverflow.ellipsis,
              // ),
              tagsPost( '${model.text}',context,cubit),
              InkWell(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      cubit.isExpanded ? 'Show Less' : 'Show More',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
                onTap: () {
                  cubit.changeTextShowMore();
                },
              ),
              // if post has image
              if (model.postImage != '')
                Container(
                  margin: const EdgeInsetsDirectional.only(
                    end: 10.0,
                    start: 10.0,
                    top: 15.0,
                  ),
                  height: 140.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    image: DecorationImage(
                      image: NetworkImage(
                        '${model.postImage}',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {

                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            children: [
                              const Icon(
                                IconBroken.Heart,
                                size: 16.0,
                                color: Colors.red,
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              if (cubit.likes.isNotEmpty &&
                                  index < cubit.likes.length)
                                Text(
                                  '${cubit.likes[index]}',
                                  style:
                                  Theme.of(context).textTheme.bodySmall,
                                ),
                              if (cubit.likes.isEmpty)
                                Text(
                                  '0',
                                  style:
                                  Theme.of(context).textTheme.bodySmall,
                                ),
                            ],
                          ),
                        ),

                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                           cubit.getAllComment(postId: cubit.postsId[index]);
                          cubit.scaffoldKey.currentState
                              ?.showBottomSheet(
                                  (context) =>
                                       SizedBox(
                                        height: double.infinity,
                                        width: double.infinity,
                                        // color: Colors.grey[300],
                                         child: ConditionalBuilder(
                                           condition:cubit.commentView.length != 0,
                                           // condition: state != CommentViewPostLoadingState,
                                           builder: (context) =>
                                             cubit.commentView.length >=1 ?
                                              Column(
                                               children: [
                                                 ListView.separated(
                                                   shrinkWrap: true,
                                                   physics: NeverScrollableScrollPhysics(),
                                                   itemBuilder: (context , index) =>ListTile(
                                                     leading: CircleAvatar(//cubit.commentView[index]
                                                       backgroundImage:
                                                       NetworkImage('${cubit.commentView[index].image}'),
                                                     ),
                                                     title: Container(
                                                         decoration: BoxDecoration(
                                                             color: Colors.grey[300],
                                                             borderRadius: BorderRadius.only(
                                                               topRight: Radius.circular(20),
                                                               topLeft: Radius.circular(20),
                                                             )
                                                         ),
                                                         child: Padding(
                                                           padding: const EdgeInsets.only(left: 8,top: 8),
                                                           child: Text('${cubit.commentView[index].name}'),
                                                         )),
                                                     subtitle: Container(
                                                         decoration: BoxDecoration(
                                                             color: Colors.grey[300],
                                                             borderRadius: BorderRadius.only(
                                                                 bottomLeft: Radius.circular(20),
                                                                 bottomRight: Radius.circular(20)
                                                             )
                                                         ),
                                                         child: Padding(
                                                           padding: const EdgeInsets.all(8),
                                                           child: Text('${cubit.commentView[index].comment}'),
                                                         )),
                                                     // trailing: Text(comment.createdAt.toString()),
                                                   ),
                                                   separatorBuilder: (context , index) =>const SizedBox(
                                                     height: 8.0,
                                                   ),
                                                   itemCount: cubit.commentView.length,
                                                 ),
                                                 Spacer(),
                                                 Spacer(),
                                                 Expanded(
                                                   child: InkWell(
                                                     child: Row(
                                                       children: [
                                                         CircleAvatar(
                                                           backgroundColor: Colors.transparent,
                                                           backgroundImage: NetworkImage('${cubit.userModel!.image}'),
                                                           radius: 18.0,
                                                         ),
                                                         const SizedBox(
                                                           width: 15.0,
                                                         ),
                                                         Expanded(
                                                           child: TextFormField(
                                                             autofocus: true,
                                                             onChanged: (value) {
                                                               cubit.sendIconColors[index] = value.isNotEmpty
                                                                   ? Colors.blue
                                                                   : Colors.grey;
                                                               cubit.changeTextField();
                                                             },
                                                             onSaved: (value) {},
                                                             decoration: InputDecoration(
                                                               contentPadding: EdgeInsets.symmetric(vertical: 0.0),
                                                               border: OutlineInputBorder(

                                                                 borderRadius: BorderRadius.circular(100),
                                                               ),
                                                               hintText: commentController.text == ''
                                                                   ? ' Write Comment ... '
                                                                   : commentController.text,
                                                             ),
                                                             controller: commentController,
                                                           ),
                                                         ),
                                                         IconButton(
                                                             icon: Icon(Icons.send, color: color),
                                                             onPressed: () {
                                                               if (commentController.text != '' &&
                                                                   commentController.text !=
                                                                       ' Write Comment ... ' &&
                                                                   color == Colors.blue) {
                                                                 cubit.createCommentPost(
                                                                   postId: cubit.postsId[index],
                                                                   comment: commentController.text,
                                                                 );
                                                                 cubit.getPosts();
                                                                 print("send comment");
                                                                 commentController.text =
                                                                 " Write Comment ... ";
                                                               }
                                                             }),
                                                       ],
                                                     ),
                                                     onTap: () {},
                                                   ),
                                                 ),
                                               ],
                                             )
                                                 :  Column(
                                               mainAxisAlignment: MainAxisAlignment.center,
                                               children: [
                                                 Icon(
                                                   Icons.comment,
                                                   size: 100,
                                                   color: Colors.grey[300],

                                                 ),
                                                 Text(
                                                   'No comments yet',
                                                   style: TextStyle(
                                                       fontSize: 18
                                                   ),
                                                 ),
                                                 Text('Be the frist comment',
                                                   style: TextStyle(
                                                       fontSize: 18
                                                   ),
                                                 ),
                                                 Spacer(),
                                                 Expanded(
                                                   child: InkWell(
                                                     child: Row(
                                                       children: [
                                                         CircleAvatar(
                                                           backgroundColor: Colors.transparent,
                                                           backgroundImage: NetworkImage('${cubit.userModel!.image}'),
                                                           radius: 18.0,
                                                         ),
                                                         const SizedBox(
                                                           width: 5.0,
                                                         ),
                                                         Expanded(
                                                           child: TextFormField(
                                                             autofocus: true,
                                                             onChanged: (value) {
                                                               cubit.sendIconColors[index] = value.isNotEmpty
                                                                   ? Colors.blue
                                                                   : Colors.grey;
                                                               cubit.changeTextField();
                                                             },
                                                             onSaved: (value) {},
                                                             decoration: InputDecoration(
                                                               contentPadding: EdgeInsets.symmetric(vertical: 0.0),
                                                               border: OutlineInputBorder(

                                                                 borderRadius: BorderRadius.circular(100),
                                                               ),
                                                               hintText: commentController.text == ''
                                                                   ? ' Comment as ${cubit.userModel!.name}... '
                                                                   : commentController.text,
                                                             ),
                                                             controller: commentController,
                                                           ),
                                                         ),
                                                         IconButton(
                                                             icon: Icon(Icons.send, color: color),
                                                             onPressed: () {
                                                               if (commentController.text != '' &&
                                                                   commentController.text !=
                                                                       ' Write Comment ... ' &&
                                                                   color == Colors.blue) {
                                                                 cubit.createCommentPost(
                                                                   postId: cubit.postsId[index],
                                                                   comment: commentController.text,
                                                                 );
                                                                 cubit.getPosts();
                                                                 cubit.getAllComment(postId: cubit.postsId[index]);
                                                                 print("send comment");
                                                                 commentController.text =
                                                                 " Write Comment ... ";
                                                               }
                                                             }),
                                                       ],
                                                     ),
                                                     onTap: () {},
                                                   ),
                                                 ),
                                               ],
                                             ),

                                           fallback: (context) =>
                                           const Center(child: CircularProgressIndicator()),
                                         ),

                                      ),

                          );

                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(
                                IconBroken.Chat,
                                size: 16.0,
                                color: Colors.amber,
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              if (cubit.comments.isNotEmpty &&
                                  index < cubit.comments.length)
                                Text(
                                  '${cubit.comments[index]} comment',
                                  style:
                                  Theme.of(context).textTheme.bodySmall,
                                ),
                              if (cubit.comments.isEmpty)
                                Text(
                                  '0 comment',
                                  // '${cubit.comments.length} comment',
                                  style:
                                  Theme.of(context).textTheme.bodySmall,
                                ),
                            ],
                          ),
                        ),

                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  bottom: 10.0,
                ),
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  InkWell(
                    child: Row(
                      children: [
                        const Icon(
                          IconBroken.Heart,
                          size: 16.0,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'Like',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    onTap: () {
                      cubit.likePost(cubit.postsId[index]);
                    },
                  ),
                  InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(
                          IconBroken.Chat,
                          size: 16.0,
                          color: Colors.grey,
                        ),

                          Text(
                            'comment',
                            style:
                            Theme.of(context).textTheme.bodySmall,
                          ),

                      ],
                    ),
                    onTap: () {
                      cubit.likePost(cubit.postsId[index]);
                    },
                  ),
                  InkWell(
                    child: Row(
                      children: [
                        const Icon(
                          IconBroken.Send,
                          size: 16.0,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          width: 1.0,
                        ),
                        Text(
                          'Send',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    onTap: () {
                      Share.share('${cubit.postsId[index]}');
                      // cubit.likePost(cubit.postsId[index]);
                    },
                  ),
                  InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(
                          Icons.share,
                          size: 16.0,
                          color: Colors.grey,
                        ),

                          Text(
                            'Share',
                            style:
                            Theme.of(context).textTheme.bodySmall,
                          ),

                      ],
                    ),
                    onTap: () {
                      comingSoon();

                    },
                  ),

                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}






