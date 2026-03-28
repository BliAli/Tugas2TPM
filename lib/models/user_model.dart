class UserModel {
  String username;
  String nama;
  String nim;

  UserModel({required this.nama, required this.nim, required this.username});
}

List<UserModel> dataKelompok = [
  UserModel(nama: 'Saif Ali Addamawi', nim: '123230164', username: 'ali'),
  UserModel(nama: 'T.M. Kalladara Raja Lingga AS', nim: '123230115', username: 'raja'),
  UserModel(nama: 'Nur Aini Dwi Lestari', nim: '123230045', username: 'aini'),
];
