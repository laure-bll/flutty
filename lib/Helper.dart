

import 'constants.dart';

getRoomReceiver(String roomId) {
  List<String> roomSplit = roomId.split("_");
  String userId = roomSplit[1] == currentUser.uid ? roomSplit[2] : roomSplit[1];
  return userId;
}