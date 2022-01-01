class DayDoctor{

  String name;

  DayDoctor(this.name);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    //data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }

  DayDoctor.fromJson(Map<String, dynamic> json) {
    //this.id       = json['id'];
    this.name     = json['name'];
  }
}