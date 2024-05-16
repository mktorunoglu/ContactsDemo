import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/constants_color.dart';
import '../../helpers/helper_dialog.dart';
import '../../models/model_user.dart';
import '../buttons/button_text.dart';
import '../texts/text.dart';
import '../texts/text_field.dart';
import '../views/view_list.dart';
import 'bottom_sheet.dart';
import 'bottom_sheet_picker_image.dart';

class UserBottomSheet extends StatelessWidget {
  UserBottomSheet({
    super.key,
    required this.userList,
    this.user,
  });

  final RxList<UserModel> userList;
  final UserModel? user;

  final RxString firstName = "".obs;
  final RxString lastName = "".obs;
  final RxString phone = "".obs;
  final RxBool inProgress = false.obs;

  bool get isDone =>
      firstName.isNotEmpty && lastName.isNotEmpty && phone.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return MyBottomSheet(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: MyTextButton(
                    "Cancel",
                    onPressed: Get.back,
                  ),
                ),
              ),
              Expanded(
                child: MyText(
                  user == null ? "New Contact" : "Profile",
                  textAlign: TextAlign.center,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Obx(() => MyTextButton(
                        "Done",
                        isDisabled: inProgress.value || !isDone,
                        onPressed: saveUser,
                      )),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: MyListView(
              children: [
                const Icon(
                  Icons.account_circle,
                  color: colorGrey,
                  size: 200,
                ),
                Center(
                  child: Obx(() => MyTextButton(
                        "Add Photo",
                        color: Colors.black,
                        isDisabled: inProgress.value,
                        onPressed: () => DialogHelper.instance.showBottomSheet(
                          const ImagePickerBottomSheet(),
                          isScrollControlled: false,
                        ),
                      )),
                ),
                const SizedBox(height: 20),
                textField(
                  hintText: "First name",
                  textCapitalization: TextCapitalization.words,
                  onChanged: (text) => firstName.value = text,
                ),
                textField(
                  hintText: "Last name",
                  textCapitalization: TextCapitalization.words,
                  onChanged: (text) => lastName.value = text,
                ),
                textField(
                  hintText: "Phone number",
                  textInputType: TextInputType.phone,
                  onChanged: (text) => phone.value = text,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> saveUser() async {
    inProgress.value = true;
    await Future.delayed(Duration(seconds: 2));
    Get.back();
  }

  Obx textField({
    required String hintText,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputType textInputType = TextInputType.name,
    required Function(String text) onChanged,
  }) {
    return Obx(() => MyTextField(
          margin: const EdgeInsets.only(bottom: 20),
          borderColor: Colors.black,
          backgroundColor: colorPage,
          hintText: hintText,
          hintColor: Colors.grey,
          textCapitalization: textCapitalization,
          textInputType: textInputType,
          onChanged: onChanged,
          readOnly: inProgress.value,
        ));
  }
}
