
class UserModel{
  final String userId ;
  final String username;
  final String family;
  final  String email ;

  UserModel({required this.userId,required this.username,required this.family,required this.email});

  factory UserModel.fromMap(Map<String,dynamic> data){
    return UserModel(
      userId: data['userId'],
      username: data['username'],
      family: data['family'],
      email: data['email'],
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'userId': userId,
      'username': username,
      'family': family,
      'email': email,
    };
  }

  @override
  String toString() => 'User { userId: $userId, username: $username, family: $family, email: $email }';
}