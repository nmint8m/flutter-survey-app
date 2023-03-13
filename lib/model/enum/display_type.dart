enum DisplayType {
  intro,
  star,
  heart,
  smiley,
  choice,
  nps,
  textarea,
  textfield,
  outro,
  dropdown,
  slider,
  money,
  unknown;

  bool get isNeededInput {
    switch (this) {
      case DisplayType.textfield:
      case DisplayType.textarea:
        return true;
      default:
        return false;
    }
  }

  static DisplayType fromString(String value) {
    switch (value) {
      case 'intro':
        return DisplayType.intro;
      case 'star':
        return DisplayType.star;
      case 'heart':
        return DisplayType.heart;
      case 'smiley':
        return DisplayType.smiley;
      case 'choice':
        return DisplayType.choice;
      case 'nps':
        return DisplayType.nps;
      case 'textarea':
        return DisplayType.textarea;
      case 'textfield':
        return DisplayType.textfield;
      case 'outro':
        return DisplayType.outro;
      case 'dropdown':
        return DisplayType.dropdown;
      case 'slider':
        return DisplayType.slider;
      case 'money':
        return DisplayType.money;
      default:
        return DisplayType.unknown;
    }
  }
}
