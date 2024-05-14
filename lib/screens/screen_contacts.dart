import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/buttons/button_icon.dart';
import '../components/buttons/button_text.dart';
import '../components/container.dart';
import '../components/material.dart';
import '../components/texts/text.dart';
import '../components/views/view_list.dart';
import '../constants/constants_color.dart';
import '../models/model_account.dart';

class ContactsScreen extends StatelessWidget {
  ContactsScreen({super.key});

  final TextEditingController searchTec = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
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
            MyContainer(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              padding: const EdgeInsets.only(left: 10),
              borderRadius: 15,
              backgroundColor: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchTec,
                      focusNode: searchFocusNode,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.search_outlined,
                          color: colorGrey,
                        ),
                        hintText: "Search by name",
                        hintStyle: TextStyle(color: colorGrey),
                      ),
                      onChanged: (value) => searchText.value = value,
                    ),
                  ),
                  Obx(() => searchText.value.isEmpty
                      ? const SizedBox.shrink()
                      : MyMaterial(
                          child: MyIconButton(
                            onPressed: () {
                              searchText.value = "";
                              searchTec.clear();
                              searchFocusNode.unfocus();
                            },
                            tooltip: "Clear",
                            icon: Icons.cancel_outlined,
                          ),
                        )),
                ],
              ),
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
