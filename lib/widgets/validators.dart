String? stringValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "Enter any text";
  }
  const maxLength = 100;
  if (value.length > maxLength) {
    return "Please do not enter more than $maxLength characters here";
  }
  return null;
}

String? uriStringValidator(String? value) {
  final result = stringValidator(value);
  if (result != null) {
    return result;
  }
  var uri = Uri.parse(value!);
  final allowedSchemes = ["ws", "wss", "tcp"];
  if (!allowedSchemes.contains(uri.scheme)) {
    return "<scheme> should be one of ${allowedSchemes.join(", ")}";
  }
}
