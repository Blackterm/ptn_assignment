class LoginToken {
  ActionLogin? actionLogin;

  LoginToken({this.actionLogin});

  LoginToken.fromJson(Map<String, dynamic> json) {
    actionLogin = json['action_login'] != null
        ? new ActionLogin.fromJson(json['action_login'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.actionLogin != null) {
      data['action_login'] = this.actionLogin!.toJson();
    }
    return data;
  }
}

class ActionLogin {
  String? token;

  ActionLogin({this.token});

  ActionLogin.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    return data;
  }
}
