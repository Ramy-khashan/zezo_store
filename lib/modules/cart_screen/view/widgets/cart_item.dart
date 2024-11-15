import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../controller/cart_cubit.dart'; 
import '../../../../core/constants/route_key.dart';
import '../../../../core/utils/functions/camil_case.dart';
import '../../../../core/widgets/text_widget.dart';
import '../../../../core/utils/size_config.dart';
import '../../model/cart_model.dart';

class CartItem extends StatelessWidget {
  final CartModel cartProduct;
  final int index;
  const CartItem({super.key, required this.cartProduct, required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final controller = CartCubit.get(context);

        return InkWell(
          onTap: () {
            Navigator.pushNamed(context, RouteKeys.productDetailsScreen,
                arguments: (cartProduct.fields!.productId!.stringValue));
          },
          borderRadius: BorderRadius.circular(12),
          child: 
             Material(
              borderRadius: BorderRadius.circular(15),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 10,
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        height: getHeight(200),
                        width: getWidth(150),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                              ),
                        child: FancyShimmerImage(
                            imageUrl: cartProduct.fields!.productImage!.stringValue!),
                      ),
                    ),
                    SizedBox(
                      width: getWidth(10),
                    ),
                    Expanded(
                      flex: 10,
                      child: SizedBox(
                        height: getHeight(200),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextWidget(
                              text: camilCaseMethod(cartProduct.fields!.productName!.stringValue!), 
                              textSize: getFont(22),
                              isBold: true,
                            ),
                            TextWidget(
                                text:
                                    "${int.parse(cartProduct.fields!.quantity!.integerValue!) * (double.parse(cartProduct.fields!.price!.stringValue!))} LE", 
                                textSize: getFont(25)),
                            SizedBox(
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    child: IconButton(
                                        onPressed: () =>
                                            controller.qunatityMuins(index),
                                        icon: const Icon(Icons.remove)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: getWidth(15)),
                                    child: Text(
                                      cartProduct.fields!.quantity!.integerValue
                                          .toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: getFont(25)),
                                    ),
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    child: IconButton(
                                        onPressed: () =>
                                            controller.qunatityPlus(index),
                                        icon: const Icon(Icons.add)),
                                  ),
                                  const Spacer(),
                                  IconButton(
                  onPressed: () {
                    controller.deleteItem(
                        index: index, id: cartProduct.name!.split("/").last);
                  },
                  icon: Icon(
                    Icons.delete,
                    color: const Color.fromARGB(255, 223, 62, 62),
                    size: getWidth(30),
                  ),
                ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
           
            
        );
      },
    );
  }
}
