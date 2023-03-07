import 'package:flutter/material.dart';
import 'package:kayla_flutter_ic/utils/border_radiuses.dart';
import 'package:kayla_flutter_ic/views/question/answers_container_ui_model.dart';

class FormWithTextFieldView extends StatefulWidget {
  final List<OptionUiModel> uiModels;
  final Function(Map<String, String>) onChange;

  const FormWithTextFieldView({
    super.key,
    required this.uiModels,
    required this.onChange,
  });

  @override
  State<FormWithTextFieldView> createState() => _FormWithTextFieldViewState();
}

class _FormWithTextFieldViewState extends State<FormWithTextFieldView> {
  final List<TextEditingController> _controllers = [];
  final Map<String, String> answers = <String, String>{};

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildForm();
  }

  Widget _buildForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.uiModels.map(
        (uiModel) {
          final controller = TextEditingController();
          answers[uiModel.id] = '';
          controller.addListener(
            () {
              answers[uiModel.id] = controller.text;
              widget.onChange(answers);
            },
          );
          _controllers.add(controller);
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: TextFormField(
              keyboardType: TextInputType.text,
              decoration: _inputDecoration(
                hintText: uiModel.title,
              ),
              controller: controller,
            ),
          );
        },
      ).toList(),
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
