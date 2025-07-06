// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analysis_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnalysisResultModel _$AnalysisResultModelFromJson(Map<String, dynamic> json) =>
    AnalysisResultModel(
      result: json['result'] as String,
      diseaseType: json['diseaseType'] as String,
      confidence: (json['confidence'] as num).toDouble(),
      aiMessage: json['aiMessage'] as String,
      sampleImageUrl: json['sampleImageUrl'] as String,
    );

Map<String, dynamic> _$AnalysisResultModelToJson(
        AnalysisResultModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'diseaseType': instance.diseaseType,
      'confidence': instance.confidence,
      'aiMessage': instance.aiMessage,
      'sampleImageUrl': instance.sampleImageUrl,
    };
