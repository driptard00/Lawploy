// To parse this JSON data, do
//
//     final corporation = corporationFromMap(jsonString);

import 'dart:convert';

Corporation corporationFromMap(String str) => Corporation.fromMap(json.decode(str));

String corporationToMap(Corporation data) => json.encode(data.toMap());

class Corporation {
  String? id;
  String? auth;
    String? type;
    String? name;
    String? email;
    String? phoneNumber;
    String? phoneNumberCountryCode;
    String? area;
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

    Corporation({
      this.id,
      this.auth,
       this.type,
       this.name,
       this.email,
       this.phoneNumber,
       this.phoneNumberCountryCode,
       this.area,
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

    factory Corporation.fromMap(Map<String, dynamic> json) => Corporation(
        id: json["_id"],
        auth: json["_auth"],
        type: json["_type"],
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        phoneNumberCountryCode: json["phone_number_country_code"],
        area: json["area"],
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
        "name": name,
        "email": email,
        "phone_number": phoneNumber,
        "phone_number_country_code": phoneNumberCountryCode,
        "area": area,
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
