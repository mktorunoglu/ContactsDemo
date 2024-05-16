import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/constants_color.dart';
import '../../extensions/extension_context.dart';
import '../../helpers/helper_dialog.dart';
import '../../models/model_user.dart';
import '../buttons/button_text.dart';
import '../texts/text.dart';
import '../texts/text_field.dart';
import '../views/view_list.dart';
import 'bottom_sheet.dart';
import 'bottom_sheet_picker_image.dart';

class ContactBottomSheet extends StatelessWidget {
  ContactBottomSheet({
    super.key,
    required this.userList,
  });

  final RxList<UserModel> userList;

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
              const Expanded(
                child: MyText(
                  "New Contact",
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
                        onPressed: saveContact,
                      )),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: MyListView(
              children: [
                Icon(
                  Icons.account_circle,
                  color: colorGrey,
                  size: context.dynamicWidth(0.5),
                ),
                Center(
                  child: MyTextButton(
                    "Add Photo",
                    color: Colors.black,
                    onPressed: () => DialogHelper.instance.showBottomSheet(
                      const ImagePickerBottomSheet(),
                      isScrollControlled: false,
                    ),
                  ),
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

  Future<void> saveContact() async {
    inProgress.value = true;
    await Future.delayed(Duration(seconds: 2));
    Get.back();
  }

  MyTextField textField({
    required String hintText,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputType textInputType = TextInputType.name,
    required Function(String text) onChanged,
  }) {
    return MyTextField(
      margin: const EdgeInsets.only(bottom: 20),
      borderColor: Colors.black,
      backgroundColor: colorPage,
      hintText: hintText,
      hintColor: Colors.grey,
      textCapitalization: textCapitalization,
      textInputType: textInputType,
      onChanged: onChanged,
    );
  }
}
