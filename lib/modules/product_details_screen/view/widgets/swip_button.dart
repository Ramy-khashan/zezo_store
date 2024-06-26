import 'package:flutter/material.dart';
import 'package:swipeable_button_view/swipeable_widget.dart';

class SwipeableButtonView extends StatelessWidget {
  final VoidCallback onWaitingProcess;
  final Widget buttonWidget;
  final Color backgroundColor;
  final Widget backWidget;
  final Alignment backWidgetAlign;
  final bool isAccepted;
  final bool isWaiting;
  const SwipeableButtonView({
    Key? key,
    required this.onWaitingProcess,
    required this.backgroundColor,
    required this.buttonWidget,
    required this.backWidget,
    this.backWidgetAlign = Alignment.centerRight,
    required this.isAccepted,
    required this.isWaiting,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isAccepted ? 56 : MediaQuery.of(context).size.width,
      height: 56,
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(30)),
      child: Stack(
        children: [
          Align(
            alignment: backWidgetAlign,
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: backWidget,
            ),
          ),
          !isAccepted
              ? SwipeableWidget(
                  height: 56,
                  onSwipeValueCallback: (value) {},
                  onSwipeCallback: onWaitingProcess,
                  isActive: true,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Material(
                      elevation: 5,
                      shape: const CircleBorder(),
                      child: Container(
                        width: 56,
                        height: 56,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle),
                        child: Center(
                          child: buttonWidget,
                        ),
                      ),
                    ),
                  ),
                )
              : Material(
                  elevation: 5,
                  shape: const CircleBorder(),
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle ),
                    child: Center(
                        child: isWaiting
                            ? CircularProgressIndicator(
                                color: backgroundColor,
                              )
                            : const Icon(
                                Icons.done,
                                color: Colors.green,
                                size: 30,
                              )),
                  ),
                ),
        ],
      ),
    );
  }
}
