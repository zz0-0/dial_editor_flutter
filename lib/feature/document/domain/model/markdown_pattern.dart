class MarkdownPattern {
  static final headingRegex = RegExp('^#{1,6}');
  static final customIdHeadingRegex =
      RegExp(r'^(#{1,6})\s+(.+?)(?:\s+\{#([a-zA-Z0-9\-_]+)\})?$');
  static final boldRegex = RegExp(r'(\*\*|__)(.*?)\1');
  static final italicRegex = RegExp(r'(\*|_)(.*?)\1');
  static final boldItalicRegex = RegExp(r'(\*\*\*|___)(.*?)\1');
  static final unorderedListRegex = RegExp(r'^[-*]\s');
  static final orderListRegex = RegExp(r'^\d+\.\s');
  static final taskListRegex = RegExp(r'^- \[([ xX])\](.*)$');
  static final strikethroughRegex = RegExp('~~(.*?)~~');
  // static final imageRegex = RegExp(
  //   r'!\[([^\]]*)\]\((https?:\/\/[^\s)]+\.(?:jpg|jpeg|png|gif|bmp|webp|svg|tiff|ico))\)',
  // );
  static final imageUrlPathRegex = RegExp(
    r'^(https?:\/\/[^\s\)]+\.(jpg|jpeg|png|gif|bmp|webp|svg|tiff|ico))$',
  );
  // static final imageFileRegex = RegExp(
  //     r'!\[([^\]]*)\]\((?:[a-zA-Z]:)?[\/\\][^\s\/\\]+(?:[\/\\][^\s\/\\]+)*(?:\.(jpg|jpeg|png|gif|bmp|webp|svg|tiff|ico))\)');
  static final imageFilePathRegex = RegExp(
    r'^(?:[a-zA-Z]:)?[\/\\][^\s\/\\]+(?:[\/\\][^\s\/\\]+)*(?:\.(jpg|jpeg|png|gif|bmp|webp|svg|tiff|ico))$',
  );
  static final imageRegex = RegExp(
    r'!\[([^\]]*)\]\(((https?:\/\/[^\s\)]+\.(?:jpg|jpeg|png|gif|bmp|webp|svg|tiff|ico))|((?:[a-zA-Z]:)?[\/\\][^\s\/\\]+(?:[\/\\][^\s\/\\]+)*(?:\.(?:jpg|jpeg|png|gif|bmp|webp|svg|tiff|ico))))\)',
  );
  static final imageUrlRegex = RegExp(
    r'^(https?:\/\/[^\s\)]+\.(?:jpg|jpeg|png|gif|bmp|webp|svg|tiff|ico)|(?:[a-zA-Z]:)?[\/\\][^\s\/\\]+(?:[\/\\][^\s\/\\]+)*(?:\.(?:jpg|jpeg|png|gif|bmp|webp|svg|tiff|ico)))$',
  );
  static final linkRegex = RegExp(r'\[(.*?)\]\((.*?)\)');
  static final urlRegex = RegExp(r'^https?:\/\/[^\s]+$');
  static final highlightRegex = RegExp('==(.*?)==');
  static final subscriptRegex = RegExp('~(.*?)~');
  static final superscriptRegex = RegExp(r'\^(.*?)\^');
  static final horizontalRuleRegex = RegExp(r'^\s*([-*_]){3,}\s*$');
  static final emojiRegex = RegExp(':([a-zA-Z0-9_]+):');
  static final inlineMathRegex = RegExp(r'\$([^\$]*)\$');
  static final blockMathRegex = RegExp(r'\$\$(.*?)\$\$');
  static final codeBlockRegex = RegExp(r'^```(?:[^\S\r\n].*)?$');
  static final quoteRegex = RegExp('^>.+');
}
