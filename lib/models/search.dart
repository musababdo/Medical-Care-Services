class Search {
  final String id;
  final String name;

  Search({this.id, this.name});

  factory Search.formJson(Map <String, dynamic> json){
    return new Search(
      id: json['id'],
      name: json['name'],
    );
  }
}
