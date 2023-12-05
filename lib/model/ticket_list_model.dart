class TicketListModel {
  int? statusCode;
  String? status;
  String? message;
  Data? data;

  TicketListModel({this.statusCode, this.status, this.message, this.data});

  TicketListModel.fromJson(Map<String, dynamic> json) {
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
  int? currentPage;
  List<TicketData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  var prevPageUrl;
  int? to;
  int? total;

  Data(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <TicketData>[];
      json['data'].forEach((v) {
        data!.add(new TicketData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class TicketData {
  int? id;
  int? userId;
  String? title;
  String? description;
  int? status;
  String? createdAt;
  String? updatedAt;
  UserInfo? userInfo;

  TicketData(
      {this.id,
        this.userId,
        this.title,
        this.description,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.userInfo});

  TicketData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userInfo = json['user_info'] != null
        ? new UserInfo.fromJson(json['user_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.userInfo != null) {
      data['user_info'] = this.userInfo!.toJson();
    }
    return data;
  }
}

class UserInfo {
  int? id;
  String? fullName;
  Null? firstName;
  Null? lastName;
  String? username;
  String? email;
  Null? phoneCode;
  Null? isoCode;
  Null? phoneNumber;
  int? employeeId;
  Null? profileImage;
  Null? dob;
  Null? gender;
  Null? address;
  Null? latitude;
  Null? longitude;
  Null? country;
  Null? city;
  Null? state;
  Null? height;
  int? notification;
  int? role;
  int? status;
  int? type;
  Null? emailVerifiedAt;
  Null? emailVerificationOtp;
  int? deviceType;
  Null? fcmToken;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;
  Null? createdBy;
  String? customStatus;
  String? customStatusTitle;

  UserInfo(
      {this.id,
        this.fullName,
        this.firstName,
        this.lastName,
        this.username,
        this.email,
        this.phoneCode,
        this.isoCode,
        this.phoneNumber,
        this.employeeId,
        this.profileImage,
        this.dob,
        this.gender,
        this.address,
        this.latitude,
        this.longitude,
        this.country,
        this.city,
        this.state,
        this.height,
        this.notification,
        this.role,
        this.status,
        this.type,
        this.emailVerifiedAt,
        this.emailVerificationOtp,
        this.deviceType,
        this.fcmToken,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.createdBy,
        this.customStatus,
        this.customStatusTitle});

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    email = json['email'];
    phoneCode = json['phone_code'];
    isoCode = json['iso_code'];
    phoneNumber = json['phone_number'];
    employeeId = json['employee_id'];
    profileImage = json['profile_image'];
    dob = json['dob'];
    gender = json['gender'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    country = json['country'];
    city = json['city'];
    state = json['state'];
    height = json['height'];
    notification = json['notification'];
    role = json['role'];
    status = json['status'];
    type = json['type'];
    emailVerifiedAt = json['email_verified_at'];
    emailVerificationOtp = json['email_verification_otp'];
    deviceType = json['device_type'];
    fcmToken = json['fcm_token'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    customStatus = json['custom_status'];
    customStatusTitle = json['custom_status_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['username'] = this.username;
    data['email'] = this.email;
    data['phone_code'] = this.phoneCode;
    data['iso_code'] = this.isoCode;
    data['phone_number'] = this.phoneNumber;
    data['employee_id'] = this.employeeId;
    data['profile_image'] = this.profileImage;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['country'] = this.country;
    data['city'] = this.city;
    data['state'] = this.state;
    data['height'] = this.height;
    data['notification'] = this.notification;
    data['role'] = this.role;
    data['status'] = this.status;
    data['type'] = this.type;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['email_verification_otp'] = this.emailVerificationOtp;
    data['device_type'] = this.deviceType;
    data['fcm_token'] = this.fcmToken;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_by'] = this.createdBy;
    data['custom_status'] = this.customStatus;
    data['custom_status_title'] = this.customStatusTitle;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}
