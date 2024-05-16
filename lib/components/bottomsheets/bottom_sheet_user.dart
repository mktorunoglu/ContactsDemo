import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/constants.dart';
import '../../constants/constants_color.dart';
import '../../helpers/helper_dialog.dart';
import '../../helpers/helper_route.dart';
import '../../helpers/helper_service.dart';
import '../../models/model_response.dart';
import '../../models/model_user.dart';
import '../avatars/avatar_image.dart';
import '../buttons/button_text.dart';
import '../texts/text.dart';
import '../texts/text_field.dart';
import '../views/view_list.dart';
import 'bottom_sheet.dart';
import 'bottom_sheet_action.dart';
import 'bottom_sheet_picker_image.dart';

class UserBottomSheet extends StatelessWidget {
  UserBottomSheet({
    super.key,
    this.user,
  });

  final UserModel? user;

  late final RxString userId = (user?.id ?? "").obs;
  late final RxString firstName = (user?.firstName ?? "").obs;
  late final RxString lastName = (user?.lastName ?? "").obs;
  late final RxString phoneNumber = (user?.phoneNumber ?? "").obs;
  late final RxString imageUrl = (user?.profileImageUrl ?? "").obs;
  final RxString imageFilePath = "".obs;
  late final RxBool isEdit = (user == null).obs;
  final RxBool inProgress = false.obs;

  bool get isDone =>
      firstName.isNotEmpty && lastName.isNotEmpty && phoneNumber.isNotEmpty;
  bool get isImageSelected => imageUrl.isNotEmpty || imageFilePath.isNotEmpty;

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
                    fontWeight: FontWeight.normal,
                    onPressed: RouteHelper.instance.getBackAsync,
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
                        isEdit.value ? "Done" : "Edit",
                        isDisabled: inProgress.value || !isDone,
                        onPressed:
                            isEdit.value ? saveUser : () => isEdit.value = true,
                      )),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: MyListView(
              children: [
                Obx(() => isImageSelected
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: MyImageAvatar(
                            imageUrl: imageUrl.value,
                            imageFilePath: imageFilePath.value,
                            size: 180,
                          ),
                        ),
                      )
                    : const Icon(
                        Icons.account_circle,
                        color: colorGrey,
                        size: 200,
                      )),
                Center(
                  child: Obx(() => MyTextButton(
                        "${isImageSelected ? "Change" : "Add"} Photo",
                        color: Colors.black,
                        isDisabled: inProgress.value,
                        onPressed: () {
                          isEdit.value = true;
                          DialogHelper.instance.showBottomSheet(
                            ImagePickerBottomSheet(
                              onPick: (filePath) =>
                                  imageFilePath.value = filePath,
                            ),
                            isScrollControlled: false,
                          );
                        },
                      )),
                ),
                const SizedBox(height: 20),
                dataItem(
                  dataController: firstName,
                  hintText: "First name",
                  textCapitalization: TextCapitalization.words,
                ),
                dataItem(
                  dataController: lastName,
                  hintText: "Last name",
                  textCapitalization: TextCapitalization.words,
                ),
                dataItem(
                  dataController: phoneNumber,
                  hintText: "Phone number",
                  textInputType: TextInputType.phone,
                ),
                Obx(() => isEdit.value
                    ? const SizedBox.shrink()
                    : Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(top: 10),
                        child: MyTextButton(
                          "Delete Contact",
                          color: colorRed,
                          onPressed: deleteUser,
                        ),
                      )),
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
    ResponseModel response;
    if (imageFilePath.isNotEmpty) {
      response = await ServiceHelper.instance
          .userService()
          .uploadImage(filePath: imageFilePath.value);
      if (response.success != true) {
        return showErrorResponse(messages: response.messages);
      }
      imageUrl.value = response.data;
    }
    final UserModel user = UserModel(
      id: userId.value,
      firstName: firstName.value,
      lastName: lastName.value,
      phoneNumber: phoneNumber.value,
      profileImageUrl: imageUrl.value.isEmpty ? null : imageUrl.value,
    );
    if (userId.value.isEmpty) {
      response = await ServiceHelper.instance.userService().createUser(user);
    } else {
      response = await ServiceHelper.instance.userService().updateUser(user);
    }
    if (response.success != true) {
      return showErrorResponse(messages: response.messages);
    }
    inProgress.value = false;
    isEdit.value = false;
    imageFilePath.value = "";
    DialogHelper.instance.showSnackbar(
      userId.value.isEmpty ? "User added!" : "Changes have been applied!",
      isSuccessful: true,
    );
    userId.value = (response.data as UserModel).id ?? "";
  }

  void deleteUser() => DialogHelper.instance.showBottomSheet(
        ActionBottomSheet(
          message: "Delete Account?",
          confirmButtonFunction: () async {
            inProgress.value = true;
            final ResponseModel response = await ServiceHelper.instance
                .userService()
                .deleteUserById(user!.id!);
            if (response.success != true) {
              return showErrorResponse(messages: response.messages);
            }
            await RouteHelper.instance.getBackAsync();
            DialogHelper.instance.showSnackbar(
              "Account deleted!",
              isSuccessful: true,
            );
          },
        ),
      );

  void showErrorResponse({required List<String> messages}) {
    inProgress.value = false;
    DialogHelper.instance.showSnackbar(
      messages.isEmpty ? defaultErrorMessage : messages.first,
      isUnsuccessful: true,
      durationSeconds: 5,
    );
  }

  Obx dataItem({
    required RxString dataController,
    required String hintText,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputType textInputType = TextInputType.name,
  }) {
    return Obx(() => isEdit.value
        ? MyTextField(
            margin: const EdgeInsets.only(bottom: 20),
            borderColor: Colors.black,
            backgroundColor: colorPage,
            hintText: hintText,
            hintColor: Colors.grey,
            textCapitalization: textCapitalization,
            textInputType: textInputType,
            initialValue: dataController.value,
            onChanged: (text) => dataController.value = text,
            readOnly: inProgress.value,
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: MyText(
                  dataController.value,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Divider(
                height: 0,
                thickness: 0.5,
                color: Colors.black,
              ),
            ],
          ));
  }
}
