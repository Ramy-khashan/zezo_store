import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class SwiperSlder extends StatelessWidget {
  const SwiperSlder({
    super.key, 
    required this.list, 
  }); 
  final List<String> list; 
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Swiper( 
          itemBuilder: (BuildContext context, int index) {
            return Image.asset(
              list[index],
              fit: BoxFit.fill,
            );
          },
          autoplay: true,
          itemCount: list.length,
 
        ),
        Container(
          color: Colors.black.withOpacity(.4),
        ),
          ],
    );
  }
}
