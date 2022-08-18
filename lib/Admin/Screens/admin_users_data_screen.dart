import 'package:presensi/Admin/Model/users_model.dart';
import 'package:presensi/common/common.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersDataScreen extends GetView {
  static String routeName = "/users_data";
  
  Stream<List<User>> readUsers() => FirebaseFirestore.instance
    .collection('users')
    .snapshots()
    .map((snapshot) => 
        snapshot.docs.map((doc) => User.fromJson(doc.data())).toList()
  );

  Widget buildUser(User user) => InkWell(
    // onTap: () => Get.toNamed(DetailUsersScreen.routeName),
    borderRadius: BorderRadius.circular(8),
    child: Container(
      // width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 1,
          color: primaryExtraSoft,
        ),
      ),
      padding: const EdgeInsets.only(left: 24, top: 20, right: 29, bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Nama Lengkap",
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    ('${user.name}' == 'null') ? "-" : '${user.name}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Email",
                    style: const TextStyle(fontSize: 12),
                  ),
                  Text(
                    ('${user.email}' == 'null') ? "-" : '${user.email}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Kategori",
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    ('${user.kategori}' == 'null') ? "-" : '${user.kategori}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Jurusan",
                    style: const TextStyle(fontSize: 12),
                  ),
                  Text(
                    ('${user.jurusan}' == 'null') ? "-" : '${user.jurusan}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Asal Instansi",
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    ('${user.asalInstansi}' == 'null') ? "-" : '${user.asalInstansi}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "No Telp",
                    style: const TextStyle(fontSize: 12),
                  ),
                  Text(
                    ('${user.noTelp}' == 'null') ? "-" : '${user.noTelp}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "NIK",
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    ('${user.nik}' == 'null') ? "-" : '${user.nik}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Alamat Magang",
                    style: const TextStyle(fontSize: 12),
                  ),
                  Text(
                    ('${user.alamatMagang}' == 'null') ? "-" : '${user.alamatMagang}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Status Magang",
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    ('${user.statusMagang}' == 'null') ? "-" : '${user.statusMagang}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Mulai Magang",
                    style: const TextStyle(fontSize: 12),
                  ),
                  Text(
                    ('${user.mulaiMagang}' == 'null') ? "-" : '${user.mulaiMagang}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Akhir Magang",
                    style: const TextStyle(fontSize: 12),
                  ),
                  Text(
                    ('${user.akhirMagang}' == 'null') ? "-" : '${user.akhirMagang}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                ],
              ),
              const SizedBox(width: 24),
            ],
          ),
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Data Pengguna',
          style: const TextStyle(
            color: secondary,
            fontSize: 14,
          ),
        ),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.green),
            onPressed: () {
              Get.back();
            },
          ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: StreamBuilder<List<User>>(
        stream: readUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong! ${snapshot.error}');
          } else if (snapshot.hasData) {
            final users = snapshot.data!;

            return ListView(
              children: users.map(buildUser).toList(),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }),
      ); 
  }
}
