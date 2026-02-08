struct Solution;

impl Solution {
    pub fn spellchecker(word_list: Vec<String>, target_words: Vec<String>) -> Vec<String> {
        use std::collections::HashSet;
        use std::collections::HashMap;

        let vowels = ['a', 'e', 'i', 'o', 'u'];

        fn to_devowel(word: &str) -> String {
            word.to_lowercase()
                .chars()
                .map(|c| if vowels.contains(&c) { '*' } else { c })
                .collect()
        }

        let mut exact_matches = HashSet::new();
        let mut devowel_matches = HashMap::new();
        let mut case_insensitive_matches = HashMap::new();

        for word in &word_list {
            exact_matches.insert(word);
            let devowel = to_devowel(word);
            devowel_matches.entry(devowel).or_insert(word.clone());
            let case_insensitive = word.to_lowercase();
            case_insensitive_matches.entry(case_insensitive).or_insert(word.clone());
        }

        let mut result = Vec::new();

        for target in target_words {
            if exact_matches.contains(&target) {
                result.push(target);
                continue;
            }
            let devowel = to_devowel(&target);
            if let Some(matched) = devowel_matches.get(&devowel) {
                result.push(matched.clone());
                continue;
            }
            let case_insensitive = target.to_lowercase();
            if let Some(matched) = case_insensitive_matches.get(&case_insensitive) {
                result.push(matched.clone());
                continue;
            }
            result.push(target);
        }

        result
    }
}