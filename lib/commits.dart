import 'package:flutter/material.dart';
import 'config.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:percent_indicator/circular_percent_indicator.dart';


class Data {

List<String> commits, date;

Data(this.commits, this.date);

factory Data.getdata(List json){
    List<String> commitList = [], dateList = [];
    json.forEach((element){
      commitList.add(element['commit']['message']);
      dateList.add(element['commit']['committer']['date']);
    });
    return Data(commitList, dateList); 
 }

}

class Commits extends StatefulWidget {

  String repo_det, gitacc;

  
  Commits(this.repo_det, this.gitacc);

  @override
  _CommitsState createState() => _CommitsState(this.repo_det, this.gitacc);
}

class _CommitsState extends State<Commits> {

  String repo_det, gitacc;
  dynamic res;

  _CommitsState(this.repo_det, this.gitacc);

  Future<Data> getdata() async{
  Response resp = await get('https://api.github.com/repos/chakki1234/$repo_det/commits');
  return Data.getdata(jsonDecode(resp.body));
  }


  @override
  void initState(){
  super.initState();
  this.res = getdata();
  }

  @override
  Widget build(BuildContext context) {
    return 
    FutureBuilder( 
      future: this.res, 
      builder: (context, snapshot){

      if(snapshot.hasData){
      
      return Container(
      constraints: BoxConstraints(
      minHeight: 5.0,
      maxHeight: 360.0,
      ),
      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: ListView.builder(
      itemCount: (snapshot.data.commits.length + 1),
      itemBuilder: (context, index){
        
        if(snapshot.data.commits.length == 0)
         return  Text('No commits yet', style: TextStyle( fontSize: 20, fontFamily: config.fontFamily, color: config.fontColor));
      
        else if(index == snapshot.data.commits.length)
        return null;

        else return  Column(
           children: <Widget>[
            ListTile(
          contentPadding: EdgeInsets.all(3),
          title: Text(snapshot.data.commits[index],  style: TextStyle( fontSize: 18, fontFamily: config.fontFamily, color: config.fontColor)),
          subtitle: Text(snapshot.data.date[index],  style: TextStyle( fontSize: 18, fontFamily: config.fontFamily, color: config.fontColor)),
        ),
        Divider(
          color: config.fontColor,
        )
        ],
         );
      }
    ),
    );
   }

       else if(snapshot.hasError)
       return Text("${snapshot.error}", style: TextStyle(color: config.fontColor),); 

       else return CircularProgressIndicator();

      });
  }
}