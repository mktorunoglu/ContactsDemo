import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/buttons/button_icon.dart';
import '../components/buttons/button_text.dart';
import '../components/texts/text.dart';
import '../components/texts/text_field.dart';
import '../components/views/view_list.dart';
import '../constants/constants_color.dart';
import '../models/model_account.dart';

class ContactsScreen extends StatelessWidget {
  ContactsScreen({super.key});

  final RxString searchText = "".obs;
  final RxList<ContactModel> contactList = <ContactModel>[].obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPage,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const MyText(
                    "Contacts",
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  MyIconButton(
                    onPressed: () {},
                    iconSize: 30,
                    tooltip: "Create New Contact",
                    icon: Icons.add_circle,
                  ),
                ],
              ),
            ),
            MyTextField(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              textCapitalization: TextCapitalization.sentences,
              prefixIcon: Icons.search_outlined,
              hintText: "Search by name",
              unfocusOnClear: true,
              onChanged: (value) => searchText.value = value,
            ),
            Expanded(
              child: Obx(() => contactList.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: MyListView(
                          shrinkWrap: true,
                          children: [
                            const Icon(
                              Icons.account_circle,
                              size: 80,
                              color: colorGrey,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: MyText(
                                "No Contacts",
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const MyText(
                              "Contacts you've added will appear here.",
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 5),
                            Center(
                              child: MyTextButton(
                                "Create New Contact",
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox.shrink()),
            ),
          ],
        ),
      ),
    );
  }
}
