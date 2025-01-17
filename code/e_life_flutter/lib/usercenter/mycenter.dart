
import 'package:e_life_flutter/userhttp.dart' as prefix0;
import 'package:flutter/material.dart';
import 'map.dart';
import 'package:scoped_model/scoped_model.dart';
import '../user.dart';
import 'package:e_life_flutter/friends/friend.dart';
import '../main.dart';
import 'package:oktoast/oktoast.dart';



class mycenter extends StatefulWidget {
  final username;
  final role;
  var session;
  mycenter(this.username,this.role,this.session);

  @override
  State<StatefulWidget> createState() {
    return new myCenterWidget(username,role,session);
  }
}
class myCenterWidget extends State<mycenter> with SingleTickerProviderStateMixin,prefix0.NetListener {

  final username1;
  final role1;
  var session1;
  myCenterWidget(this.username1,this.role1,this.session1);
  prefix0.userHttp manager = new prefix0.userHttp();

  void _toMap() {

    Navigator.push(context,
        new MaterialPageRoute(builder: (context) {
          return myMap(session1) ;
        })).then((var onValue){
    });
  }
 String username="未登录";
 String role = "用户";
  @override
  Widget build(BuildContext context) {
    return  ScopedModelDescendant<UserModel>(
        builder: (context, child, model)
    {

      username=username1;

      if(role1=="0"){
        role="用户";
      }
      if(role1=="1"){
        role="管理员";
      }
      if(role1=="2"){
        role="商家";
      }
      return Scaffold(
        appBar: AppBar(
          actions: <Widget>[

          ],
          title: Text('个人中心'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 38.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ClipOval(
                      child: Image.asset(
                        "images/app.png",
                        width: 80,
                      ),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Text(

                        username,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        role,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.fiber_new),
                  title: const Text('我的周边'),
                  onTap:  () {
                    _toMap();
                  },
                ),
                  ListTile(
                    leading: const Icon(Icons.people_outline),
                    title: const Text('我的好友'),
                    onTap: (){
                      Navigator.push(context,
                          new MaterialPageRoute(builder: (context) {
                            return new friendWidget(username,session1);
                          }));
                    }
                  ),

                ],
              ),
            ),
          ],
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          manager.logout(this,username,session1);

        },
        tooltip: '退出登录',
        child: Icon(Icons.keyboard_return),
      ),
      );
    });
  }
  @override
   onUserResponse(prefix0.User body,bool login) {

  }
  @override void onLogoutResponse(bool logout) {
    // TODO: implement onLogoutResponse
    if(logout!=false){
      Navigator.of(context).pushAndRemoveUntil(
          new MaterialPageRoute(
              builder: (context) => new MyApp()),
              (route) => route == null);

      showToast("登出成功");
    }else{
      Navigator.of(context).pushAndRemoveUntil(
          new MaterialPageRoute(
              builder: (context) => new MyApp()),
              (route) => route == null);
      showToast("登出失败");
    }
  }
  @override
  void onError(error) {
    // TODO: implement onError
  }
  @override
  void onGetNoteResponse(bool ifGetNote){

  }

  }



