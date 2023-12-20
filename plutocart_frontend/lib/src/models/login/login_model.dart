// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
    Status status;
    Data data;

    Login({
        required this.status,
        required this.data,
    });

    factory Login.fromJson(Map<String, dynamic> json) => Login(
        status: Status.fromJson(json["status"]),
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status.toJson(),
        "data": data.toJson(),
    };
}

class Data {
    int accountId;
    String userName;
    String imei;
    dynamic email;
    String accountRole;

    Data({
        required this.accountId,
        required this.userName,
        required this.imei,
        required this.email,
        required this.accountRole,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        accountId: json["accountId"],
        userName: json["userName"],
        imei: json["imei"],
        email: json["email"],
        accountRole: json["accountRole"],
    );

    Map<String, dynamic> toJson() => {
        "accountId": accountId,
        "userName": userName,
        "imei": imei,
        "email": email,
        "accountRole": accountRole,
    };
}

class Status {
    String code;
    String message;
    dynamic remark;

    Status({
        required this.code,
        required this.message,
        required this.remark,
    });

    factory Status.fromJson(Map<String, dynamic> json) => Status(
        code: json["code"],
        message: json["message"],
        remark: json["remark"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "remark": remark,
    };
}
