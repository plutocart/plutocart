// To parse this JSON data, do
//
//     final transaction = transactionFromJson(jsonString);

import 'dart:convert';

Transaction transactionFromJson(String str) => Transaction.fromJson(json.decode(str));

String transactionToJson(Transaction data) => json.encode(data.toJson());

class Transaction {
    Status status;
    List<Datum> data;

    Transaction({
        required this.status,
        required this.data,
    });

    factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        status: Status.fromJson(json["status"]),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    int id;
    int stmTransaction;
    String statementType;
    DateTime dateTransaction;
    String description;
    String imageUrl;
    TranCategoryIdCategory tranCategoryIdCategory;
    dynamic debtIdDebt;
    dynamic goalIdGoal;
    WalletIdWallet walletIdWallet;

    Datum({
        required this.id,
        required this.stmTransaction,
        required this.statementType,
        required this.dateTransaction,
        required this.description,
        required this.imageUrl,
        required this.tranCategoryIdCategory,
        required this.debtIdDebt,
        required this.goalIdGoal,
        required this.walletIdWallet,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        stmTransaction: json["stmTransaction"],
        statementType: json["statementType"],
        dateTransaction: DateTime.parse(json["dateTransaction"]),
        description: json["description"],
        imageUrl: json["imageUrl"],
        tranCategoryIdCategory: TranCategoryIdCategory.fromJson(json["tranCategoryIdCategory"]),
        debtIdDebt: json["debtIdDebt"],
        goalIdGoal: json["goalIdGoal"],
        walletIdWallet: WalletIdWallet.fromJson(json["walletIdWallet"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "stmTransaction": stmTransaction,
        "statementType": statementType,
        "dateTransaction": dateTransaction.toIso8601String(),
        "description": description,
        "imageUrl": imageUrl,
        "tranCategoryIdCategory": tranCategoryIdCategory.toJson(),
        "debtIdDebt": debtIdDebt,
        "goalIdGoal": goalIdGoal,
        "walletIdWallet": walletIdWallet.toJson(),
    };
}

class TranCategoryIdCategory {
    int id;
    String nameTransactionCategory;
    String typeCategory;
    String imageIconUrl;

    TranCategoryIdCategory({
        required this.id,
        required this.nameTransactionCategory,
        required this.typeCategory,
        required this.imageIconUrl,
    });

    factory TranCategoryIdCategory.fromJson(Map<String, dynamic> json) => TranCategoryIdCategory(
        id: json["id"],
        nameTransactionCategory: json["nameTransactionCategory"],
        typeCategory: json["typeCategory"],
        imageIconUrl: json["imageIconUrl"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nameTransactionCategory": nameTransactionCategory,
        "typeCategory": typeCategory,
        "imageIconUrl": imageIconUrl,
    };
}

class WalletIdWallet {
    int walletId;
    String walletName;
    int statusWallet;
    int walletBalance;

    WalletIdWallet({
        required this.walletId,
        required this.walletName,
        required this.statusWallet,
        required this.walletBalance,
    });

    factory WalletIdWallet.fromJson(Map<String, dynamic> json) => WalletIdWallet(
        walletId: json["walletId"],
        walletName: json["walletName"],
        statusWallet: json["statusWallet"],
        walletBalance: json["walletBalance"],
    );

    Map<String, dynamic> toJson() => {
        "walletId": walletId,
        "walletName": walletName,
        "statusWallet": statusWallet,
        "walletBalance": walletBalance,
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
