import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../views/widgets/dashboard_leave_apply.dart';
import '../views/widgets/custom_app_bar.dart';

class LeaveApplyScreen extends StatefulWidget {
  const LeaveApplyScreen({Key? key}) : super(key: key);

  @override
  State<LeaveApplyScreen> createState() => _LeaveApplyScreenState();
}

class _LeaveApplyScreenState extends State<LeaveApplyScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _fromDate;
  DateTime? _toDate;
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  String? _selectedLeaveType;
  int _selectedTab = 1; // 0: Dashboard, 1: Request Leave
  String _errorMessage = '';
  XFile? _selectedImage;

  // Validation methods
  String? _validateFromDate(String? value) {
    if (_fromDate == null) {
      return 'Please select a from date';
    }
    if (_fromDate!.isBefore(DateTime.now().subtract(Duration(days: 1)))) {
      return 'From date cannot be in the past';
    }
    return null;
  }

  String? _validateToDate(String? value) {
    if (_toDate == null) {
      return 'Please select a to date';
    }
    if (_fromDate != null && _toDate!.isBefore(_fromDate!)) {
      return 'To date cannot be before from date';
    }
    return null;
  }

  String? _validateLeaveType(String? value) {
    if (_selectedLeaveType == null || _selectedLeaveType!.isEmpty) {
      return 'Please select a leave type';
    }
    return null;
  }

  String? _validateReason(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a reason for leave';
    }
    if (value.trim().length < 10) {
      return 'Reason must be at least 10 characters long';
    }
    return null;
  }

  Future<void> _submitLeaveRequest() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _errorMessage = '';
      });
      
      // Show success popup
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 28,
                ),
                SizedBox(width: 10),
                Text(
                  'Success!',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            content: Text(
              'Leave request submitted successfully!',
              style: TextStyle(fontSize: 16),
            ),
          );
        },
      );
      
      // Auto close popup after 2 seconds
      Future.delayed(Duration(seconds: 2), () {
        Navigator.of(context).pop(); // Close dialog
        // Reset form
        setState(() {
          _fromDate = null;
          _toDate = null;
          _selectedLeaveType = null;
          _reasonController.clear();
          _selectedImage = null;
        });
      });
    }
  }

  Future<void> _pickDate({required bool isFrom}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isFrom
          ? (_fromDate ?? DateTime.now())
          : (_toDate ?? (_fromDate ?? DateTime.now())),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isFrom) {
          _fromDate = picked;
          if (_toDate != null && _toDate!.isBefore(_fromDate!)) {
            _toDate = null;
          }
        } else {
          _toDate = picked;
        }
      });
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        showDashboardNavigation: true,
        searchController: _searchController,
        onSearchChanged: (value) {
          // TODO: Implement search/filter logic here
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row with two buttons: Dashboard and Request Leave
              Row(
                children: [
                  Expanded(
                    child: TextButton.icon(
                      icon: Icon(Icons.dashboard, size: 20, color: _selectedTab == 0 ? Colors.blue : Colors.black),
                      label: Text(
                        'Dashboard',
                        style: TextStyle(
                          color: _selectedTab == 0 ? Colors.blue : Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: Colors.transparent),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () {
                        setState(() {
                          _selectedTab = 0;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextButton.icon(
                      icon: Icon(Icons.assignment, size: 20, color: _selectedTab == 1 ? Colors.blue : Colors.black),
                      label: Text(
                        'Request Leave',
                        style: TextStyle(
                          color: _selectedTab == 1 ? Colors.blue : Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: Colors.transparent),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () {
                        setState(() {
                          _selectedTab = 1;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 23),
              // Show dashboard UI if Dashboard tab is selected
              if (_selectedTab == 0) ...[
                // Row for text and icon labels
                Row(
                  children: [
                    SizedBox(width:45),
                    Row(
                      children: [
                        Text('Total Leave Taken', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black)),
                       const SizedBox(width: 4),
                      Icon(Icons.sticky_note_2_outlined, color: Colors.blue, size: 18),

                        
                      ],
                    ),
                    const SizedBox(width: 36),
                    Row(
                      children: [
                        Text('Approval Rate', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black)),
                        const SizedBox(width: 4),
                        Icon(Icons.verified_outlined, color: Colors.blue, size: 18),
                        
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                // Row for value/subtitle cards only
                Row(
                  children: [
                    buildInfoCard('', '16 days', '29 days remaining this year'),
                    const SizedBox(width: 10),
                    buildInfoCard('', '92%', '29 days remaining this year'),
                  ],
                ),
                const SizedBox(height: 36),
                Divider(
                  color: Colors.grey[400],
                  thickness: 2,
                  height: 1,
                ),
                buildStatsCards(),
                const SizedBox(height: 36),
                Divider(
                  color: Colors.grey[400],
                  thickness: 2,
                  height: 1,
                ),
                buildLeaveOverview(),
                const SizedBox(height: 36),
                Divider(
                  color: Colors.grey[400],
                  thickness: 2,
                  height: 1,
                ),
                buildUpcomingLeave(),
              ],
              // Only show the leave apply form if Request Leave is selected
              if (_selectedTab == 1) ...[
                // Title
                Text(
                  'Apply for Leave',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.grey[700]),
                ),
                const SizedBox(height: 22),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Employee Name', style: TextStyle(color: Colors.grey[700], fontSize: 13)),
                      const SizedBox(height: 8),
                      TextFormField(
                        initialValue: 'Employee Name - auto-filled',
                        enabled: false,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person_outline, color: Colors.grey[700], size: 20),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          hintStyle: TextStyle(color: Colors.grey[700], fontSize: 13),
                          labelStyle: TextStyle(color: Colors.grey[700], fontSize: 13),
                        ),
                        style: TextStyle(color: Colors.grey[700], fontSize: 13),
                      ),
                      const SizedBox(height: 16),
                      Text('Employee ID', style: TextStyle(color: Colors.grey[700], fontSize: 13)),
                      const SizedBox(height: 8),
                      TextFormField(
                        initialValue: 'Employee ID - auto-filled',
                        enabled: false,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.badge_outlined, color: Colors.grey[700], size: 20),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          hintStyle: TextStyle(color: Colors.grey[700], fontSize: 13),
                          labelStyle: TextStyle(color: Colors.grey[700], fontSize: 13),
                        ),
                        style: TextStyle(color: Colors.grey[700], fontSize: 13),
                      ),
                      const SizedBox(height: 16),
                      // From/To Dates
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('From', style: TextStyle(color: Colors.grey[700], fontSize: 13)),
                                const SizedBox(height: 8),
                                TextFormField(
                                  controller: TextEditingController(
                                    text: _fromDate == null
                                        ? ''
                                        : "\u0000"+_fromDate!.day.toString().padLeft(2, '0')+"-"+_fromDate!.month.toString().padLeft(2, '0')+"-"+_fromDate!.year.toString()
                                  ),
                                  validator: _validateFromDate,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.calendar_today_outlined, color: Colors.grey[700], size: 20),
                                    hintText: 'From Date',
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                    hintStyle: TextStyle(color: Colors.grey[700], fontSize: 13),
                                    labelStyle: TextStyle(color: Colors.grey[700], fontSize: 13),
                                  ),
                                  style: TextStyle(color: Colors.grey[700], fontSize: 13),
                                  readOnly: true,
                                  onTap: () => _pickDate(isFrom: true),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('To', style: TextStyle(color: Colors.grey[700], fontSize: 13)),
                                const SizedBox(height: 8),
                                TextFormField(
                                  controller: TextEditingController(
                                    text: _toDate == null
                                        ? ''
                                        : "\u0000"+_toDate!.day.toString().padLeft(2, '0')+"-"+_toDate!.month.toString().padLeft(2, '0')+"-"+_toDate!.year.toString()
                                  ),
                                  validator: _validateToDate,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.calendar_today_outlined, color: Colors.grey[700], size: 20),
                                    hintText: 'To Date',
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                    hintStyle: TextStyle(color: Colors.grey[700], fontSize: 13),
                                    labelStyle: TextStyle(color: Colors.grey[700], fontSize: 13),
                                  ),
                                  style: TextStyle(color: Colors.grey[700], fontSize: 13),
                                  readOnly: true,
                                  onTap: () => _pickDate(isFrom: false),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text('Leave Type', style: TextStyle(color: Colors.grey[700], fontSize: 13)),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: _selectedLeaveType,
                        items: const [
                          DropdownMenuItem(value: 'Sick', child: Text('Sick Leave', style: TextStyle(fontSize: 13))),
                          DropdownMenuItem(value: 'Casual', child: Text('Casual Leave', style: TextStyle(fontSize: 13))),
                          DropdownMenuItem(value: 'Other', child: Text('Other', style: TextStyle(fontSize: 13))),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedLeaveType = value;
                          });
                        },
                        validator: _validateLeaveType,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.list_alt_outlined, color: Colors.grey[700], size: 20),
                          hintText: 'Choose Type',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          hintStyle: TextStyle(color: Colors.grey[700], fontSize: 13),
                          labelStyle: TextStyle(color: Colors.grey[700], fontSize: 13),
                        ),
                        style: TextStyle(color: Colors.grey[700], fontSize: 13),
                      ),
                      const SizedBox(height: 16),
                      Text('Reason', style: TextStyle(color: Colors.grey[700], fontSize: 13)),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _reasonController,
                        maxLines: 3,
                        validator: _validateReason,
                        decoration: InputDecoration(
                          hintText: 'Text area',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          hintStyle: TextStyle(color: Colors.grey[700], fontSize: 13),
                          labelStyle: TextStyle(color: Colors.grey[700], fontSize: 13),
                        ),
                        style: TextStyle(color: Colors.grey[700], fontSize: 13),
                      ),
                      const SizedBox(height: 16),
                      Text('Attachment', style: TextStyle(color: Colors.grey[700], fontSize: 13)),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: _pickImage,
                        child: AbsorbPointer(
                          child: TextFormField(
                            readOnly: true,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.attach_file),
                              hintText: 'Attachment(Optional)',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                            ),
                            controller: TextEditingController(
                              text: _selectedImage != null ? _selectedImage!.name : '',
                            ),
                            style: TextStyle(color: Colors.grey[700], fontSize: 13),
                          ),
                        ),
                      ),
                      if (_errorMessage.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text(
                            _errorMessage,
                            style: const TextStyle(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      const SizedBox(height: 44),
                      // Submit button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          onPressed: _submitLeaveRequest,
                          child: const Text(
                            'Submit',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
} 