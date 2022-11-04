class User {
  String email;
  String pass;
  String name;
  String type;
  int beginnerMark;
  int intermediateMark;
  int advancedMark;

  User({this.email, this.pass, this.name, this.type, this.beginnerMark, this.intermediateMark, this.advancedMark});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'pass': pass,
      'name': name,
      'type': type,
      'beginnerMark': beginnerMark,
      'intermediateMark': intermediateMark,
      'advancedMark': advancedMark,      
    };
  }

  User.fromMap(Map<String, dynamic> map) {
    email = map['email'];
    pass = map['pass'];
    name = map['name'];
    type = map['type'];
    beginnerMark = map['beginnerMark'];
    intermediateMark = map['intermediateMark'];
    advancedMark = map['advancedMark'];
  }

  @override
  String toString() {
    return 'User{email: $email, pass: $pass, name: $name, type: $type, beginnerMark: $beginnerMark, intermediateMark: $intermediateMark, advancedMark: $advancedMark}';
  }
}