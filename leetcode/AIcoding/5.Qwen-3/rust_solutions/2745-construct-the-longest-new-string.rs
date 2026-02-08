impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn longest_string(n: i32) -> String {
        let mut map = HashMap::new();
        map.insert('a', 0);
        map.insert('b', 0);
        map.insert('c', 0);
        let mut result = Vec::new();
        Self::backtrack(n, &mut map, &mut result);
        result.iter().collect()
    }

    fn backtrack(n: i32, map: &mut HashMap<char, i32>, result: &mut Vec<char>) -> bool {
        if result.len() == 2 * n as usize {
            return true;
        }
        for c in ['a', 'b', 'c'] {
            if *map.get(&c).unwrap() < n {
                if result.is_empty() || result.last().unwrap() != &c {
                    result.push(c);
                    *map.get_mut(&c).unwrap() += 1;
                    if Self::backtrack(n, map, result) {
                        return true;
                    }
                    result.pop();
                    *map.get_mut(&c).unwrap() -= 1;
                }
            }
        }
        false
    }
}
}