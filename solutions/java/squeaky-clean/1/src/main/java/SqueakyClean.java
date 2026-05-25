class SqueakyClean {
    static String clean(String identifier) {
        StringBuilder builder = new StringBuilder();
        boolean isKebob = false;

        char[] nonLowerGreekCharacters = identifier
            .replaceAll("[α-ω]", "")
            .toCharArray();

        for (char c : nonLowerGreekCharacters) {
            if (c == '-') {
                isKebob = true;
            }
            else if (Character.isSpaceChar(c)) {
                builder.append('_');
            }
            else if (Character.isISOControl(c)) {
                builder.append("CTRL");
            }
            else if (Character.isLetter(c)) {
                builder.append(isKebob ? Character.toUpperCase(c) : c);
                isKebob = false;
            }
        }

        return builder.toString();
    }
}
