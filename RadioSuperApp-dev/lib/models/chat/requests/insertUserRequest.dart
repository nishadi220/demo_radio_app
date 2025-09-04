class InsertUserRequest {
  final String guestId;
  final String companyId;
  final String name;
  final String description;
  final String phone;
  final int languageId;
  final String address;
  final int townId;
  final int districtId;
  final int countryId;
  final String? email;
  final String password;
  final String picUrl;
  final int userTypeId;
  final String keyPara;

  InsertUserRequest({
    required this.guestId,
    required this.companyId,
    required this.name,
    required this.description,
    required this.phone,
    required this.languageId,
    required this.address,
    required this.townId,
    required this.districtId,
    required this.countryId,
    this.email,
    required this.password,
    required this.picUrl,
    required this.userTypeId,
    required this.keyPara,
  });

  // Convert the request object to JSON for API calls
  Map<String, dynamic> toJson() {
    return {
      "guestId": guestId,
      "companyId": companyId,
      "name": name,
      "description": description,
      "phone": phone,
      "languageId": languageId,
      "address": address,
      "townId": townId,
      "districtId": districtId,
      "countryId": countryId,
      "email": email,
      "password": password,
      "picUrl": picUrl,
      "userTypeId": userTypeId,
      "keyPara": keyPara,
    };
  }
}