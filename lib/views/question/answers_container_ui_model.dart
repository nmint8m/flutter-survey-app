import 'package:equatable/equatable.dart';
import 'package:kayla_flutter_ic/model/enum/display_type.dart';

class AnswerContainerUIModel extends Equatable {
  final DisplayType displayType;
  final List<OptionUiModel> options;

  const AnswerContainerUIModel({
    required this.displayType,
    required this.options,
  });

  AnswerContainerUIModel.empty()
      : this(
          displayType: DisplayType.unknown,
          options: [],
        );

  @override
  List<Object?> get props => [
        displayType,
        options,
      ];
}

class OptionUiModel extends Equatable {
  final int index;
  final String id;
  final String title;

  const OptionUiModel({
    required this.index,
    required this.id,
    required this.title,
  });

  @override
  List<Object?> get props => [
        index,
        id,
        title,
      ];
}
