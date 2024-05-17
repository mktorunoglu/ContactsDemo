import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/bottomsheets/bottom_sheet_user.dart';
import '../components/buttons/button_icon.dart';
import '../components/buttons/button_text.dart';
import '../components/items/item_user.dart';
import '../components/texts/text.dart';
import '../components/texts/text_field.dart';
import '../components/views/view_list.dart';
import '../constants/constants.dart';
import '../constants/constants_color.dart';
import '../extensions/extension_context.dart';
import '../helpers/helper_dialog.dart';
import '../helpers/helper_service.dart';
import '../models/model_response.dart';
import '../models/model_user.dart';

class UsersScreen extends StatelessWidget {
  UsersScreen({super.key}) {
    loadUserList();
  }

  final Rx<ResponseModel?> userListResponse = (null as ResponseModel?).obs;
  final RxList<UserModel> userList = <UserModel>[].obs;
  final int userItemCount = 15;
  late final RxInt userItemCounter = userItemCount.obs;
  final RxString searchText = "".obs;

  Future<void> loadUserList() async => userListResponse.value =
      await ServiceHelper.instance.userService().getAllUsers(
            skip: 0,
            take: userItemCounter.value,
            search: searchText.value,
          );

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
                    onPressed: showUserBottomSheet,
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
              onChanged: (value) async {
                searchText.value = value;
                userItemCounter.value = userItemCount;
                await loadUserList();
              },
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
                  showErrorResponse(messages: userListResponse.value!.messages);
                }
                return Obx(() {
                  if (userList.isEmpty) {
                    return Center(
                      child: MyListView(
                        padding: context.dynamicPadding(all: 20),
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
                              onPressed: showUserBottomSheet,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: context.dynamicPadding(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    physics: const BouncingScrollPhysics(),
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      if (index + 1 == userItemCounter.value) {
                        userItemCounter.value += userItemCount;
                        ServiceHelper.instance
                            .userService()
                            .getAllUsers(
                              skip: userItemCounter.value - userItemCount,
                              take: userItemCount,
                              search: searchText.value,
                            )
                            .then((response) {
                          if (response.success == true) {
                            userList.addAll(response.data);
                          } else {
                            showErrorResponse(messages: response.messages);
                          }
                        });
                      }
                      return UserItem(
                        loadUserListFunction: loadUserList,
                        user: userList.elementAt(index),
                      );
                    },
                  );
                });
              }),
            ),
          ],
        ),
      ),
    );
  }

  void showErrorResponse({required List<String> messages}) =>
      DialogHelper.instance.showSnackbar(
        messages.isEmpty ? defaultErrorMessage : messages.first,
        isUnsuccessful: true,
        durationSeconds: 5,
      );

  void showUserBottomSheet() => DialogHelper.instance.showBottomSheet(
        UserBottomSheet(loadUserListFunction: loadUserList),
      );
}
