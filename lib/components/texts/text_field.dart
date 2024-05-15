import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/constants_color.dart';
import '../../controllers/controller_main.dart';
import '../buttons/button_icon.dart';
import '../container.dart';
import '../material.dart';

class MyTextField extends StatefulWidget {
  const MyTextField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.obscureText = false,
    this.textInputAction = TextInputAction.done,
    this.textCapitalization = TextCapitalization.none,
    this.textInputType = TextInputType.name,
    this.readOnly = false,
    this.minLines = 1,
    this.maxLines = 1,
    this.autofocus = false,
    this.onChanged,
    this.margin = EdgeInsets.zero,
    this.initialValue,
    this.clearIcon = Icons.cancel,
    this.prefixIcon,
    this.suffixIcon,
    this.clearIconTooltip = "Clear",
    this.unfocusOnClear = false,
    this.borderColor,
    this.backgroundColor = Colors.white,
  });

  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final bool obscureText;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final TextInputType textInputType;
  final bool readOnly;
  final int minLines;
  final int maxLines;
  final bool autofocus;
  final Function(String text)? onChanged;
  final EdgeInsetsGeometry margin;
  final String? initialValue;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final IconData clearIcon;
  final String clearIconTooltip;
  final bool unfocusOnClear;
  final Color? borderColor;
  final Color backgroundColor;

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  late final TextEditingController controller;
  final FocusNode focusNode = FocusNode();
  late final StreamSubscription keyboardVisibilitySubscription;
  final RxBool isFocused = false.obs;
  final RxBool isTyped = false.obs;

  @override
  void initState() {
    controller = widget.controller ?? TextEditingController();
    controller.text = widget.initialValue ?? "";
    if (controller.text.isNotEmpty) {
      isTyped.value = true;
    }
    keyboardVisibilitySubscription = MainController
        .instance.keyboardVisibilityController.onChange
        .listen((isVisible) {
      if (!isVisible) {
        focusNode.unfocus();
        if (controller.text.trim().isEmpty) {
          controller.clear();
          isTyped.value = false;
        }
      }
    });
    focusNode.addListener(() {
      isFocused.value = focusNode.hasFocus;
    });
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    controller.dispose();
    keyboardVisibilitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyContainer(
      margin: widget.margin,
      borderColor: widget.borderColor,
      backgroundColor: widget.backgroundColor,
      child: Row(
        children: [
          if (widget.prefixIcon != null)
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Icon(
                widget.prefixIcon,
                color: colorGrey,
              ),
            ),
          Expanded(
            child: Obx(() => Padding(
                  padding: EdgeInsets.only(
                    left: 15,
                    right:
                        widget.suffixIcon == null && !isFocused.value ? 15 : 0,
                  ),
                  child: TextField(
                    controller: controller,
                    focusNode: focusNode,
                    obscureText: widget.obscureText,
                    readOnly: widget.readOnly,
                    textInputAction: widget.textInputAction,
                    textCapitalization: widget.textCapitalization,
                    keyboardType: widget.textInputType,
                    minLines: widget.minLines,
                    maxLines: widget.maxLines,
                    autofocus: widget.autofocus,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: widget.labelText,
                      hintText: widget.hintText,
                      labelStyle: TextStyle(
                        color: isTyped.value ? colorTheme : colorGrey,
                      ),
                      hintStyle: const TextStyle(color: colorGrey),
                    ),
                    onChanged: (text) {
                      isTyped.value = text.isNotEmpty;
                      if (widget.onChanged != null) {
                        widget.onChanged!(text.trim());
                      }
                    },
                  ),
                )),
          ),
          Obx(() {
            if (widget.suffixIcon == null &&
                (!isTyped.value || !isFocused.value)) {
              return const SizedBox.shrink();
            }
            final bool showClearIconButton =
                isTyped.value && !widget.readOnly && isFocused.value;
            return MyMaterial(
              child: MyIconButton(
                icon:
                    showClearIconButton ? widget.clearIcon : widget.suffixIcon,
                color: colorGrey,
                onPressed: widget.readOnly
                    ? null
                    : showClearIconButton
                        ? () {
                            if (widget.unfocusOnClear) {
                              focusNode.unfocus();
                            }
                            controller.clear();
                            isTyped.value = false;
                            if (widget.onChanged != null) {
                              widget.onChanged!("");
                            }
                          }
                        : isFocused.value
                            ? () => focusNode.unfocus()
                            : () => focusNode.requestFocus(),
                tooltip: showClearIconButton ? widget.clearIconTooltip : null,
              ),
            );
          }),
        ],
      ),
    );
  }
}
