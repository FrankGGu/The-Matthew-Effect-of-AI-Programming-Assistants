function splitWordsBySeparator(words, separator) {
    return words.flatMap(word => word.split(separator));
}