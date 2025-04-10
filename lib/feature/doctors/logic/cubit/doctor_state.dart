import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';

part 'doctor_state.freezed.dart';

@freezed
class DoctorState with _$DoctorState {
  // حالة مبدئية
  const factory DoctorState.doctorStateInitial() = _DoctorStateInitial;

  // حالة تحميل لجلب الأطباء
  const factory DoctorState.getDoctorStateLoading() = GetDoctorStateLoading;

  // حالة نجاح في جلب الأطباء
  const factory DoctorState.getDoctorStateSuccess(List<DoctorModel> doctors) = GetDoctorStateSuccess;

  // حالة خطأ في جلب الأطباء
  const factory DoctorState.getDoctorStateError(String message) = GetDoctorStateError;

  // حالة تحميل لإضافة دكتور
  const factory DoctorState.addDoctorStateLoading() = AddDoctorStateLoading;

  // حالة نجاح في إضافة دكتور
  const factory DoctorState.addDoctorStateSuccess() = AddDoctorStateSuccess;

  // حالة خطأ في إضافة دكتور
  const factory DoctorState.addDoctorStateError(String message) = AddDoctorStateError;

  // حالة تحميل لتحديث دكتور
  const factory DoctorState.updateDoctorStateLoading() = UpdateDoctorStateLoading;

  // حالة نجاح في تحديث دكتور
  const factory DoctorState.updateDoctorStateSuccess() = UpdateDoctorStateSuccess;

  // حالة خطأ في تحديث دكتور
  const factory DoctorState.updateDoctorStateError(String message) = UpdateDoctorStateError;

    // حالة تحميل لحذف دكتور
  const factory DoctorState.deleteDoctorStateLoading() = DeleteDoctorStateLoading;

  // حالة نجاح في حذف دكتور
  const factory DoctorState.deleteDoctorStateSuccess() = DeleteDoctorStateSuccess;

  // حالة خطأ في حذف دكتور
  const factory DoctorState.deleteDoctorStateError(String message) = DeleteDoctorStateError;

}
