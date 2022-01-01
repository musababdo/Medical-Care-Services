class SearchDoctor {
  final String id;
  final String name;
  final String time;
  final String location;
  final String hospital;
  final String days;
  final String price;

  SearchDoctor({this.id, this.name, this.time, this.location,this.hospital,this.days,this.price});

  factory SearchDoctor.formJson(Map <String, dynamic> json){
    return new SearchDoctor(
      id: json['id'],
      name: json['name'],
      time: json['time'],
      location: json['location'],
      hospital: json['hospital'],
      days: json['days'],
      price: json['price'],
    );
  }
}
