class AddEmployeeModel {
  int? statusCode;
  String? status;
  String? message;
  Data? data;

  AddEmployeeModel({this.statusCode, this.status, this.message, this.data});

  AddEmployeeModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? username;
  String? fullName;
  String? email;
  var profileImage;
  int? role;
  String? employeeId;
  var status;
  var emailVerificationOtp;
  var notification;
  var emailNotification;
  var emailVerifiedAt;
  var type;
  var height;
  var dob;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.username,
        this.fullName,
        this.email,
        this.profileImage,
        this.role,
        this.employeeId,
        this.status,
        this.emailVerificationOtp,
        this.notification,
        this.emailNotification,
        this.emailVerifiedAt,
        this.type,
        this.height,
        this.dob,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    fullName = json['full_name'];
    email = json['email'];
    profileImage = json['profile_image'];
    role = json['role'];
    employeeId = json['employee_id'];
    status = json['status'];
    emailVerificationOtp = json['email_verification_otp'];
    notification = json['notification'];
    emailNotification = json['email_notification'];
    emailVerifiedAt = json['email_verified_at'];
    type = json['type'];
    height = json['height'];
    dob = json['dob'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['profile_image'] = this.profileImage;
    data['role'] = this.role;
    data['employee_id'] = this.employeeId;
    data['status'] = this.status;
    data['email_verification_otp'] = this.emailVerificationOtp;
    data['notification'] = this.notification;
    data['email_notification'] = this.emailNotification;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['type'] = this.type;
    data['height'] = this.height;
    data['dob'] = this.dob;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
