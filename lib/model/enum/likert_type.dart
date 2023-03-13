enum LikertType {
  thumbsUp,
  smiley,
  heart,
  star;

  List<String> get icons {
    switch (this) {
      case LikertType.thumbsUp:
        return List.generate(5, (_) => '👍🏻');
      case LikertType.smiley:
        return ['😡', '😕', '😐', '🙂', '😄'];
      case LikertType.heart:
        return List.generate(5, (_) => '❤️');
      case LikertType.star:
        return List.generate(5, (_) => '⭐️');
    }
  }

  bool get isSinglyHighlight {
    switch (this) {
      case LikertType.smiley:
        return true;
      default:
        return false;
    }
  }
}
