import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kayla_flutter_ic/model/enum/display_type.dart';
import 'package:kayla_flutter_ic/model/question.dart';
import 'package:kayla_flutter_ic/views/survey_detail/survey_detail_ui_model.dart';

part 'survey_detail.g.dart';

@JsonSerializable()
class SurveyDetail {
  final String id;
  final String title;
  final String description;
  final String coverImageUrl;
  final List<Question> questions;

  SurveyDetail({
    required this.id,
    required this.title,
    required this.description,
    required this.coverImageUrl,
    required this.questions,
  });

  SurveyDetail.empty()
      : this(
          id: '',
          title: '',
          description: '',
          coverImageUrl: '',
          questions: [],
        );

  Map<String, dynamic> toJson() => _$SurveyDetailToJson(this);

  factory SurveyDetail.fromJson(Map<String, dynamic> json) =>
      _$SurveyDetailFromJson(json);

  SurveyDetailUiModel toSurveyDetailUiModel() {
    final introSection = questions
        .firstWhere((question) => question.displayType == DisplayType.intro);
    final description =
        introSection.text.isEmpty ? this.description : introSection.text;
    String imageUrl = introSection.imageUrl.isEmpty
        ? introSection.coverImageUrl
        : introSection.imageUrl;
    imageUrl = imageUrl.isEmpty ? coverImageUrl : imageUrl;
    return SurveyDetailUiModel(
      title: title,
      description: description,
      imageUrl: imageUrl,
    );
  }
}
