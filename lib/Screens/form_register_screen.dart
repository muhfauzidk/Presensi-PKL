// @dart=2.9

import 'package:presensi/Model/user_model.dart';
import 'package:presensi/Screens/login_screen.dart';
import 'package:presensi/extensions/date_time_extension.dart';
import 'package:presensi/common/common.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class FormRegister extends StatefulWidget {
  static String routeName = "/formregist";
  const FormRegister({key}) : super(key: key);

  @override
  State<FormRegister> createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {
    final _auth = FirebaseAuth.instance;
    var selectedDate = DateTime.now();
    User user = FirebaseAuth.instance.currentUser;
    UserModel loggedInUser = UserModel();

    @override
    void initState() {
      super.initState();
      FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get()
        .then((value) {
          this.loggedInUser = UserModel.fromMap(value.data());
          setState(() {});
        });
      
    }
    // string for displaying the error Message
    String errorMessage;

    // our form key
    final _formKey = GlobalKey<FormState>();

    // editing Controller
    final nameEditingController = TextEditingController();
    final noTelpEditingController = TextEditingController();
    final nikEditingController = TextEditingController();
    final kategoriEditingController = TextEditingController();
    final jurusanEditingController = TextEditingController();
    final asalInstansiEditingController = TextEditingController();
    final alamatMagangEditingController = TextEditingController();
    final statusMagangEditingController = TextEditingController();
    final mulaiMagangEditingController = TextEditingController();
    final akhirMagangEditingController = TextEditingController();

    @override
    Widget build(BuildContext context) {
      //first name field
      final nameField = TextFormField(
          inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
          ],
          autofocus: false,
          controller: nameEditingController,
          keyboardType: TextInputType.name,
          validator: (value) {
            RegExp regex = RegExp(r'^.{3,}$');
            if (value.isEmpty) {
              return ("Nama tidak boleh kosong");
            }
            if (!regex.hasMatch(value)) {
              return ("Masukkan nama yang valid(Min. 3 Character)");
            }
            return null;
          },
          onSaved: (value) {
            nameEditingController.text = value;
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Nama Lengkap",
            labelText: "Nama Lengkap",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ));

      //noTelp field
      final noTelpField = TextFormField(
          inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp("[0-9]")),
          ],
          autofocus: false,
          controller: noTelpEditingController,
          validator: (value) {
            if (value.isEmpty) {
              return ("Masukkan No Telp");
            }
            return null;
          },
          onSaved: (value) {
            nameEditingController.text = value;
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "No Telp",
            labelText: "No Telp",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ));

      //nik field
      final nikField = TextFormField(
          autofocus: false,
          controller: nikEditingController,
          validator: (value) {
            RegExp regex = RegExp(r'^.{6,}$');
            if (value.isEmpty) {
              return ("Masukkan NPM/NIK");
            }
            if (!regex.hasMatch(value)) {
              return ("Masukkan NPM/NIK yang valid(Min. 6 Character)");
            }
          },
          onSaved: (value) {
            nikEditingController.text = value;
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "NPM/NIK",
            labelText: "NPM/NIK",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ));

      //confirm kategori field
      String selectedValue = null;
      
      final kategoriField = DropdownButtonFormField(
          hint: const Text("Kategori"),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 12.5,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            validator: (value) {
              if (value == null) {
                return ("Pilih Kategori");
              }
              return null;
            },
            value: selectedValue,
            onChanged: (String newValue) {
              setState(() {
                selectedValue = newValue;
                kategoriEditingController.text = selectedValue;
              });
            },
            items: const [
              DropdownMenuItem<String>(child: Text("Siswa"),value: "Siswa"),
              DropdownMenuItem<String>(child: Text("Mahasiswa"),value: "Mahasiswa"),
            ]
      );

      //jurusan field
      final jurusanField = TextFormField(
          autofocus: false,
          controller: jurusanEditingController,
          validator: (value) {
            if (value.isEmpty) {
              return ("Masukkan Jurusan");
            }
            return null;
          },
          onSaved: (value) {
            jurusanEditingController.text = value;
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Jurusan",
            labelText: "Jurusan",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ));

        //asalInstansi field
        final asalInstansiField = TextFormField(
            autofocus: false,
            controller: asalInstansiEditingController,
            validator: (value) {
              if (value.isEmpty) {
                return ("Masukkan Asal Instansi");
              }
              return null;
            },
            onSaved: (value) {
              asalInstansiEditingController.text = value;
            },
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
              hintText: "Asal Instansi",
              labelText: "Asal Instansi",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ));

        //alamatMagang field
        final alamatMagangField = TextFormField(
            autofocus: false,
            controller: alamatMagangEditingController,
            validator: (value) {
              if (value.isEmpty) {
                return ("Masukkan Alamat Magang");
              }
              return null;
            },
            onSaved: (value) {
              alamatMagangEditingController.text = value;
            },
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
              hintText: "Alamat Magang",
              labelText: "Alamat Magang",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ));

        //statusMagang field
        final statusMagangField = TextFormField(
            autofocus: false,
            controller: statusMagangEditingController,
            validator: (value) {
              if (value.isEmpty) {
                return ("Masukkan Status Magang");
              }
              return null;
            },
            onSaved: (value) {
              statusMagangEditingController.text = value;
            },
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
              hintText: "Status Magang",
              labelText: "Status Magang",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ));

        final mulaiMagangField = TextFormField(
            readOnly: true,
            controller: mulaiMagangEditingController,
            decoration: InputDecoration(
              hintText: 'Pilih tanggal mulai',
              contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              suffixIcon: const Icon(
                  Icons.calendar_month_rounded,
                  color: darkColor,
              )
            ),
            onTap: () async {
              await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2015),
              lastDate: DateTime(2025),
            ).then((selectedDate) {
              if (selectedDate != null) {
                mulaiMagangEditingController.text = "${selectedDate.dayName}, ${DateFormat('dd/MM/yy')
              .format(selectedDate)}";
              }
            });
            },
              validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Pilih tanggal mulai';
              }
                return null;
              },
          );

        final akhirMagangField = TextFormField(
            readOnly: true,
            controller: akhirMagangEditingController,
            decoration: InputDecoration(
              hintText: 'Pilih tanggal akhir',
              contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              suffixIcon: const Icon(
                  Icons.calendar_month_rounded,
                  color: darkColor,
              )
            ),
            onTap: () async {
              await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2015),
              lastDate: DateTime(2025),
            ).then((selectedDate) {
              if (selectedDate != null) {
                akhirMagangEditingController.text = "${selectedDate.dayName}, ${DateFormat('dd/MM/yy')
              .format(selectedDate)}";
              }
            });
            },
              validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Pilih tanggal akhir';
              }
                return null;
              },
          );

      //signup button
      final signUpButton = Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(30),
        color: Colors.green,
        child: MaterialButton(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            minWidth: MediaQuery.of(context).size.width,
            onPressed: () {
              regist();
            },
            child: const Text(
              "Daftar",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
            )),
      );

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        "Lengkapi Data",
                        style: TextStyle(
                          fontSize: 34.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 44),
                      nameField,
                      const SizedBox(height: 20),
                      kategoriField,
                      const SizedBox(height: 20),
                      jurusanField,
                      const SizedBox(height: 20),
                      asalInstansiField,
                      const SizedBox(height: 20),
                      noTelpField,
                      const SizedBox(height: 20),
                      nikField,
                      const SizedBox(height: 20),
                      alamatMagangField,
                      const SizedBox(height: 20),
                      statusMagangField,
                      const SizedBox(height: 20),
                      mulaiMagangField,
                      const SizedBox(height: 20),
                      akhirMagangField,
                      const SizedBox(height: 44),
                      signUpButton,
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
  }
  
  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user.email;
    userModel.uid = user.uid;
    userModel.name = nameEditingController.text;
    userModel.noTelp = noTelpEditingController.text;
    userModel.nik = nikEditingController.text;
    userModel.kategori = kategoriEditingController.text;
    userModel.jurusan = jurusanEditingController.text;
    userModel.asalInstansi = asalInstansiEditingController.text;
    userModel.alamatMagang = alamatMagangEditingController.text;
    userModel.statusMagang = statusMagangEditingController.text;
    userModel.mulaiMagang = mulaiMagangEditingController.text;
    userModel.akhirMagang = akhirMagangEditingController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Akun berhasil dibuat");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false);
  }

  void regist() async {
    if (_formKey.currentState.validate()) {
        postDetailsToFirestore();
     }
    }
  }