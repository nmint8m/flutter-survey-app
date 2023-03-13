import 'package:flutter/material.dart';
import 'package:kayla_flutter_ic/utils/border_radiuses.dart';
import 'package:kayla_flutter_ic/views/question/answers_container_ui_model.dart';

class FormWithTextAreaView extends StatefulWidget {
  final OptionUiModel uiModel;
  final Function(Map<String, String>) onChange;

  const FormWithTextAreaView({
    super.key,
    required this.uiModel,
    required this.onChange,
  });

  @override
  State<FormWithTextAreaView> createState() => _FormWithTextAreaViewState();
}

class _FormWithTextAreaViewState extends State<FormWithTextAreaView> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(
      () => widget.onChange(
        {widget.uiModel.id: _controller.text},
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextFormField(
          controller: _controller,
          keyboardType: TextInputType.multiline,
          maxLines: 6,
          decoration: _inputDecoration(
            hintText: widget.uiModel.title,
          ),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration({
    required String hintText,
  }) {
    return InputDecoration(
      labelText: hintText,
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadiuses.circular12,
      ),
      fillColor: Colors.white24,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 18.0,
        horizontal: 12.0,
      ),
    );
  }
}
