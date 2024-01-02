// To parse this JSON data, do
//
//     final transactionCategory = transactionCategoryFromJson(jsonString);

import 'dart:convert';

TransactionCategory transactionCategoryFromJson(String str) => TransactionCategory.fromJson(json.decode(str));

String transactionCategoryToJson(TransactionCategory data) => json.encode(data.toJson());

class TransactionCategory {
    Status status;
    List<Datum> data;

    TransactionCategory({
        required this.status,
        required this.data,
    });

    factory TransactionCategory.fromJson(Map<String, dynamic> json) => TransactionCategory(
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
    String nameTransactionCategory;
    TypeCategory typeCategory;
    String imageIconUrl;
    List<dynamic> transactions;

    Datum({
        required this.id,
        required this.nameTransactionCategory,
        required this.typeCategory,
        required this.imageIconUrl,
        required this.transactions,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        nameTransactionCategory: json["nameTransactionCategory"],
        typeCategory: typeCategoryValues.map[json["typeCategory"]]!,
        imageIconUrl: json["imageIconUrl"],
        transactions: List<dynamic>.from(json["transactions"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nameTransactionCategory": nameTransactionCategory,
        "typeCategory": typeCategoryValues.reverse[typeCategory],
        "imageIconUrl": imageIconUrl,
        "transactions": List<dynamic>.from(transactions.map((x) => x)),
    };
}

enum TypeCategory {
    INCOME
}

final typeCategoryValues = EnumValues({
    "income": TypeCategory.INCOME
});

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

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
