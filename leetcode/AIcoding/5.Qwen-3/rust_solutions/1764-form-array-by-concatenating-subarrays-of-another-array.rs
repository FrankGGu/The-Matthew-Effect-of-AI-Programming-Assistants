impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn can_form_array(concatenated: Vec<i32>, subsets: Vec<Vec<i32>>) -> bool {
        let mut map = HashSet::new();
        for subset in &subsets {
            map.insert(subset);
        }

        let mut i = 0;
        while i < concatenated.len() {
            let mut found = false;
            for subset in &subsets {
                if concatenated[i] == subset[0] {
                    let mut j = 0;
                    while j < subset.len() && i + j < concatenated.len() && concatenated[i + j] == subset[j] {
                        j += 1;
                    }
                    if j == subset.len() {
                        i += j;
                        found = true;
                        break;
                    }
                }
            }
            if !found {
                return false;
            }
        }
        true
    }
}
}