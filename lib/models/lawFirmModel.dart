// To parse this JSON data, do
//
//     final lawFirm = lawFirmFromMap(jsonString);

import 'dart:convert';

LawFirm lawFirmFromMap(String str) => LawFirm.fromMap(json.decode(str));

String lawFirmToMap(LawFirm data) => json.encode(data.toMap());

class LawFirm {
      String? id;
    String? auth;
    String? type;
    bool? accountVerify;
    bool? accountSetupCompleted;
    String? name;
    String? email;
    String? phoneNumber;
    String? phoneNumberCountryCode;
    dynamic bio;
    String? address;
    String? country;
    String? image;
    String? state;
    String? lga;
    Ratings? ratings;
    List<dynamic>? rates;
    List<dynamic>? notifcations;
    bool? emailNotifcations;
    bool? inAppNotifcations;
    bool? privateMode;
    List<dynamic>? langauge;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    LawFirm({
      this.id,
      this.auth,
       this.type,
       this.accountVerify,
       this.accountSetupCompleted,
       this.name,
       this.email,
       this.phoneNumber,
       this.phoneNumberCountryCode,
        this.bio,
       this.address,
       this.country,
       this.image,
       this.state,
       this.lga,
       this.ratings,
       this.rates,
       this.notifcations,
       this.emailNotifcations,
       this.inAppNotifcations,
       this.privateMode,
       this.langauge,
       this.createdAt,
       this.updatedAt,
       this.v,
    });

    factory LawFirm.fromMap(Map<String, dynamic> json) => LawFirm(
        id: json["_id"],
        auth: json["_auth"],
        type: json["_type"],
        accountVerify: json["account_verify"],
        accountSetupCompleted: json["account_setup_completed"],
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        phoneNumberCountryCode: json["phone_number_country_code"],
        bio: json["bio"],
        address: json["address"],
        country: json["country"],
        image: json["profile_image"],
        state: json["state"],
        lga: json["LGA"],
        ratings: Ratings.fromMap(json["ratings"]),
        rates: List<dynamic>.from(json["rates"].map((x) => x)),
        notifcations: List<dynamic>.from(json["notifcations"].map((x) => x)),
        emailNotifcations: json["emailNotifcations"],
        inAppNotifcations: json["inAppNotifcations"],
        privateMode: json["privateMode"],
        langauge: List<dynamic>.from(json["langauge"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toMap() => {
      "_id": id,
      "_auth": auth,
        "_type": type,
        "account_verify": accountVerify,
        "account_setup_completed": accountSetupCompleted,
        "name": name,
        "email": email,
        "phone_number": phoneNumber,
        "phone_number_country_code": phoneNumberCountryCode,
        "bio": bio,
        "address": address,
        "country": country,
        "profile_image": image,
        "state": state,
        "LGA": lga,
        "ratings": ratings!.toMap(),
        "rates": List<dynamic>.from(rates!.map((x) => x)),
        "notifcations": List<dynamic>.from(notifcations!.map((x) => x)),
        "emailNotifcations": emailNotifcations,
        "inAppNotifcations": inAppNotifcations,
        "privateMode": privateMode,
        "langauge": List<dynamic>.from(langauge!.map((x) => x)),
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
    };
}

class Ratings {
    int? rate;
    int? vote;

    Ratings({
       this.rate,
       this.vote,
    });

    factory Ratings.fromMap(Map<String, dynamic> json) => Ratings(
        rate: json["rate"],
        vote: json["vote"],
    );

    Map<String, dynamic> toMap() => {
        "rate": rate,
        "vote": vote,
    };
}
