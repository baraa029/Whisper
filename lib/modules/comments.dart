class Comments {
  String id;
  String imgUser;
  String name ;
  String comment;
  String time;
  Comments({this.comment,this.name,this.imgUser,this.id,this.time});
  Comments.fromMap(Map map) {
    this.imgUser = map['imgUser'];
    this.name = map['name'];
    this.comment = map ['comment'];
    this.id = map ['id'];
    this.time =  map ['time'];
  }
  toMap() {
    return {
      'id': this.id,
      'imgUser': this.imgUser,
      'name': this.name,
      'comment': this.comment,
      'time' : this.time,
    };
  }
}