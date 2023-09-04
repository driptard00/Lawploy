// To parse this JSON data, do
//
//     final lawyer = lawyerFromMap(jsonString);

import 'dart:convert';

Lawyer lawyerFromMap(String str) => Lawyer.fromMap(json.decode(str));

String lawyerToMap(Lawyer data) => json.encode(data.toMap());

class Lawyer {
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
    String? image;
    bool? verify;

    Lawyer({
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
       this.image,
       this.verify
    });

    factory Lawyer.fromMap(Map<String, dynamic> json) => Lawyer(
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
        verify: json["verify"]
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
        "profile_image": image,
        "state": state,
        "LGA": lga,
        "ratings": ratings!.ToMap(),
        "rates": List<dynamic>.from(rates!.map((x) => x)),
        "notifcations": List<dynamic>.from(notifcations!.map((x) => x)),
        "emailNotifcations": emailNotifcations,
        "inAppNotifcations": inAppNotifcations,
        "privateMode": privateMode,
        "langauge": List<dynamic>.from(langauge!.map((x) => x)),
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
        "verify": verify
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

    Map<String, dynamic> ToMap() => {
        "rate": rate,
        "vote": vote,
    };
}
