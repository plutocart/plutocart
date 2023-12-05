import 'dart:convert';

Wallet walletByIdFromJson(String str) => Wallet.fromJson(json.decode(str));
List<Wallet> walletAllFromJson(String str) => List<Wallet>.from(json.decode(str).map((x) => Wallet.fromJson(x)));
String walletByIdToJson(Wallet data) => json.encode(data.toJson());

class Wallet {
    int walletId;
    int? accountId;
    String walletName;
    int? statusWallet;
    double walletBalance;

    Wallet({
        required this.walletId,
        this.accountId,
        required this.walletName,
         this.statusWallet,
        required this.walletBalance,
    });

    factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        walletId: json["walletId"],
        accountId: json["accountId"],
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
