import 'package:flutter/material.dart';

import '../../helpers/helper_dialog.dart';
import '../../models/model_user.dart';
import '../avatars/avatar_image.dart';
import '../bottomsheets/bottom_sheet_user.dart';
import '../buttons/button.dart';
import '../texts/text.dart';

class UserItem extends StatelessWidget {
  const UserItem({
    super.key,
    required this.loadUserListFunction,
    required this.user,
  });

  final Function() loadUserListFunction;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: MyButton(
        padding: const EdgeInsets.all(15),
        backgroundColor: Colors.white,
        onPressed: () => DialogHelper.instance.showBottomSheet(
          UserBottomSheet(
            loadUserListFunction: loadUserListFunction,
            user: user,
          ),
        ),
        child: Row(
          children: [
            MyImageAvatar(
              imageUrl: user.profileImageUrl,
              size: 40,
              placeholderIconSize: 40,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    "${user.firstName ?? ""} ${user.lastName ?? ""}",
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  MyText(
                    user.phoneNumber,
                    color: Colors.grey,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
