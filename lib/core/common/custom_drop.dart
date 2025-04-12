import 'package:Doozy/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDropDown extends StatefulWidget {
  final List<String> list;
  final TextEditingController dropDownController;
  final Color textColor;
  final double fontSize;
  final TextStyle textStyle;
  final double dropdownWidth;
  final double dropdownHeight;
  final Color borderColor;
  final Color focusedBorderColor;
  final Color arrowColor;
  final String hintText;
  final void Function(String)? onChanged;

  const CustomDropDown({
    super.key,
    required this.list,
    required this.dropDownController,
    this.textColor = AppColors.lightorange,
    this.fontSize = 14,
    this.textStyle = const TextStyle(),
    this.dropdownWidth = 350,
    this.dropdownHeight = 50,
    this.borderColor = Colors.grey,
    this.focusedBorderColor = AppColors.orange,
    this.arrowColor = AppColors.orange,
    required this.hintText,
    this.onChanged,
  });

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  late String dropdownValue;
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.dropDownController.text.isNotEmpty
        ? widget.dropDownController.text
        : (widget.list.isNotEmpty ? widget.list.first : "Select");

    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
        if (_focusNode.hasFocus) {
          _isOpen = true;
        }
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color unfocusedColor = Colors.grey;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: widget.dropdownWidth,
      child: Builder(
        builder: (BuildContext context) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: Theme.of(context).colorScheme.copyWith(
                secondary: widget.arrowColor,
                onSurface: widget.arrowColor,
              ),
              iconTheme: IconThemeData(color: widget.arrowColor),
            ),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isOpen = true;
                  _focusNode.requestFocus();
                });
              },
              child: Focus(
                onFocusChange: (hasFocus) {
                  setState(() {
                    _isFocused = hasFocus;
                    if (!hasFocus) {
                      _isOpen = false;
                    }
                  });
                },
                child: DropdownMenu<String>(
                  controller: widget.dropDownController,
                  width: widget.dropdownWidth,
                  initialSelection: null,
                  hintText: null,
                  focusNode: _focusNode,
                  onSelected: (String? value) {
                    if (value != null) {
                      setState(() {
                        dropdownValue = value;
                        widget.dropDownController.text = value;
                        if (widget.onChanged != null) {
                          widget.onChanged!(value);
                        }
                        Future.delayed(const Duration(milliseconds: 100), () {
                          setState(() {
                            _isOpen = false;
                          });
                        });
                      });
                    }
                  },
                  dropdownMenuEntries: widget.list
                      .map<DropdownMenuEntry<String>>(
                        (String value) => DropdownMenuEntry<String>(
                          value: value,
                          label: value,
                        ),
                      )
                      .toList(),
                  textStyle: GoogleFonts.varelaRound(
                    color: widget.textColor,
                    fontSize: widget.fontSize,
                  ),
                  menuStyle: MenuStyle(
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  inputDecorationTheme: InputDecorationTheme(
                    hintStyle: GoogleFonts.varelaRound(
                      color: widget.textColor,
                      fontSize: widget.fontSize,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: (_isFocused || _isOpen)
                            ? widget.focusedBorderColor
                            : unfocusedColor,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: (_isFocused || _isOpen)
                            ? widget.focusedBorderColor
                            : unfocusedColor,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: widget.focusedBorderColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    suffixIconColor: WidgetStateColor.resolveWith(
                      (states) => widget.arrowColor,
                    ),
                    prefixIconColor: WidgetStateColor.resolveWith(
                      (states) => widget.arrowColor,
                    ),
                    iconColor: WidgetStateColor.resolveWith(
                      (states) => widget.arrowColor,
                    ),
                  ),
                  label: Text(
                    widget.dropDownController.text.isNotEmpty
                        ? widget.dropDownController.text
                        : widget.hintText,
                    style: GoogleFonts.varelaRound(
                      color: widget.textColor,
                      fontSize: widget.fontSize,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
