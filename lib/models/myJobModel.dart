// To parse this JSON data, do
//
//     final myJob = myJobFromMap(jsonString);

import 'dart:convert';

MyJob myJobFromMap(String str) => MyJob.fromMap(json.decode(str));

String myJobToJson(MyJob data) => json.encode(data.toMap());

class MyJob {
    String? id;
    String? name;
    String? jobTitle;
    String? description;
    String? responsibilities;
    String? positionType;
    String? creator;
    String? type;
    int? opened;
    String? website;
    String? country;
    String? state;
    String? image;
    bool? verified;
    bool? publish;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    MyJob({
       this.id,
       this.name,
       this.jobTitle,
       this.description,
       this.responsibilities,
       this.positionType,
       this.creator,
       this.type,
       this.opened,
       this.website,
       this.country,
       this.state,
       this.image,
       this.verified,
       this.publish,
       this.createdAt,
       this.updatedAt,
       this.v,
    });

    factory MyJob.fromMap(Map<String, dynamic> json) => MyJob(
        id: json["_id"],
        name: json["name"],
        jobTitle: json["job_title"],
        description: json["description"],
        responsibilities: json["responsibilities"],
        positionType: json["position_type"],
        creator: json["_creator"],
        type: json["_type"],
        opened: json["opened"],
        website: json["website"],
        country: json["country"],
        state: json["state"],
        image: json["image"],
        verified: json["verified"],
        publish: json["publish"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "job_title": jobTitle,
        "description": description,
        "responsibilities": responsibilities,
        "position_type": positionType,
        "_creator": creator,
        "_type": type,
        "opened": opened,
        "website": website,
        "country": country,
        "state": state,
        "image": image,
        "verified": verified,
        "publish": publish,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
    };
}
