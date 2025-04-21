import 'package:flutter/material.dart';
import 'package:leuko_care/core/resources/sizes_util_manager.dart';
import 'package:leuko_care/core/widgets/empty_state_widget.dart';
import 'package:leuko_care/feature/patients/data/models/patient_model.dart';
import 'package:leuko_care/feature/patients/ui/widgets/all_patients_widgets/patient_filter_bottom_sheet.dart';
import 'package:leuko_care/feature/patients/ui/widgets/all_patients_widgets/patient_filter_helper.dart';
import 'package:leuko_care/feature/patients/ui/widgets/all_patients_widgets/patient_list_tile.dart';

class AllPaitentListView extends StatefulWidget {
  final List<PatientModel> patients;
  final String doctorId;
  final String doctorName;

  const AllPaitentListView({
    super.key,
    required this.patients,
    required this.doctorId,
    required this.doctorName,
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
      borderRadius: BorderRadius.vertical(top: Radius.circular(RadiusManager.r20)),
    ),
    builder: (context) => PatientFilterBottomSheet(
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
          icon: Icons.person_outline_sharp,
          title: 'No Found patients.',
          message: 'Try add patients',
        )
        : SafeArea(
          bottom: true,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          hintText: 'Search by name or email',
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Material(
                      color: Theme.of(context).primaryColor,
                      shape: const CircleBorder(),
                      child: IconButton(
                        icon: const Icon(
                          Icons.filter_list,
                          color: Colors.white,
                        ),
                        onPressed: _showFilterDialog,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child:
                    _filteredPatients.isEmpty
                        ? const EmptyStateWidget(
                          icon: Icons.person_outline_sharp,
                          title: 'No matching patients.',
                          message: 'Try adjusting your search or filter.',
                        )
                        : ListView.builder(
                          itemCount: _filteredPatients.length,
                          itemBuilder: (context, index) {
                            final patient = _filteredPatients[index];
                            return PatientListTile(
                              patient: patient,
                              doctorId: widget.doctorId,
                              doctorName: widget.doctorName,
                            );
                          },
                        ),
              ),
            ],
          ),
        );
  }
}
