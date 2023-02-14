class Character {
  late int charID;
  late String name;
  late String originName;
  late String locationName;
  late String image;
  late List<dynamic> episodes;
  late String statusIfDeadOrAlive;
  Character(this.episodes,this.statusIfDeadOrAlive,this.image,this.locationName,this.originName,this.charID,this.name);

  Character.fromJson(Map<String,dynamic>json){
    print("hiiiiiiiii");
    charID=json["id"];
    name=json["name"];
    originName=json["origin"]["name"];
    locationName=json["location"]["name"];
    image=json["image"];
    statusIfDeadOrAlive=json["status"];
    episodes=json["episode"];
    // print(episodes);


  }

}