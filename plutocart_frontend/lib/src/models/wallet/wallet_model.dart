// To parse this JSON data, do
//
//     final walletById = walletByIdFromJson(jsonString);

import 'dart:convert';

Wallet walletByIdFromJson(String str) => Wallet.fromJson(json.decode(str));
List<Wallet> walletAllFromJson(String str) => List<Wallet>.from(json.decode(str).map((x) => Wallet.fromJson(x)));
String walletByIdToJson(Wallet data) => json.encode(data.toJson());

class Wallet {
    int walletId;
    String walletName;
    int statusWallet;
    double walletBalance;

    Wallet({
        required this.walletId,
        required this.walletName,
        required this.statusWallet,
        required this.walletBalance,
    });

    factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        walletId: json["walletId"],
        walletName: json["walletName"],
        statusWallet: json["statusWallet"],
        walletBalance: json["walletBalance"],
    );
    

    Map<String, String> toJson() => {
        "walletId": walletId.toString(),
        "walletName": walletName.toString(),
        "statusWallet": statusWallet.toString(),
        "walletBalance": walletBalance.toString(),
    };
}
