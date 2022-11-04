class Marks {
  String email;
  int beginnerMark;
  int intermediateMark;
  int advancedMark;

  Marks({this.email, this.beginnerMark, this.intermediateMark, this.advancedMark});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'beginnerMark': beginnerMark,
      'intermediateMark': intermediateMark,
      'advancedMark': advancedMark,      
    };
  }

  Marks.fromMap(Map<String, dynamic> map) {
    email = map['email'];
    beginnerMark = map['beginnerMark'];
    intermediateMark = map['intermediateMark'];
    advancedMark = map['advancedMark'];
  }

  @override
  String toString() {
    return 'Marks{email: $email, beginnerMark: $beginnerMark, intermediateMark: $intermediateMark, advancedMark: $advancedMark}';
  }
}