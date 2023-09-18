import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: library_prefixes
import 'package:webview_flutter/webview_flutter.dart' as webView;
import 'package:webview_flutter/webview_flutter.dart';

import '../../bottom_navigation_screen/view/bottom_navigation_screen.dart';
import '../controller/payment_bloc.dart';

class PaymentScreen extends StatelessWidget {
  final String token;
  final Map map;
  const PaymentScreen({Key? key, required this.token, required this.map})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const BottomNavigationScreen(),
            ),
            (route) => false);
        return true;
      },
      child: BlocProvider(
        create: (context) => PaymentBloc()..getUSerDetails(),
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                  Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BottomNavigationScreen(),
                    ),
                    (route) => false);
              },
            ),
            title: const Text(
              "Payment",
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            elevation: 3,
            shadowColor: Colors.black,
            scrolledUnderElevation: 3,
          ),
          body: BlocBuilder<PaymentBloc, PaymentState>(
            builder: (context, state) {
              final controller = PaymentBloc.get(context);
              return webView.WebView(
                initialUrl:
                    "https://accept.paymob.com/api/acceptance/iframes/384537?payment_token=$token",
                javascriptMode: JavascriptMode.unrestricted,
                onPageFinished: (url) {
                  if (url.contains(
                      "https://accept.paymobsolutions.com/api/acceptance/post_pay")) {
                    
                    controller.add(PaymentResponseEvent(context,
                        map: map,
                        paymentList: url.replaceAll("&", ",").split(",")));
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
