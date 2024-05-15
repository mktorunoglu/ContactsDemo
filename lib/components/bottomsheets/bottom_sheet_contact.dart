import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/constants_color.dart';
import '../../extensions/extension_context.dart';
import '../buttons/button_text.dart';
import '../texts/text.dart';
import '../texts/text_field.dart';
import '../views/view_list.dart';
import 'bottom_sheet.dart';

class ContactBottomSheet extends StatelessWidget {
  const ContactBottomSheet({super.key});

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
                  child: MyTextButton(
                    "Done",
                    isDisabled: true,
                    onPressed: () {},
                  ),
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
                  size: context.myWidth(0.5),
                ),
                Center(
                  child: MyTextButton(
                    "Add Photo",
                    color: Colors.black,
                    onPressed: () {},
                  ),
                ),
                const SizedBox(height: 20),
                textField(
                  hintText: "First name",
                  textCapitalization: TextCapitalization.words,
                ),
                textField(
                  hintText: "Last name",
                  textCapitalization: TextCapitalization.words,
                ),
                textField(
                  hintText: "Phone number",
                  textInputType: TextInputType.phone,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  MyTextField textField({
    required String hintText,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputType textInputType = TextInputType.name,
  }) {
    return MyTextField(
      margin: const EdgeInsets.only(bottom: 20),
      borderColor: Colors.black,
      backgroundColor: colorPage,
      hintText: hintText,
      textCapitalization: textCapitalization,
      textInputType: textInputType,
    );
  }
}
