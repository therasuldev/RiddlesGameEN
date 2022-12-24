import 'package:riddles_game_en/core/app/riddle.dart';
import 'package:riddles_game_en/core/model/user/user.dart';

class UserDB {
  final _ridd = Riddle();

  addUser(UserModel user) async {
    await _ridd.cacheService.user.put('User', user);
    return getUser();
  }

  Future<UserModel?> getUser() async {
    var user = await _ridd.cacheService.user.get('User');
    return user ?? UserModel.empty;
  }

  deleteUser() async {
    await _ridd.cacheService.user.delete('User');
  }
}
