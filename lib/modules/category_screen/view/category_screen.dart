import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart'; 
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/firestore_keys.dart';
 import '../../../core/utils/functions/camil_case.dart';
 import '../../../core/widgets/loading_item.dart';

 import '../../../core/utils/size_config.dart';
import '../../../core/widgets/text_widget.dart';
 import 'widgets/cat_item.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: true,
          leading: const SizedBox.shrink(),
          title: TextWidget(
            text: 'Categories', 
            textSize: getFont(26),
            isBold: true,
          ),
        ),
        body:Stack(
            children: [
              Center(
                child: Image.asset(
                  "assets/images/zezo_white.png",
                  color: Theme.of(context).brightness.index == 0
                      ? Colors.white.withOpacity(.2)
                      : AppColors.blackColor.withOpacity(.1),
                  height: 600,
                  width: 500,
                  fit: BoxFit.cover,
                 ),
              ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(FirestoreKeys.category)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GridView.count(
                      padding: const EdgeInsets.all(8),
                      crossAxisCount: 2,
                      childAspectRatio: 4.8 / 5,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      children: List.generate(
                        snapshot.data!.docs.length,
                        (index) => CatItem(
                          title: snapshot.data!.docs[index].get("title"),
                          image: snapshot.data!.docs[index].get("category_image"),
                          passedColor:
                              Colors.primaries[index % Colors.primaries.length],
                          id: snapshot.data!.docs[index].id,
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        camilCaseMethod("Something went wrong try again!"),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: getFont(25),
                            fontWeight: FontWeight.bold,  ),
                      ),
                    );
                  }
                  return const LoadingItem();
                }),
          ],
        ));
  }
}
