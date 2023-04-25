import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kta_official/constants.dart';
import 'package:kta_official/screens/admin_screen/admin_screen.dart';

class AdmissionScreen extends StatefulWidget {
  static String routeName = "AdmissionScreen";

  const AdmissionScreen({super.key});

  @override
  _AdmissionScreenState createState() => _AdmissionScreenState();
}

class _AdmissionScreenState extends State<AdmissionScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _firstName,
      _email,
      _phone,
      _beltColor,
      _selectedBranch,
      _selectedGender,
      _age,
      _schoolName,
      _adNum,
      _whatsappNum,
      _selectedSchoolType;
  late DateTime _selectedDate, _joiningDate;

  final TextEditingController _dateController = TextEditingController();
  List<String> _branches = ['Nerul', 'Thane', 'Sewri'];
  List<String> _genders = ['Male', 'Female', 'Other'];
  List<String> _schoolTypes = ['CBSE', 'STATE', 'ICSE'];

  @override
  void initState() {
    super.initState();
    _selectedBranch = _branches[0];
    _selectedGender = _genders[0];
    _selectedSchoolType = _schoolTypes[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Taekwondo Admission Form'),
      ),
      drawer: Drawer(
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminScreen()),
                );
              },
              child: Text(
                "Admin Panel",
                style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold),
              ))),
      body: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: '''Student's Full Name'''),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _firstName = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email Address'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email address';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _email = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _phone = value!;
                  },
                ),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Whatsapp Number'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your whatsapp number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _whatsappNum = value!;
                  },
                ),
                TextFormField(
                  controller: _dateController,
                  decoration: const InputDecoration(labelText: 'Date of Birth'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your date of birth';
                    }
                    return null;
                  },
                  onTap: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _selectedDate = pickedDate;
                        _dateController.text =
                            DateFormat('dd/MM/yyyy').format(_selectedDate);
                      });
                    }
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Age'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your age';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _age = value!;
                  },
                ),
                DropdownButtonFormField(
                  value: _selectedGender,
                  items: _genders
                      .map((gender) =>
                          DropdownMenuItem(value: gender, child: Text(gender)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Gender',
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select your gender';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _selectedGender = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Belt Color'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your belt color';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _beltColor = value!;
                  },
                ),
                DropdownButtonFormField(
                  value: _selectedBranch,
                  items: _branches
                      .map((branch) =>
                          DropdownMenuItem(value: branch, child: Text(branch)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedBranch = value!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Branch',
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a branch';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _selectedBranch = value!;
                  },
                ),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'School/College Name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your school/college name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _schoolName = value!;
                  },
                ),
                DropdownButtonFormField(
                  value: _selectedSchoolType,
                  items: _schoolTypes
                      .map((schoolType) => DropdownMenuItem(
                          value: schoolType, child: Text(schoolType)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedSchoolType = value!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'School Type',
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select your school type';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _selectedSchoolType = value!;
                  },
                ),
                TextFormField(
                  controller: _dateController,
                  decoration: const InputDecoration(labelText: 'Joining Date'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your joining date';
                    }
                    return null;
                  },
                  onTap: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _joiningDate = pickedDate;
                        _dateController.text =
                            DateFormat('dd/MM/yyyy').format(_joiningDate);
                      });
                    }
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  child: const Text('Submit'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // TODO: Save the form data to a database or send it to an API
                      print('First Name: $_firstName');
                      print('Email: $_email');
                      print('Phone: $_phone');
                      print('DOB: $_selectedDate');
                      print('Age: $_age');
                      print('Belt Color: $_beltColor');
                      print('gender: $_selectedGender');
                      print('Branch: $_selectedBranch');
                      print('JoiningDate: $_joiningDate');
                      print('School Type: $_selectedSchoolType');
                      print('School Name: $_schoolName');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
