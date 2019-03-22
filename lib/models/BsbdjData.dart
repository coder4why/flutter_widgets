
import 'dart:convert';

class Meida {
  final List<MediaModel> list;

  Meida(this.list);

  Meida.fromJson(Map<String, dynamic> json)
      : list = json['list'];

  Map<String, dynamic> toJson() =>
      {
        'list': list,
      };

}

class MediaModel {
  final List<TagModel> tags;
  MediaModel(this.tags);

}


class TagModel {
  final String name;
  final String image_list;

  TagModel(this.name,this.image_list);

}