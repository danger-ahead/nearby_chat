String createJsonString(String username, String message) {
  // replace all characters in message, such that they dont interfere with json decode
  message = message.replaceAll('"', '\\"');
  message = message.replaceAll("'", "\\'");
  var jsonString = '{"username": "$username","message": "$message"}';
  return jsonString;
}
