
import 'package:flutter/material.dart';
import 'package:SalesOnwheelss/util/theme.dart';


class VerificationCodeInput extends StatefulWidget {
  final ValueChanged<String> onCompleted;
  final ValueChanged<String> onChanged;
  final TextInputType keyboardType;
  final int length;
  final double itemWidth;
  final double itemHeight;
  final double itemGap;
  final TextStyle textStyle;
  final bool autofocus;
  final bool separateMiddle;
  final bool obscure;

  VerificationCodeInput(
      {Key key,
      this.onCompleted,
      this.keyboardType = TextInputType.number,
      this.length = 4,
      this.itemWidth = 40,
      this.itemHeight = 56,
      this.textStyle = const TextStyle(fontSize: 24.0, color: Colors.black),
      this.autofocus = true,
      this.itemGap = 8,
      this.separateMiddle = false,
      this.obscure = false,
      this.onChanged,
      })
      : assert(length > 0),
        assert(itemWidth > 0),
        super(key: key);

  @override
  _VerificationCodeInputState createState() =>
      new _VerificationCodeInputState();
}

class _VerificationCodeInputState extends State<VerificationCodeInput> {
  final List<FocusNode> _listFocusNode = <FocusNode>[];
  final List<TextEditingController> _listControllerText =
      <TextEditingController>[];
  int _currentIdex = 0;

  @override
  void initState() {
    if (_listFocusNode.isEmpty) {
      for (var i = 0; i < widget.length; i++) {
        _listFocusNode.add(new FocusNode());
        _listControllerText.add(new TextEditingController());
      }
    }
    super.initState();
  }

  String _getInputVerify() {
    String verifycode = '';
    for (var i = 0; i < widget.length; i++) {
      for (var index = 0; index < _listControllerText[i].text.length; index++) {
        if (_listControllerText[i].text[index] != '') {
          verifycode += _listControllerText[i].text[index];
        }
      }
    }
    return verifycode;
  }

  Widget _buildInputItem(int index) {
    return TextField(
      keyboardType: widget.keyboardType,
      maxLines: 1,
      maxLength: 1,
      focusNode: _listFocusNode[index],
      cursorColor: AppColors.darkColor,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.darkColor),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.darkColor),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.darkColor),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        enabled: true,
        counterText: "",
        contentPadding: EdgeInsets.only(
          top: (widget.itemHeight - widget.itemWidth),
          bottom: (widget.itemHeight - widget.itemWidth),
        ),
        errorMaxLines: 1,
        fillColor: AppColors.whiteColor,
        filled: true,
      ),
      onChanged: (String value) {
        widget.onChanged(_getInputVerify());
        if (value.length > 0 && index < widget.length || index == 0 && value.isNotEmpty) {
          if (index == widget.length - 1) {
            widget.onCompleted(_getInputVerify());
            return;
          }
          if (_listControllerText[index + 1].value.text.isEmpty) {
            _listControllerText[index + 1].value = new TextEditingValue(text: "");
          }
          _next(index);

          return;
        }
        if (value.isEmpty && index >= 0) {
          if (_listControllerText[index - 1].value.text.isEmpty) {
            _listControllerText[index - 1].value = new TextEditingValue(text: "");
          }
          _prev(index);
        }
      },
      controller: _listControllerText[index],
      maxLengthEnforced: true,
      autocorrect: false,
      textAlign: TextAlign.center,
      autofocus: widget.autofocus,
      style: widget.textStyle,
      obscureText: widget.obscure,
    );
  }

  void _next(int index) {
    if (index != widget.length) {
      setState(() {
        _currentIdex = index + 1;
      });
      FocusScope.of(context).requestFocus(_listFocusNode[index + 1]);
    }
  }

  void _prev(int index) {
    if (index > 0) {
      setState(() {
        _currentIdex = index - 1;
      });
      FocusScope.of(context).requestFocus(_listFocusNode[index - 1]);
    }
  }

  List<Widget> _buildListWidget() {
    List<Widget> listWidget = List();
    for (int index = 0; index < widget.length; index++) {
      double left = index == 0 ? 0 : (widget.itemGap);
      if (index == (widget.length / 2).floor() && widget.separateMiddle) {
        left = 2 * widget.itemGap;
      }
      listWidget.add(Container(
          height: widget.itemHeight,
          width: widget.itemWidth,
          margin: EdgeInsets.only(left: left),
          child: _buildInputItem(index)));
    }
    return listWidget;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildListWidget(),
        ));
  }
}
