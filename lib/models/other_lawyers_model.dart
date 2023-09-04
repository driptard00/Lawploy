// To parse this JSON data, do
//
//     final otherLawyer = otherLawyerFromJson(jsonString);

import 'dart:convert';

OtherLawyer otherLawyerFromMap(String str) => OtherLawyer.fromMap(json.decode(str));

String otherLawyerToMap(OtherLawyer data) => json.encode(data.toMap());

class OtherLawyer {
    String? id;
    String? auth;
    String? type;
    bool? accountVerify;
    bool? accountSetupCompleted;
    String? firstName;
    String? lastName;
    String? middleName;
    String? email;
    String? phoneNumber;
    String? phoneNumberCountryCode;
    String? bio;
    int? briefMinAmount;
    String? briefMinCurrency;
    String? area;
    int? yearOfCall;
    String? country;
    String? state;
    String? lga;
    dynamic profileImage;
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
    DateTime? lastLogin;
    bool? verify;

    OtherLawyer({
       this.id,
       this.auth,
       this.type,
       this.accountVerify,
       this.accountSetupCompleted,
       this.firstName,
       this.lastName,
       this.middleName,
       this.email,
       this.phoneNumber,
       this.phoneNumberCountryCode,
       this.bio,
       this.briefMinAmount,
       this.briefMinCurrency,
       this.area,
       this.yearOfCall,
       this.country,
       this.state,
       this.lga,
        this.profileImage,
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
       this.lastLogin,
       this.verify,
    });

    factory OtherLawyer.fromMap(Map<String, dynamic> json) => OtherLawyer(
        id: json["_id"],
        auth: json["_auth"],
        type: json["_type"],
        accountVerify: json["account_verify"],
        accountSetupCompleted: json["account_setup_completed"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        middleName: json["middle_name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        phoneNumberCountryCode: json["phone_number_country_code"],
        bio: json["bio"],
        briefMinAmount: json["brief_min_amount"],
        briefMinCurrency: json["brief_min_Currency"],
        area: json["area"],
        yearOfCall: json["year_of_call"],
        country: json["country"],
        state: json["state"],
        lga: json["LGA"],
        profileImage: json["profile_image"],
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
        // lastLogin: DateTime.parse(json["lastLogin"]),
        verify: json["verify"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "_auth": auth,
        "_type": type,
        "account_verify": accountVerify,
        "account_setup_completed": accountSetupCompleted,
        "first_name": firstName,
        "last_name": lastName,
        "middle_name": middleName,
        "email": email,
        "phone_number": phoneNumber,
        "phone_number_country_code": phoneNumberCountryCode,
        "bio": bio,
        "brief_min_amount": briefMinAmount,
        "brief_min_Currency": briefMinCurrency,
        "area": area,
        "year_of_call": yearOfCall,
        "country": country,
        "state": state,
        "LGA": lga,
        "profile_image": profileImage,
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
        "lastLogin": lastLogin!.toIso8601String(),
        "verify": verify,
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
