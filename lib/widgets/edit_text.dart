import 'package:flutter/material.dart';

import '../configs/themes/ui_parameters.dart';
import './custom_icon_button.dart';

class EditText extends StatefulWidget {
  const EditText({
    super.key,
    required this.text,
    required this.onSave,
    required this.textStyle,
    this.padding,
  });
  final String text;
  final TextStyle textStyle;
  final Function(String) onSave;
  final EdgeInsets? padding;
  @override
  State<EditText> createState() => _EditTextState();
}

class _EditTextState extends State<EditText> {
  bool editingMode = false;
  String text = '';
  final textController = TextEditingController();

  @override
  void initState() {
    textController.text = widget.text;
    text = widget.text;
    super.initState();
  }

  void enableEdit() {
    editingMode = true;
    setState(() {});
  }

  void cancelEdit() {
    textController.text = text;
    disableEdit();
  }

  void saveEdit() {
    widget.onSave(textController.text);
    text = textController.text;
    disableEdit();
  }

  void disableEdit() {
    editingMode = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!editingMode) ...[
          Flexible(
            child: GestureDetector(
              onDoubleTap: enableEdit,
              child: Text(
                text,
                style: widget.textStyle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          CustomIconButton(
            icon: Icons.edit,
            onTap: enableEdit,
            message: 'Edit text',
          ),
        ],
        if (editingMode) ...[
          Expanded(
            child: Container(
              padding: widget.padding,
              child: TextField(
                controller: textController,
                style: widget.textStyle,
                onSubmitted: (val) => saveEdit(),
                decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: defaultPadding)),
              ),
            ),
          ),
          CustomIconButton(
            icon: Icons.save,
            onTap: saveEdit,
            message: 'save',
          ),
          CustomIconButton(
            icon: Icons.cancel,
            onTap: cancelEdit,
            message: 'cancel',
          ),
        ],
      ],
    );
  }
}
