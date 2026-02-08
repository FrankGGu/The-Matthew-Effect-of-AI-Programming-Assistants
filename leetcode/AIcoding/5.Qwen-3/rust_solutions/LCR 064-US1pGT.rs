struct MagicDictionary {
    words: Vec<String>,
}

impl MagicDictionary {
    fn new() -> Self {
        MagicDictionary { words: Vec::new() }
    }

    fn build_dict(&mut self, dictionary: Vec<String>) {
        self.words = dictionary;
    }

    fn search(&self, target: String) -> bool {
        for word in &self.words {
            let mut diff = 0;
            for (a, b) in target.chars().zip(word.chars()) {
                if a != b {
                    diff += 1;
                    if diff > 1 {
                        break;
                    }
                }
            }
            if diff == 1 && target.len() == word.len() {
                return true;
            }
        }
        false
    }
}