import 'dart:convert' as convert;
import 'package:http/http.dart' as http;


Future<String> storeData(String userId, String password) async{
  String dataUrl = "https://angular.tastysoftcloud.com/api/auth/signin";


  final url = Uri.parse(dataUrl);
  final header = {"Content-Type": "application/json"};
  final body = {
   "userid" : userId, 
    "password": password
  };

  final resBody = convert.jsonEncode(body);

  print(resBody);

  var response = await http.post(url, headers: header, body: resBody);

  if(response.statusCode == 200){
    var jsonRes = convert.jsonDecode(response.body) as Map<String, dynamic>;
    print(jsonRes);
    return jsonRes['token'];
  }else {
    throw ("Something went wrong ${response.statusCode}");
  }
}