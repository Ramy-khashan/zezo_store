class GoogleSignInModel {
  String? email;
  String? photoUrl;
  String? localId;
  String? displayName;
  String? idToken;

  GoogleSignInModel(
      {this.email,
      this.photoUrl,
      this.localId,
      this.displayName,
      this.idToken});

  GoogleSignInModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    photoUrl = json['photoUrl'];
    localId = json['localId'];
    displayName = json['displayName'];
    idToken = json['idToken'];
  }
 
}
