import 'dart:math';

import 'package:flutter/material.dart';
import '../configs/themes/ui_parameters.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.onChange,
  }) : super(key: key);

  final String hintText;
  final TextEditingController controller;
  final Function() onChange;

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  bool showCancel = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        // For Showing Cancel Button or not
        value.isNotEmpty ? setShowCancel(true) : setShowCancel(false);

        // Function to Call for search on each word type
        widget.onChange();
      },
      controller: widget.controller,
      style: const TextStyle(color: Colors.black87),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        suffixIcon: cancelButton(),
        hintText: widget.hintText,
        contentPadding: const EdgeInsets.only(right: defaultPadding / 2),
      ),
    );
  }

  void setShowCancel(bool val) {
    if (showCancel != val) {
      setState(() {
        showCancel = val;
      });
    }
  }

  Widget? cancelButton() {
    return widget.controller.text.isNotEmpty
        ? GestureDetector(
            onTap: () {
              widget.controller.text = '';
              setShowCancel(false);

              widget.onChange();
            },
            child: Transform.rotate(
              angle: pi / 4,
              child: const Icon(
                Icons.add,
                color: Colors.grey,
              ),
            ),
          )
        : null;
  }
}
