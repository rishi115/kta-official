import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kta_official/constants.dart';
import 'package:kta_official/screens/admin_screen/admin_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:kta_official/screens/login_screen/login_screen.dart';
import 'package:path/path.dart' as PATH;
import 'package:bcrypt/bcrypt.dart';
import 'dart:math';

// Create a reference to the Firestore collection

class AdmissionScreen extends StatefulWidget {
  static String routeName = "AdmissionScreen";

  const AdmissionScreen({super.key});

  @override
  _AdmissionScreenState createState() => _AdmissionScreenState();
}

class _AdmissionScreenState extends State<AdmissionScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name,
      _email,
      _password,
      _phone,
      _selectedBranch,
      _selectedGender,
      _age,
      _schoolName,
      _whatsappNum,
      _selectedSchoolType;
  late int _selectedFee;
  late DateTime _selectedDate, _joiningDate;
  late File _profilePic;
  late bool img = false;
  late bool isLoading = false;

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _jDateController = TextEditingController();
  final List<String> _branches = [
    'Personal Class',
    'Fellowship School',
    'Sewri Koilwada',
    'B. P. K Sahakari School',
    'Vanita Vishram',
    'Thane Studio ( Saturday and Sunday)',
    'Runwal Batch 01',
    'Runwal Batch 02',
    'Makhija Royale, Khar',
    'Bandup',
    'Prabhadevi ( All rounder activity center)',
    'Fellowship ( Monday and Wednesday)',
    'Goregaon ( Kids Paradise)',
    'Thane Studio ( Tuesday and Thursday)',
    'Airoli ( Body Vision Fitness)',
    'Klay Prep School ( Kalina East)',
    'Radiant Minds ( Chembur)',
    'Omkar Ved ( Parel)',
    'Cassi Mehta Malbar Hil ( Monday and Wednesday)',
    'Varsha gulmohar ( Juhu)',
    'Ajmera Bhakti Park ( Wednesday and Friday )',
    'Andheri Lokhandwala',
    'Kharghar',
    "Byculla"
  ];

  final Map<String, int> _branchFees = {
    'Personal Class': 0,
    'Fellowship School': 1000,
    'Sewri Koilwada': 500,
    'B.P.K Sahakari School': 1000,
    'Vanita Vishram': 1000,
    'Thane Studio ( Saturday and Sunday)': 1000,
    'Runwal Batch 01': 700,
    'Runwal Batch 02': 700,
    'Makhija Royale, Khar': 2500,
    'Bandup': 800,
    'Prabhadevi ( All rounder activity center)': 1600,
    'Fellowship ( Monday and Wednesday)': 1000,
    'Goregaon ( Kids Paradise)': 1000,
    'Thane Studio ( Tuesday and Thursday)': 1000,
    'Airoli ( Body Vision Fitness)': 1000,
    'Klay Prep School ( Kalina East)': 2000,
    'Radiant Minds ( Chembur)': 2000,
    'Omkar Ved ( Parel)': 3000,
    'Cassi Mehta Malbar Hil ( Monday and Wednesday)': 1000,
    'Varsha gulmohar ( Juhu)': 3000,
    'Ajmera Bhakti Park ( Wednesday and Friday )': 2500,
    'Andheri Lokhandwala': 2500,
    'Kharghar': 1500,
    "Byculla ": 1000
    // Add more branches and fees as needed
  };
  final List<int> _fees = [
    0,
    1000,
    500,
    1000,
    1000,
    1000,
    700,
    700,
    2500,
    800,
    1600,
    1000,
    1000,
    1000,
    1000,
    2000,
    2000,
    3000,
    1000,
    3000,
    2500,
    2500,
    1500,
    1000
  ];

  final List<String> _genders = ['Male', 'Female', 'Other'];
  final List<String> _schoolTypes = [
    'SSC',
    'CBSE',
    'ICSE',
    'CISCE',
    'NIOS',
    'IB',
    'CIE/IGCSE'
  ];
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      // set the selected image file
      setState(() {
        _profilePic = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedBranch = _branches[0];
    _selectedGender = _genders[0];
    _selectedFee = _fees[0];
    _selectedSchoolType = _schoolTypes[0];
  }

  @override
  Widget build(BuildContext context) {
    print("${_branches.length} ${_fees.length}");
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(backgroundColor: Colors.white),
      );
    }
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
                    _name = value!;
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
                  decoration:
                      const InputDecoration(labelText: 'Create Password'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please create your password';
                    }
                    if (value.length < 6) {
                      return 'Password should have atleast 6 characterrs';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _password = value!;
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
                DropdownButtonFormField(
                  value: _selectedBranch,
                  items: _branches
                      .map((branch) => DropdownMenuItem(
                          value: branch,
                          child: Text(
                            branch,
                            style: const TextStyle(fontSize: 14),
                          )))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedBranch = value!;
                      _selectedFee = _branchFees[value]!;
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
                  controller: _jDateController,
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
                        _jDateController.text =
                            DateFormat('dd/MM/yyyy').format(_joiningDate);
                      });
                    }
                  },
                ),
                const SizedBox(height: 20),
                Text("Upload your photo"),
                Row(
                  children: [
                    TextButton(
                      onPressed: () async {
                        // pick image from gallery
                        _pickImage(ImageSource.gallery);
                        img = true;
                      },
                      child: Text('Pick image from gallery'),
                    ),
                    SingleChildScrollView(
                      child: TextButton(
                        onPressed: () {
                          // take image from camera
                          _pickImage(ImageSource.camera);
                        },
                        child: img
                            ? Text("Image selected")
                            : Text('Take image from camera'),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  child: const Text('Submit'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // TODO: Save the form data to a database or send it to an API
                      print('First Name: $_name');
                      print('Email: $_email');
                      print('Phone: $_phone');
                      print('whatsapp: $_whatsappNum');
                      print('DOB: $_selectedDate');
                      print('Age: $_age');
                      print('gender: $_selectedGender');
                      print('Branch: $_selectedBranch');
                      print('Fee: $_selectedFee');
                      print('JoiningDate: $_joiningDate');
                      print('School Type: $_selectedSchoolType');
                      print('School Name: $_schoolName');
                      print("Profile Picture : $_profilePic");
                      setState(() {
                        isLoading = true;
                      });

                      // Get a reference to the storage service
                      final FirebaseStorage storage = FirebaseStorage.instance;

                      // Get the filename without the extension
                      final String basename =
                          PATH.basenameWithoutExtension(_profilePic.path);

                      // Create a reference to the file in Firebase Storage
                      final Reference ref =
                          storage.ref().child('profilePics/$basename.jpg');

                      // Upload the file to Firebase Storage
                      final TaskSnapshot task = await ref.putFile(_profilePic);

                      // Get the download URL of the uploaded file
                      final String downloadUrl =
                          await task.ref.getDownloadURL();
                      print("downloadUrl is : $downloadUrl");

                      // Hashing passwords before sending it to the database
                      final String hashedPassword = BCrypt.hashpw(
                          _password, "\$2b\$12\$3T8eXjYmSnyVCaRzRZQI8u");

                      // Create a reference to the collection in Firestore
                      final CollectionReference usersCollection =
                          FirebaseFirestore.instance
                              .collection('RegisteredStudents');

                      // Creating a document with user name
                      final DocumentReference userDoc =
                          usersCollection.doc(_phone);

                      // Add a new document with the fields, including the download URL of the profile picture
                      userDoc
                          .set({
                            'name': _name,
                            'email': _email,
                            'password': hashedPassword,
                            'phone': _phone,
                            'whatsappNum': _whatsappNum,
                            'selectedDate': _selectedDate,
                            'age': _age,
                            'selectedGender': _selectedGender,
                            'selectedBranch': _selectedBranch,
                            'joiningDate': _joiningDate,
                            'selectedSchoolType': _selectedSchoolType,
                            'schoolName': _schoolName,
                            'profilePic': downloadUrl,
                            'fees': _selectedFee,
                            'id': DateTime.now().millisecondsSinceEpoch * 1000 +
                                Random().nextInt(1000),
                          })
                          .then((value) => {
                                print("User added"),
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                  (route) => false,
                                ),
                                setState(() {
                                  isLoading = false;
                                })
                              })
                          .catchError(
                              (error) => print("Failed to add user: $error"));
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


  // ADMINSSION FORM 
  // ATTENDENCE 
  // MONTHLY FEE PAYMENT
  // DYNAMIC 