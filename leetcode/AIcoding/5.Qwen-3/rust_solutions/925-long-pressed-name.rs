struct Solution;

impl Solution {
    pub fn is_long_pressed_name(name: String, typed: String) -> bool {
        let mut i = 0;
        let mut j = 0;
        let name: Vec<char> = name.chars().collect();
        let typed: Vec<char> = typed.chars().collect();

        while i < name.len() && j < typed.len() {
            if name[i] == typed[j] {
                i += 1;
                j += 1;
            } else {
                return false;
            }
        }

        while j < typed.len() {
            if typed[j] != name[i - 1] {
                return false;
            }
            j += 1;
        }

        i == name.len()
    }
}