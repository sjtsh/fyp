class RelatedWord {
  final int categoryID;
  final String text;

  RelatedWord(this.categoryID, this.text);

  factory RelatedWord.fromJson(Map<String, dynamic> json) {
    return RelatedWord(json["category"], json["text"]);
  }
}
