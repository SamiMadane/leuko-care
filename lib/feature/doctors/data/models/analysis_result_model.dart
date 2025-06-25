import 'package:json_annotation/json_annotation.dart';

part 'analysis_result_model.g.dart';

@JsonSerializable()
class AnalysisResultModel {
  final String result; // "sick" or "clear"
  final String diseaseType;
  final double confidence;
  final String aiMessage;
  final String sampleImageUrl;

  AnalysisResultModel({
    required this.result,
    required this.diseaseType,
    required this.confidence,
    required this.aiMessage,
    required this.sampleImageUrl,
  });

  factory AnalysisResultModel.fromJson(Map<String, dynamic> json) =>
      _$AnalysisResultModelFromJson(json);
  Map<String, dynamic> toJson() => _$AnalysisResultModelToJson(this);
}
