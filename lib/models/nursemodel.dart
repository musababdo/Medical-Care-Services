class NurseModel {
  final String id;
  final String name;

  NurseModel(this.id, this.name);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    //data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}