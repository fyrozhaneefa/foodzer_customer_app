class PlaceSearch {
  String? description;
  String? place_id;
PlaceSearch({this.description,this.place_id});

factory PlaceSearch.fromJson(Map<String, dynamic> json) {
  return PlaceSearch(
    description: json['description'],
      place_id: json['place_id']
  );
}
}