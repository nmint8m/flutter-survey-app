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
  List<TextEditingController> _controllers = [];
  final Map<String, String> answers = <String, String>{};

  @override
  void initState() {
    super.initState();
    _buildControllers();
  }

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

  void _buildControllers() {
    _controllers = List<TextEditingController>.generate(
      widget.uiModels.length,
      (index) => TextEditingController(),
    );

    int index = 0;
    for (final uiModel in widget.uiModels) {
      final controller = _controllers[index];
      index++;
      controller.addListener(
        () {
          answers[uiModel.id] = controller.text;
          widget.onChange(answers);
        },
      );
    }
  }

  Widget _buildForm() {
    int index = 0;
    return ListView(
      children: widget.uiModels.map(
        (uiModel) {
          final controller = _controllers[index];
          index++;
          answers[uiModel.id] = '';
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
