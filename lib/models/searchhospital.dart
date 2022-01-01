class SearchHospital {
  final String id;
  final String name;
  final String image;
  final String location;
  final String time;

  SearchHospital({this.id, this.name, this.image, this.location, this.time});

  factory SearchHospital.formJson(Map <String, dynamic> json){
    return new SearchHospital(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      location: json['location'],
      time: json['time'],
    );
  }
}
