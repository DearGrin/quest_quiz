import 'package:quest_quiz/API/repository.dart';
import 'package:rxdart/rxdart.dart';


class RegistrationBloc{
  bool isPushEnabled;
  final _api = Repository();

  Future<String> signIn(String email, String password) async {
    String callback = await _api.signIn(email, password);
    return callback;
  }

  Future<String> registrationWithEmailAndPassword(String email, String password, String name, String phone, String city) async {
    String callback = await _api.registrationWithEmailAndPassword(email, password);
    if(callback.startsWith('uid'))
      {
        String userId = callback.substring(4);
        _api.setUserData(name, email, phone, city, userId);
        return "Success!";
      }
    else
      {
        return callback;
      }
  }

  Future<void> editUserData(String name, String email, String phone, String city) async{
    String userId = await _api.getUserId();
    _api.setUserData(name, email, phone, city, userId);
  }

  Future<bool> checkPush() async{
    isPushEnabled = await _api.checkPushPermission();
    return isPushEnabled;
  }

  Future<void> pushChange(bool value) async{
    if(value)
    {
      bool push = await _api.checkPushPermission();
      if(!push)
        {
          await _api.askPushPermission();
        }
    }
    isPushEnabled = value;
    String userId = await _api.getUserId();
    _api.changePush(userId, value);
  }

  void dispose()
  {

  }
}
final RegistrationBloc registrationBloc = RegistrationBloc();