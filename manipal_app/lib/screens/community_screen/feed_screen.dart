import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:manipal_app/screens/community_screen/add_post.dart';
import 'package:manipal_app/screens/community_screen/post_card.dart';

// class FeedScreen extends StatelessWidget {
//   const FeedScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         centerTitle: false,
//         // title: SvgPicture.asset(
//         //   'assets/ic_instagram.svg',
//         //   color: primaryColor,
//         //   height: 32,
//         // ),
//         actions: [
//           IconButton(
//             icon: const Icon(
//               Icons.messenger_outline,
//               color: Colors.black,
//             ),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('posts')
//             .orderBy('datePublished', descending: true)
//             .snapshots(),
//         builder: (context,
//             AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           return ListView.builder(
//             itemCount: snapshot.data!.docs.length,
//             itemBuilder: (ctx, index) => PostCard(
//               snap: snapshot.data!.docs[index].data(),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .orderBy('datePublished', descending: true)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (ctx, index) => PostCard(
              snap: snapshot.data!.docs[index].data(),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AddPostScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}