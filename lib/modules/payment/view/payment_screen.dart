// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// // ignore: library_prefixes

// import '../../bottom_navigation_screen/view/bottom_navigation_screen.dart';
// import '../controller/payment_bloc.dart';

// class PaymentScreen extends StatelessWidget {
//   final String token;
//   final Map map;
//   const PaymentScreen({Key? key, required this.token, required this.map})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.pushAndRemoveUntil(
//             context,
//             MaterialPageRoute(
//               builder: (context) => const BottomNavigationScreen(),
//             ),
//             (route) => false);
//         return true;
//       },
//       child: BlocProvider(
//         create: (context) => PaymentBloc()..getUSerDetails(),
//         child: Scaffold(
//           appBar: AppBar(
//             leading: IconButton(
//               icon: Icon(
//                   Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios),
//               onPressed: () {
//                 Navigator.pushAndRemoveUntil(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const BottomNavigationScreen(),
//                     ),
//                     (route) => false);
//               },
//             ),
//             title: const Text(
//               "Payment",
//               style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
//             ),
//             centerTitle: true,
//             elevation: 3,
//             shadowColor: Colors.black,
//             scrolledUnderElevation: 3,
//           ),
//           body: BlocBuilder<PaymentBloc, PaymentState>(
//             builder: (context, state) {
//               final controller = PaymentBloc.get(context);
//               return webView.WebView(
//                 initialUrl:
//                     "https://accept.paymob.com/api/acceptance/iframes/384537?payment_token=$token",
//                 javascriptMode: JavascriptMode.unrestricted,
//                 onPageFinished: (url) {
//                   if (url.contains(
//                       "https://accept.paymobsolutions.com/api/acceptance/post_pay")) {

//                     controller.add(PaymentResponseEvent(context,
//                         map: map,
//                         paymentList: url.replaceAll("&", ",").split(",")));
//                   }
//                 },
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paymob_payment/paymob_payment.dart';

import '../../../core/constants/app_colors.dart';
import '../controller/payment_cubit.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key, required this.totalAmount});
  final double totalAmount;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paymob'),
      ),
      body: Stack(
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
          BlocProvider(
            create: (context) => PaymentCubit()..initializePayment(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlocBuilder<PaymentCubit, PaymentState>(
                builder: (context, state) {
                  final controller = PaymentCubit.get(context);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.network('https://paymob.com/images/logoC.png'),
                      const SizedBox(height: 24),
                      if (controller.paymobResponse != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text("Success ==> ${controller.paymobResponse?.success}"),
                            const SizedBox(height: 8),
                            Text(
                                "Transaction ID ==> ${controller.paymobResponse?.transactionID}"),
                            const SizedBox(height: 8),
                            Text("Message ==> ${controller.paymobResponse?.message}"),
                            const SizedBox(height: 8),
                            Text(
                                "controller.response Code ==> ${controller.paymobResponse?.responseCode}"),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ElevatedButton(
                        child:   Text('Pay for ${totalAmount} EGP'),
                        onPressed: () => PaymobPayment.instance.pay(
                          context: context,
                          currency: "EGP",
                          amountInCents: (totalAmount*10).toString(),
                          onPayment: (response) {
                            controller.setResponse(response);
                          },
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
