import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:SalesOnwheelss/util/theme.dart';


class CustomTextfeild extends StatelessWidget {
  final String hintText, text;
  final TextEditingController controller;
  final bool obscureText, enabled;
  final String labeltext;
  final Function onChanged;
  final TextInputType textInputType;
  final int maxLength;
  final int maxlines;
  final TextInputAction textInputAction;
  final Color textColor;
  final String error;
  final Function onEditComplete;
  final Function onTap;
  final List<TextInputFormatter> textInputFormatter;
  final TextStyle textStyle;
  final Widget prefixicon;
  final Widget suffixIcon;
  final FocusNode focusNode;
  final Function validator;
  final bool autovalidate;
  final Function onSaved;
  final bool readOnly;

  CustomTextfeild(
      {this.textInputFormatter,
      this.onTap,
      this.labeltext,
      this.controller,
      this.maxLength,
      this.onEditComplete,
      this.error,
      this.textColor,
      this.textInputAction,
      this.maxlines = 1,
      this.text,
      this.hintText,
      this.obscureText,
      this.onChanged,
      this.enabled,
      this.textInputType,
      this.textStyle,
      this.prefixicon,
      this.suffixIcon,
      this.focusNode,
      this.validator,
      this.autovalidate = false,
      this.onSaved, this.readOnly = false});

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller =
        text != null ? TextEditingController(text: text) : null;
    if (_controller != null) {
      _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length));
    }
    OutlineInputBorder outlineInputBorder = const OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.textFeildBorder, width: 2.0),
    );
    return TextFormField(
      onFieldSubmitted: onEditComplete,
      maxLines: maxlines,
      validator: validator,
      focusNode: focusNode,
      readOnly: readOnly,
      onTap: onTap,
      style: AppStyles.blackTextStyle,
      keyboardType: textInputType,
      obscureText: obscureText == null ? false : obscureText,
      maxLength: maxLength != null ? maxLength : null,
      onChanged: onChanged,
      onSaved: onSaved,
      enabled: enabled != null ? enabled : true,
      inputFormatters: textInputFormatter,
      autovalidate: autovalidate,
      controller: controller,
      
      textInputAction: textInputAction != null
          ? textInputAction
          : TextInputAction.done,
      decoration: InputDecoration(
        isDense: true,
        counterText: '',
        labelText: labeltext,
        errorText: error,
        prefixIcon: prefixicon,
        focusedBorder: new OutlineInputBorder(
          borderSide: new BorderSide(color: AppColors.textFeildBorder, width: 1),
              
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5.0),
            topRight: Radius.circular(5.0),
            bottomLeft: Radius.circular(5.0),
            bottomRight: Radius.circular(5.0),
          ),
        ),
        labelStyle: AppStyles.greyTextStyle,
        hintText: hintText,
        hintStyle: AppStyles.greyTextStyle,
        suffixIcon: suffixIcon,
        enabledBorder: new OutlineInputBorder(
          borderSide:
              new BorderSide(color: AppColors.textFeildBorder, width: 1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5.0),
            topRight: Radius.circular(5.0),
            bottomLeft: Radius.circular(5.0),
            bottomRight: Radius.circular(5.0),
          ),
        ),
        border: new OutlineInputBorder(
          borderSide:
              new BorderSide(color: AppColors.textFeildBorder, width: 1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5.0),
            topRight: Radius.circular(5.0),
            bottomLeft: Radius.circular(5.0),
            bottomRight: Radius.circular(5.0),
          ),
        ),
      ),
    );
  }
}
