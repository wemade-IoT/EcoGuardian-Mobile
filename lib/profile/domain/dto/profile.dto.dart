class ProfileDto {
  int? id;
  String? name;
  String? userName;
  String? email;
  String? address;
  String? avatarUrl;
  int? userId;
  int? subscriptionId;

  ProfileDto(
      {this.id,
        this.name,
        this.userName,
        this.email,
        this.address,
        this.avatarUrl,
        this.userId,
        this.subscriptionId});

  ProfileDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userName = json['userName'];
    email = json['email'];
    address = json['address'];
    avatarUrl = json['avatarUrl'];
    userId = json['userId'];
    subscriptionId = json['subscriptionId'];
  }
}