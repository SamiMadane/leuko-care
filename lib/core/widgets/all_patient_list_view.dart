import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/widgets/common_search_and_filter_bar.dart';
import 'package:leuko_care/core/widgets/empty_state_widget.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';
import 'package:leuko_care/feature/patients/ui/widgets/admin_user/all_patients_widgets/patient_filter_bottom_sheet.dart';
import 'package:leuko_care/feature/patients/ui/widgets/admin_user/all_patients_widgets/patient_filter_helper.dart';
import 'package:leuko_care/core/widgets/patient_list_view_section.dart';

class AllPaitentListView extends StatefulWidget {
  final List<PatientModel> patients;
  final String doctorId;
  final String doctorName;
  final String? userType;

  const AllPaitentListView({
    super.key,
    required this.patients,
    required this.doctorId,
    required this.doctorName, this.userType,
  });

  @override
  State<AllPaitentListView> createState() => _AllPaitentListViewState();
}

class _AllPaitentListViewState extends State<AllPaitentListView> {
  late List<PatientModel> _filteredPatients;
  final TextEditingController _searchController = TextEditingController();

  String _filterBy = 'None';
  String _selectedFilterValue = 'All';

  @override
  void initState() {
    super.initState();
    _filteredPatients = widget.patients;
    _searchController.addListener(_filterPatients);
  }

  void _filterPatients() {
    final searchKeyword = _searchController.text;
    setState(() {
      _filteredPatients = PatientFilterHelper.filterPatients(
        patients: widget.patients,
        searchKeyword: searchKeyword,
        filterBy: _filterBy,
        selectedFilterValue: _selectedFilterValue,
      );
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _showFilterDialog() async {
    await showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(RadiusManager.r20),
        ),
      ),
      builder:
          (context) => PatientFilterBottomSheet(
            onFilterSelected: (filterBy, value) {
              setState(() {
                _filterBy = filterBy;
                _selectedFilterValue = value;
                _filterPatients();
              });
            },
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.patients.isEmpty
        ? EmptyStateWidget(
          icon: Icons.group_outlined,
          title: 'No patients found.',
          message: widget.userType == 'doctor' ? 'There are no patients assigned to you yet.':'There are no patients added yet. Try adding a new patient.',
        )
        : SafeArea(
          bottom: true,
          child: Column(
            children: [
              CommonSearchAndFilterBar(
                searchController: _searchController,
                onActionPressed: _showFilterDialog,
                actionIcon: Icons.filter_list,
              ),
              Expanded(
                child: PatientListViewSection(
                  patients: _filteredPatients,
                  doctorId: widget.doctorId,
                  doctorName: widget.doctorName,
                  
                ),
              ),
            ],
          ),
        );
  }
}
