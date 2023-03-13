import 'package:kayla_flutter_ic/model/enum/display_type.dart';

class AnswerContainerUIModel {
  DisplayType displayType;
  List<OptionUiModel> options;

  AnswerContainerUIModel({
    required this.displayType,
    required this.options,
  });

  AnswerContainerUIModel.empty()
      : this(
          displayType: DisplayType.unknown,
          options: [],
        );
}

class OptionUiModel {
  int index;
  String id;
  String title;

  OptionUiModel({
    required this.index,
    required this.id,
    required this.title,
  });
}
