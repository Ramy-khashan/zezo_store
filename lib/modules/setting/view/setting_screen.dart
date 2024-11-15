import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:store/core/constants/app_colors.dart';
import '../../../config/changetheme/changetheme_cubit.dart';
import '../../../config/changetheme/changetheme_states.dart';
import '../../../core/constants/route_key.dart';
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
    return SafeArea(
      child: BlocProvider(
          create: (context) => SettingsCubit()..getUserData(),
          child: Scaffold(body: BlocBuilder<SettingsCubit, SettingsState>(
              builder: (context, state) {
            final controller = SettingsCubit.get(context);
            return Stack(
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
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              foregroundColor: Colors.transparent,
                              backgroundImage: NetworkImage(controller.image!),
                              radius: (50),
                            ),
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
                        onPressed: () => Navigator.pushNamed(
                            context, RouteKeys.ordersScreen),
                        title: 'Orders',
                      ),
                      ListTileWidget(
                        icon: IconlyLight.ticketStar,
                        onPressed: () {
                          Navigator.pushNamed(context, RouteKeys.specailOrder);
                        },
                        title: 'Special Orders',
                      ),
                      ListTileWidget(
                        icon: IconlyLight.heart,
                        onPressed: () {
                          Navigator.pushNamed(
                              context, RouteKeys.wishListScreen);
                        },
                        title: 'Wishlist',
                      ),
                      ListTileWidget(
                        icon: Icons.report,
                        onPressed: () {
                          Navigator.pushNamed(context, RouteKeys.reportsScreen);
                        },
                        title: 'Report',
                      ),
                      controller.isGoogleSign!
                          ? const SizedBox()
                          : ListTileWidget(
                              icon: IconlyLight.unlock,
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, RouteKeys.resetPasswordScreen);
                              },
                              title: 'Reset password',
                            ),
                      BlocBuilder<ChangeTheme, ChangeThemeState>(
                        builder: (context, state) {
                          final controller = ChangeTheme.get(context);
                          return ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            leading: const Icon(Icons.dark_mode_outlined),
                            title: const Text(
                              "Dark Mode",
                              style: TextStyle(fontSize: 18),
                            ),
                            trailing: Switch(
                              onChanged: (val) {
                                controller.changeTheme();
                              },
                              value: controller.isDark,
                            ),
                          );
                        },
                      ),
                      ListTileWidget(
                        icon: IconlyLight.logout,
                        onPressed: () async {
                          await showLogoutDialog(context);
                        },
                        title: 'Logout',
                      ),
                    ],
                  ),
                ),
              ],
            );
          }))),
    );
  }
}
