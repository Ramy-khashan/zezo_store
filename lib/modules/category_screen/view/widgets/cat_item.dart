import 'package:flutter/material.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../core/widgets/image.dart';
// import '../../../../core/widgets/text_widget.dart';
import '../../../category_products/view/category_product_scren.dart';

class CatItem extends StatelessWidget {
  final String title;
  final String image;
  final String id;
  final Color passedColor;
  const CatItem({
    super.key,
    required this.title,
    required this.image,
    required this.passedColor,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CategoryProductScreen(categoryName: title, categoryId: id),
            ));
      },
      child: Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
              color: passedColor.withOpacity(.1),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: passedColor.withOpacity(.2),
                  blurRadius: 3,
                  spreadRadius: 1.5,
                )
              ]),
          child: GridTile(
              footer: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: passedColor.withOpacity(.6),
                ),
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              //  GridTileBar(
              //   backgroundColor: passedColor.withOpacity(.6),
              //   leading: Text(
              //     title,
              //     overflow: TextOverflow.ellipsis,
              //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              //   ),
              // ),
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: ImageHandler(
                  image,
                  boxFit: BoxFit.fill,
                ),
              ))),
    );
  }
}
