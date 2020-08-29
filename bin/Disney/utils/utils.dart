String getCleanID(String id) {
  if (id != null) {
    var regex = RegExp(r'^([^;]+)');
    var matches = regex.firstMatch(id);
    if (matches != null) {
      return matches.group(1);
    }
  }

  return '';
}
