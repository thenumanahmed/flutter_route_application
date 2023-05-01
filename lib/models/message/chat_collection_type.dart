enum ChatCollectionType { individual, group }

String chatCollectionTypeToString(ChatCollectionType value) {
  switch (value) {
    case ChatCollectionType.individual:
      return 'individual';
    case ChatCollectionType.group:
      return 'group';
    default:
      throw ArgumentError('Invalid value: $value');
  }
}

ChatCollectionType stringToChatCollectionType(String value) {
  switch (value) {
    case 'individual':
      return ChatCollectionType.individual;
    case 'group':
      return ChatCollectionType.group;
    default:
      throw ArgumentError('Invalid value: $value');
  }
}
