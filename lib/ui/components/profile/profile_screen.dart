import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vn_crypto/bloc/profile/profile_bloc.dart';
import 'package:vn_crypto/bloc/profile/profile_event.dart';
import 'package:vn_crypto/bloc/profile/profile_state.dart';
import 'package:vn_crypto/ui/components/common/title_with_arrow.dart';
import 'package:vn_crypto/ultils/Constant.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  static const String PAGE_ROUTE_NAME = "/profile";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final List<String> titleSettingProfiles = [
    "Transactions",
    "Edit profile",
    "Change password",
    "Change language",
    "Logout"
  ];
  final MethodChannel documentChannel = const MethodChannel(MethodChannelConstant.documentChannel);
  final MethodChannel receiveImageChannel = const MethodChannel(MethodChannelConstant.receivePathChannel);
  final ProfileBloc profileBloc = ProfileBloc(ProfileInitialized());

  @override
  Widget build(BuildContext context) {
    receiveImageChannel.setMethodCallHandler(receiveImagePath);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppStrings.profile,
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
            )),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [avatarWidget("https://dragonball.guru/wp-content/uploads/2021/03/majin-buu-happy.jpg")],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  "Ngo Hoang Viet",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  "@vietkfc",
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return TitleWithArrow(
                        onPressed: onClickProfileSetting,
                        title: titleSettingProfiles[index],
                        colorArrow: AppColors.bluePrimary);
                  },
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => const Divider(
                        height: 1,
                      ),
                  itemCount: 5),
            ),
          )
        ],
      ),
    );
  }

  void onClickProfileSetting() {}

  Widget avatarWidget(String url) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: AppColors.bluePrimary, width: 3), shape: BoxShape.circle),
      child: GestureDetector(
          onTap: onOpenDocument,
          child: CircleAvatar(
            radius: 56,
            backgroundColor: Colors.white,
            child: ClipOval(
              child: SizedBox.fromSize(
                size: const Size.fromRadius(52),
                child: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
                  if (state is ProfilePickImageSuccess && state.pathImage.toString().isNotEmpty) {
                    return Image.asset(
                      ImageAssetString.logoAsset,
                      fit: BoxFit.cover,
                    );
                  } else {
                    return CachedNetworkImage(
                      imageUrl: url,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder: (context, url, progress) => const CircularProgressIndicator(
                        color: AppColors.bluePrimary,
                      ),
                    );
                  }
                }),
              ),
            ),
          )),
    );
  }

  void onOpenDocument() async {
    await documentChannel.invokeMethod(MethodChannelConstant.documentChannel);
  }

  Future<void> receiveImagePath(MethodCall call) async {
    if (call.method != MethodChannelConstant.receivePathChannel) return;
    final filePath = call.arguments.toString();
    profileBloc.add(ProfileGetImageUri(filePath));
  }
}
