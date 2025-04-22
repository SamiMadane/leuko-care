import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leuko_care/feature/doctors/data/models/doctor_model.dart';
import 'package:leuko_care/feature/doctors/logic/cubit/doctor_cubit.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/all_doctors_widgets/doctor_filter_helper.dart';
import 'package:leuko_care/core/widgets/empty_state_widget.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/all_doctors_widgets/doctor_list_view_section.dart';
import 'package:leuko_care/feature/doctors/ui/widgets/all_doctors_widgets/doctor_search_and_filter_bar.dart';

class AllDoctorsListView extends StatefulWidget {
  final List<DoctorModel> doctors;
  const AllDoctorsListView({super.key, required this.doctors});

  @override
  State<AllDoctorsListView> createState() => _AllDoctorsListViewState();
}

class _AllDoctorsListViewState extends State<AllDoctorsListView> {
  late List<DoctorModel> _filtereddoctors;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filtereddoctors = widget.doctors;
    _searchController.addListener(_filterdoctors);
  }

  void _filterdoctors() {
    final searchKeyword = _searchController.text;
    setState(() {
      _filtereddoctors = DoctorFilterHelper.filterDoctors(
        doctors: widget.doctors,
        searchKeyword: searchKeyword,
      );
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isAscending = context.watch<DoctorCubit>().isAscending;

    return widget.doctors.isEmpty
        ? EmptyStateWidget(
          icon: Icons.medical_information_outlined,
          title: 'No doctors available.',
          message: 'Please add a doctor to get started.',
        )
        : SafeArea(
          bottom: true,
          child: Column(
            children: [
              DoctorSearchAndFilterBar(
                searchController: _searchController,
                isAscending: isAscending,
                onToggleSortOrder: () {
                  context.read<DoctorCubit>().toggleSortOrder();
                },
              ),
              Expanded(child: DoctorListViewSection(doctors: _filtereddoctors)),
            ],
          ),
        );
  }
}
