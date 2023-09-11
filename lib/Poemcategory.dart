class MyData {
  final Author author;
  final Group group;

  MyData({required this.author, required this.group});

  factory MyData.fromJson(Map<String, dynamic> json) {
    return MyData(
      author: Author.fromJson(json['author']),
      group: Group.fromJson(json['group']),
    );
  }
}

class Author {
  final String name; // Assuming "S" contains the name as a String

  Author({required this.name});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      name: json['S'],
    );
  }
}

class Group {
  final String name; // Assuming "S" contains the name as a String

  Group({required this.name});

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      name: json['S'],
    );
  }
}
