class SymbolReplacer {
    protected String stringToReplace;
    protected List<String> alreadyReplaced = new ArrayList<String>();

    SymbolReplacer(String s) {
      this.stringToReplace = s;
    }

    String replace() {
      Pattern symbolPattern = Pattern.compile("\\$([a-zA-Z]\\w*)");
      Matcher symbolMatcher = symbolPattern.matcher(stringToReplace);
      while (symbolMatcher.find()) {
        String symbolName = symbolMatcher.group(1);
        if (getSymbol(symbolName) != null && !alreadyReplaced.contains(symbolName)) {
          alreadyReplaced.add(symbolName);
          stringToReplace = stringToReplace.replace("$" + symbolName, translate(symbolName));
        }
      }
      return stringToReplace;
    }

    protected String translate(String symbolName) {
      return getSymbol(symbolName);
    }
  }