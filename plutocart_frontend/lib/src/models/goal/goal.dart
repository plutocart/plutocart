// To parse this JSON data, do
//
//     final goal = goalFromJson(jsonString);

import 'dart:convert';

Goal goalFromJson(String str) => Goal.fromJson(json.decode(str));

String goalToJson(Goal data) => json.encode(data.toJson());

class Goal {
    Status status;
    List<Datum> data;
    dynamic authentication;

    Goal({
        required this.status,
        required this.data,
        required this.authentication,
    });

    factory Goal.fromJson(Map<String, dynamic> json) => Goal(
        status: Status.fromJson(json["status"]),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        authentication: json["authentication"],
    );

    Map<String, dynamic> toJson() => {
        "status": status.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "authentication": authentication,
    };
}

class Datum {
    int id;
    String nameGoal;
    int amountGoal;
    int deficit;
    dynamic endDateGoal;
    AccountIdAccount accountIdAccount;

    Datum({
        required this.id,
        required this.nameGoal,
        required this.amountGoal,
        required this.deficit,
        required this.endDateGoal,
        required this.accountIdAccount,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        nameGoal: json["nameGoal"],
        amountGoal: json["amountGoal"],
        deficit: json["deficit"],
        endDateGoal: json["endDateGoal"],
        accountIdAccount: AccountIdAccount.fromJson(json["accountIdAccount"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nameGoal": nameGoal,
        "amountGoal": amountGoal,
        "deficit": deficit,
        "endDateGoal": endDateGoal,
        "accountIdAccount": accountIdAccount.toJson(),
    };
}

class AccountIdAccount {
    int accountId;
    String imei;
    dynamic email;
    String accountRole;

    AccountIdAccount({
        required this.accountId,
        required this.imei,
        required this.email,
        required this.accountRole,
    });

    factory AccountIdAccount.fromJson(Map<String, dynamic> json) => AccountIdAccount(
        accountId: json["accountId"],
        imei: json["imei"],
        email: json["email"],
        accountRole: json["accountRole"],
    );

    Map<String, dynamic> toJson() => {
        "accountId": accountId,
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
