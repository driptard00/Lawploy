// To parse this JSON data, do
//
//     final message = messagefromMap(jsonString);

import 'dart:convert';

Message messageFromMap(String str) => Message.fromMap(json.decode(str));

String messageFoMap(Message data) => json.encode(data.toMap());

class Message {
    String? type;
    String? body;
    bool? read;
    DateTime? lastUpdate;
    DateTime? sent;
    bool? sentByMe;

    Message({
        this.type,
        this.body,
        this.read,
        this.lastUpdate,
        this.sent,
        this.sentByMe,
    });

    factory Message.fromMap(Map<String, dynamic> json) => Message(
        type: json["type"],
        body: json["body"],
        read: json["read"],
        lastUpdate: DateTime.parse(json["lastUpdate"]),
        sent: DateTime.parse(json["sent"]),
        sentByMe: json["SentByMe"],
    );

    Map<String, dynamic> toMap() => {
        "type": type,
        "body": body,
        "read": read,
        "lastUpdate": lastUpdate!.toIso8601String(),
        "sent": sent!.toIso8601String(),
        "SentByMe": sentByMe,
    };
}
