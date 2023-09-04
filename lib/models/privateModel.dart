// To parse this JSON data, do
//
//     final privateIndividual = privateIndividualFromJson(jsonString);

import 'dart:convert';

PrivateIndividual privateIndividualFromJson(String str) => PrivateIndividual.fromJson(json.decode(str));

String privateIndividualToJson(PrivateIndividual data) => json.encode(data.toJson());

class PrivateIndividual {
    String? type;
    bool? accountVerify;
    bool? accountSetupCompleted;
    String? firstName;
    String? lastName;
    String? middleName;
    String? email;
    String? phoneNumber;
    String? phoneNumberCountryCode;
    Ratings? ratings;
    List<dynamic>? rates;
    List<dynamic>? notifcations;
    bool? emailNotifcations;
    bool? inAppNotifcations;
    List<dynamic>? langauge;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    String? image;

    PrivateIndividual({
       this.type,
       this.accountVerify,
       this.accountSetupCompleted,
       this.firstName,
       this.lastName,
       this.middleName,
       this.email,
       this.phoneNumber,
       this.phoneNumberCountryCode,
       this.ratings,
       this.rates,
       this.notifcations,
       this.emailNotifcations,
       this.inAppNotifcations,
       this.langauge,
       this.createdAt,
       this.updatedAt,
       this.v,
       this.image,
    });

    factory PrivateIndividual.fromJson(Map<String, dynamic> json) => PrivateIndividual(
        type: json["_type"],
        accountVerify: json["account_verify"],
        accountSetupCompleted: json["account_setup_completed"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        middleName: json["middle_name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        phoneNumberCountryCode: json["phone_number_country_code"],
        ratings: Ratings.fromJson(json["ratings"]),
        rates: List<dynamic>.from(json["rates"].map((x) => x)),
        notifcations: List<dynamic>.from(json["notifcations"].map((x) => x)),
        emailNotifcations: json["emailNotifcations"],
        inAppNotifcations: json["inAppNotifcations"],
        langauge: List<dynamic>.from(json["langauge"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        image: json["profile_image"],
    );

    Map<String, dynamic> toJson() => {
        "_type": type,
        "account_verify": accountVerify,
        "account_setup_completed": accountSetupCompleted,
        "first_name": firstName,
        "last_name": lastName,
        "middle_name": middleName,
        "email": email,
        "phone_number": phoneNumber,
        "phone_number_country_code": phoneNumberCountryCode,
        "ratings": ratings!.toJson(),
        "rates": List<dynamic>.from(rates!.map((x) => x)),
        "notifcations": List<dynamic>.from(notifcations!.map((x) => x)),
        "emailNotifcations": emailNotifcations,
        "inAppNotifcations": inAppNotifcations,
        "langauge": List<dynamic>.from(langauge!.map((x) => x)),
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
        "profile_image": image,
    };
}

class Ratings {
    int? rate;
    int? vote;

    Ratings({
       this.rate,
       this.vote,
    });

    factory Ratings.fromJson(Map<String, dynamic> json) => Ratings(
        rate: json["rate"],
        vote: json["vote"],
    );

    Map<String, dynamic> toJson() => {
        "rate": rate,
        "vote": vote,
    };
}
