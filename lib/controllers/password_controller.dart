import 'package:get/get.dart';

class PasswordController extends GetxController {
  final RxBool _password = false
      .obs; // na osnovu ovog .obs se omogucava da se promjena vrijednosti automatski odrazi na sve dijelova UI-a koji su povezani sa njom

  bool get password => _password
      .value; // ovim password pristupamo nasoj privatnoj promjenljivoj _password

  set setPassword(bool newState) {
    _password.value = newState;
  }
}
