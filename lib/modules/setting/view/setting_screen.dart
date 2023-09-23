import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import '../../../core/constants/route_key.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/text_widget.dart';
import '../../../core/utils/size_config.dart';
import '../controller/settings_cubit.dart';
import 'widgets/list_tile_widget.dart';
import 'widgets/log_out.dart';

class SettingsSCreen extends StatelessWidget {
  const SettingsSCreen({super.key});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
        create: (context) => SettingsCubit()..getUserData(),
        child: Scaffold(body: BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
          final controller = SettingsCubit.get(context);
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
                horizontal: getWidth(8), vertical: getHeight(25)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: getHeight(10),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(controller.image!),
                      radius: getWidth(70),
                    ),
                    SizedBox(
                      height: getHeight(15),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: getWidth(12)),
                      child: RichText(
                        text: TextSpan(
                          text: 'Hi, ',
                          style: TextStyle(
                            color: Colors.cyan,
                            fontSize: getFont(30),
                            fontWeight: FontWeight.bold,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: controller.name,
                              style: TextStyle(
                                color: AppColors.whiteColor,
                                fontSize: getFont(30),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getHeight(5),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: TextWidget(
                        text: controller.email!,
                        color: AppColors.whiteColor,
                        textSize: getFont(20),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: getHeight(20),
                ),
                const Divider(
                  thickness: 2.0,
                ),
                SizedBox(
                  height: getHeight(20),
                ),

                ListTileWidget(
                  icon: IconlyLight.bag,
                  color: AppColors.whiteColor,
                  onPressed: () =>
                      Navigator.pushNamed(context, RouteKeys.ordersScreen),
                  title: 'Orders',
                ),
                ListTileWidget(
                  icon: IconlyLight.ticketStar,
                  color: AppColors.whiteColor,
                  onPressed: () {
                    Navigator.pushNamed(context, RouteKeys.specailOrder);
                  },
                  title: 'Special Orders',
                ),
                ListTileWidget(
                  icon: IconlyLight.heart,
                  color: AppColors.whiteColor,
                  onPressed: () {
                    Navigator.pushNamed(context, RouteKeys.wishListScreen);
                  },
                  title: 'Wishlist',
                ),             ListTileWidget(
                  icon: Icons.report,
                  color: AppColors.whiteColor,
                  onPressed: () {
                    Navigator.pushNamed(context, RouteKeys.reportsScreen);
                  },
                  title: 'Report',
                ),
                // ListTileWidget(
                //   icon: IconlyLight.show,
                //   color: AppColors.whiteColor,
                //   onPressed: () =>
                //       Navigator.pushNamed(context, RouteKeys.viewedScreen),
                //   title: 'Viewed',
                // ),
                controller.isGoogleSign!
                    ? const SizedBox()
                    : ListTileWidget(
                        icon: IconlyLight.unlock,
                        color: AppColors.whiteColor,
                        onPressed: () {
                          Navigator.pushNamed(
                              context, RouteKeys.resetPasswordScreen);
                        },
                        title: 'Reset password',
                      ),
                ListTileWidget(
                  icon: IconlyLight.logout,
                  color: AppColors.whiteColor,
                  onPressed: () async {
                    await showLogoutDialog(context);
                  },
                  title: 'Logout',
                ),
              ],
            ),
          );
        })));
  }
}
