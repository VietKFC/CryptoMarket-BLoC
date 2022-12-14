import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/link.dart';
import 'package:vn_crypto/bloc/theme/theme_bloc.dart';
import 'package:vn_crypto/bloc/theme/theme_event.dart';
import 'package:vn_crypto/ui/components/common/title_with_arrow.dart';
import 'package:vn_crypto/ui/components/profile/profile_screen.dart';
import 'package:vn_crypto/ultils/Constant.dart';

class AboutAppScreen extends StatefulWidget {
  const AboutAppScreen({Key? key}) : super(key: key);

  @override
  State<AboutAppScreen> createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen> {
  bool isDarkTheme = false;
  final _controller = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();

    _controller.addListener(() => setState(() {
          if (_controller.value) {
            isDarkTheme = true;
          } else {
            isDarkTheme = false;
          }
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(AppStrings.titleAboutApp,
              textDirection: TextDirection.ltr, style: TextStyle(color: Colors.black))),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, top: 32, right: 16),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TitleWithArrow(
                onPressed: navigateToProfile,
                title: AppStrings.profile,
                colorArrow: AppColors.bluePrimary,
              ),
              Container(height: 1, color: Colors.grey[200]),
              Link(
                  uri: Uri.parse(AppStrings.textLinkPolicy),
                  builder: (_, link) => TitleWithArrow(
                        onPressed: link,
                        title: AppStrings.textPolicy,
                        colorArrow: AppColors.bluePrimary,
                      )),
              Container(height: 1, color: Colors.grey[200]),
              Link(
                  uri: Uri.parse(AppStrings.textLinkFAQ),
                  builder: (_, link) => TitleWithArrow(
                        onPressed: link,
                        title: AppStrings.textFAQ,
                        colorArrow: AppColors.bluePrimary,
                      )),
              Container(height: 1, color: Colors.grey[200]),
              TitleWithArrow(
                onPressed: () => Share.share("VnCrypto"),
                title: AppStrings.textShareApp,
                colorArrow: AppColors.bluePrimary,
              ),
              Container(height: 1, color: Colors.grey[200]),
              changeTheme()
            ],
          ),
        ),
      ),
    );
  }

  void navigateToProfile() {
    Navigator.pushNamed(context, ProfileScreen.PAGE_ROUTE_NAME);
  }

  Widget changeTheme() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const Expanded(child: Text(AppStrings.textTheme, style: TextStyle(fontSize: 14))),
          AdvancedSwitch(
              width: 48,
              height: 24,
              controller: _controller,
              activeColor: Colors.black12,
              inactiveColor: Colors.black12,
              thumb: ValueListenableBuilder<bool>(
                  valueListenable: _controller,
                  builder: (context, value, child) {
                    final themeBloc = BlocProvider.of<ThemeBloc>(context);
                    themeBloc.add(ChangeTheme(isDarkTheme));
                    return thumbSwitch(iconData: isDarkTheme ? Icons.nights_stay : Icons.wb_sunny);
                  }))
        ],
      ),
    );
  }

  Widget thumbSwitch({required IconData iconData}) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Icon(iconData, size: 16),
    );
  }
}
