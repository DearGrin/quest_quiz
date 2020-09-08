
class UserData{
  String name;
  String email;
  String phone;
  String city;
  bool push;

  UserData({this.name, this.email, this.phone, this.city, this.push});

  factory UserData.fromJson(Map<String, dynamic> parsedJson){
    return UserData(
      name: parsedJson['name'],
      email: parsedJson['email'],
      phone: parsedJson['phone'],
      city: parsedJson['city'],
      push: parsedJson['push']
    );
  }
}

class UserLogIn{
  String login;
  String password;

  UserLogIn({this.login, this.password});
}

class UserSignUp{
  UserLogIn logIn;
  UserData userData;

  UserSignUp({this.logIn, this.userData});
}