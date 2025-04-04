import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/core/di/dependency_injection.dart';
import 'package:leuko_care/core/helpers/extensions.dart';
import 'package:leuko_care/core/routes/routes.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_cubit.dart';

class DoctorDetailsScreen extends StatelessWidget {
  final DoctorModel doctor;
  final int patientsCount;



  const DoctorDetailsScreen({super.key, required this.doctor, required this.patientsCount});

  @override
  Widget build(BuildContext context) {
  final doctorCubit = context.read<DoctorCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text(doctor.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              print('============== show dialog');
              // عرض رسالة تأكيد قبل الحذف
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Confirm Delete'),
                    content: const Text(
                      'Are you sure you want to delete this doctor?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          print('============== show dialog yes');
    
                          doctorCubit.deleteDoctor(doctor.id!);
    
                          context.pop();
                          context.pop(); // العودة إلى قائمة الأطباء
                        },
                        child: const Text('Yes'),
                      ),
                      TextButton(
                        onPressed: () {
                          print('============== show dialog no');
    
                          context.pop(); // إغلاق نافذة التأكيد
                        },
                        child: const Text('No'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child:
                    doctor.profileImage.isNotEmpty
                        ? CircleAvatar(
                          child: Image.network(
                            doctor.profileImage,
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                          radius: 50,
                          backgroundColor: Colors.grey[300],
                        )
                        : CircleAvatar(
                          child: Image.network(
                            'https://static.vecteezy.com/system/resources/previews/041/408/858/non_2x/ai-generated-a-smiling-doctor-with-glasses-and-a-white-lab-coat-isolated-on-transparent-background-free-png.png',
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                          radius: 50,
                          backgroundColor: Colors.grey[300],
                        ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Name: ${doctor.name}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            Text('Email: ${doctor.email}'),
            const SizedBox(height: 10),
            Text('Phone: ${doctor.phone}'),
            const SizedBox(height: 10),
            Text('Experience: ${doctor.experience} years'),
            const SizedBox(height: 10),
            Text('Description: ${doctor.description}'),
            const SizedBox(height: 10),
            Text('Patients Count: ${patientsCount}'),
            const SizedBox(height: 30),
    
            // ✅ زر تعديل بيانات الدكتور
            Center(
              child: ElevatedButton(
                onPressed: () {
                  context.pushNamed(
                    Routes.addDoctorScreen,
                    arguments: doctor,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // لون الزر
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                ),
                child: const Text(
                  'Edit Doctor',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
