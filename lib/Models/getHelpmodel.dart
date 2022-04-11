import 'dart:convert';

GetHelpModel getHelpModelFromJson(String str) => GetHelpModel.fromJson(json.decode(str));

String getHelpModelToJson(GetHelpModel data) => json.encode(data.toJson());

class GetHelpModel {
  GetHelpModel({
    this.issueCategory,
  });

  List<IssueCategory>? issueCategory;

  factory GetHelpModel.fromJson(Map<String, dynamic> json) => GetHelpModel(
    issueCategory: List<IssueCategory>.from(json["issue_category"].map((x) => IssueCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "issue_category": List<dynamic>.from(issueCategory!.map((x) => x.toJson())),
  };
}

class IssueCategory {
  IssueCategory({
    this.id,
    this.issueCategory,
    this.status,
    this.dateCreated,
    this.list,
  });

  String? id;
  String? issueCategory;
  String? status;
  DateTime? dateCreated;
  List<ListElement>? list;

  factory IssueCategory.fromJson(Map<String, dynamic> json) => IssueCategory(
    id: json["id"],
    issueCategory: json["issue_category"],
    status: json["status"],
    dateCreated: DateTime.parse(json["date_created"]),
    list: List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "issue_category": issueCategory,
    "status": status,
    "date_created": dateCreated,
    "list": List<dynamic>.from(list!.map((x) => x.toJson())),
  };
}

class ListElement {
  ListElement({
    this.id,
    this.categoryId,
    this.issueTitle,
    this.issueDescription,
    this.issueType,
    this.status,
    this.dateCreated,
    this.issueCategory,
  });

  String? id;
  String? categoryId;
  String? issueTitle;
  String? issueDescription;
  String? issueType;
  String? status;
  DateTime? dateCreated;
  String? issueCategory;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    id: json["id"],
    categoryId: json["category_id"],
    issueTitle: json["issue_title"],
    issueDescription: json["issue_description"],
    issueType: json["issue_type"],
    status: json["status"],
    dateCreated: DateTime.parse(json["date_created"]),
    issueCategory: json["issue_category"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "issue_title": issueTitle,
    "issue_description": issueDescription,
    "issue_type": issueType,
    "status": status,
    "date_created": dateCreated,
    "issue_category": issueCategory,
  };
}
