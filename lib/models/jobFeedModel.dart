// To parse this JSON data, do
//
//     final jobFeed = jobFeedFromMap(jsonString);

import 'dart:convert';

JobFeed jobFeedFromMap(String str) => JobFeed.fromMap(json.decode(str));

String jobFeedToMap(JobFeed data) => json.encode(data.toMap());

class JobFeed {
    String? id;
    String? name;
    String? jobTitle;
    String? description;
    String? responsibilities;
    String? positionType;
    int? opened;
    String? country;
    String? state;
    String? image;
    DateTime? updatedAt;

    JobFeed({
       this.id,
       this.name,
       this.jobTitle,
       this.description,
       this.responsibilities,
       this.positionType,
       this.opened,
       this.country,
       this.state,
       this.image,
       this.updatedAt,
    });

    factory JobFeed.fromMap(Map<String, dynamic> json) => JobFeed(
        id: json["_id"],
        name: json["name"],
        jobTitle: json["job_title"],
        description: json["description"],
        responsibilities: json["responsibilities"],
        positionType: json["position_type"],
        opened: json["opened"],
        country: json["country"],
        state: json["state"],
        image: json["image"],
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "job_title": jobTitle,
        "description": description,
        "responsibilities": responsibilities,
        "position_type": positionType,
        "opened": opened,
        "country": country,
        "state": state,
        "image": image,
        "updatedAt": updatedAt!.toIso8601String(),
    };
}
