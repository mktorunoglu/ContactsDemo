import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/bottomsheets/bottom_sheet_contact.dart';
import '../components/buttons/button_icon.dart';
import '../components/buttons/button_text.dart';
import '../components/texts/text.dart';
import '../components/texts/text_field.dart';
import '../components/views/view_list.dart';
import '../constants/constants_color.dart';
import '../extensions/extension_context.dart';
import '../helpers/helper_dialog.dart';
import '../helpers/helper_service.dart';
import '../models/model_response.dart';
import '../models/model_user.dart';

class ContactsScreen extends StatelessWidget {
  ContactsScreen({super.key}) {
    getUserList();
  }

  final Rx<ResponseModel?> userListResponse = (null as ResponseModel?).obs;
  final RxList<UserModel> userList = <UserModel>[].obs;
  final RxString searchText = "".obs;

  Future<void> getUserList() async => userListResponse.value =
      await ServiceHelper.instance.user().getAllUsers();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPage,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: context.dynamicPadding(left: 20, top: 20, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const MyText(
                    "Contacts",
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis,
                  ),
                  MyIconButton(
                    onPressed: showCreateContactBottomSheet,
                    iconSize: 30,
                    tooltip: "Create New Contact",
                    icon: Icons.add_circle,
                  ),
                ],
              ),
            ),
            MyTextField(
              margin: context.dynamicPadding(horizontal: 20, vertical: 10),
              textCapitalization: TextCapitalization.sentences,
              prefixIcon: Icons.search_outlined,
              hintText: "Search by name",
              unfocusOnClear: true,
              onChanged: (value) => searchText.value = value,
            ),
            Expanded(
              child: Obx(() {
                if (userListResponse.value == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (userListResponse.value!.success == true) {
                  userList.value = userListResponse.value!.data;
                } else {
                  //
                  Future.delayed(Duration.zero).whenComplete(() => Get.snackbar(
                        "ERROR",
                        userListResponse.value!.messages.toString(),
                      ));
                }
                return Obx(() {
                  if (userList.isEmpty) {
                    return Center(
                      child: MyListView(
                        padding: context.dynamicPadding(all: 20),
                        shrinkWrap: true,
                        children: [
                          Icon(
                            Icons.account_circle,
                            size: context.dynamicWidth(0.2),
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
                              onPressed: showCreateContactBottomSheet,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return MyListView(
                    padding: context.dynamicPadding(
                      horizontal: 20,
                      vertical: 10,
                      bottom: 10,
                    ),
                    children: userList
                        .map((user) => ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: MyText(user.id),
                              subtitle: MyText(user.firstName),
                              leading: user.profileImageUrl == null
                                  ? null
                                  : Image.network(user.profileImageUrl!),
                              onTap: () {},
                            ))
                        .toList(),
                  );
                });
              }),
            ),
          ],
        ),
      ),
    );
  }

  void showCreateContactBottomSheet() => DialogHelper.instance.showBottomSheet(
        ContactBottomSheet(userList: userList),
      );
}
