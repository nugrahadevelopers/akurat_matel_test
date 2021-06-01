class UserModel {
  int uId;
  String name;
  String email;
  String noHp;
  String lokasi;
  String masaAktif;
  String tipe;
  String token;
  String renewalToken;

  UserModel({
    this.uId,
    this.name,
    this.email,
    this.noHp,
    this.lokasi,
    this.masaAktif,
    this.tipe,
    this.token,
    this.renewalToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> responseData) {
    return UserModel(
      uId: responseData['id'],
      name: responseData['name'],
      email: responseData['email'],
      noHp: responseData['nohp'],
      lokasi: responseData['lokasi'],
      masaAktif: responseData['masa_aktif'],
      tipe: responseData['tipe'],
      token: responseData['token'],
      renewalToken: responseData['renewal_token'],
    );
  }
}
