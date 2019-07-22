import 'dart:convert';

import 'userhttp.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

class UserModel extends Model with NetListener{
  userHttp manager = new userHttp();
  User user;

  void login(String username,String password,String id) async{
    await _getLogin(username,password,id);
    notifyListeners();
  }
  _getLogin(String username,String password,String id) async {
    await manager.login(this, username,password,id);
  }
  @override
  void onUserResponse(User body) {
    user = body;
    print(user.username);
  }
  @override
  void onError(error) {
    // TODO: implement onError
  }
}
