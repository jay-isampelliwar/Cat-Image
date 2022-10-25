import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:task_one/model/cat_model.dart';

class CatProvider extends ChangeNotifier {
  bool _loading = true;
  bool get loading => _loading;
  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  CatModel? _cat;
  CatModel? get cat => _cat;
  String _message = "success";
  String get message => _message;
  void setMessage(String newMessage) {
    _message = newMessage;
  }

  bool _noException = true;
  bool get isNorError => _noException;

  static const String baseUrl = "api.thecatapi.com";
  static const String endPoint = "/v1/images/search";
  Future<void> getCatImage() async {
    setLoading(true);
    var uri = Uri.https(baseUrl, endPoint);
    try {
      http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        _cat = catModelFromJson(response.body).first;
        _noException = true;
        setMessage("success");
      } else {
        _message = "Something went wrong ${response.statusCode}";
        _noException = false;
      }
    } catch (e) {
      _message = e.toString();
      _noException = false;
    }
    setLoading(false);
  }
}
