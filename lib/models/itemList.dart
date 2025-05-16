class Itemlist {
  int id;
  String name;
  Itemlist(this.id, this.name);
  // recuperer les donnes em map dynamique
  Itemlist.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"];
}
