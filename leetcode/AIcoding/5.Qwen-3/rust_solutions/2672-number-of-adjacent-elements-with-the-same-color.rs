impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn number_of_adjacent_elements_with_the_same_color(colors: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let n = colors.len();
        let mut result = Vec::new();
        let mut same_color = HashSet::new();

        for i in 0..n - 1 {
            if colors[i] == colors[i + 1] {
                same_color.insert(i);
                same_color.insert(i + 1);
            }
        }

        for query in queries {
            let index = query[0] as usize;
            let color = query[1];

            if index > 0 && colors[index] == colors[index - 1] {
                same_color.remove(&(index - 1));
                same_color.remove(&index);
            }

            if index < n - 1 && colors[index] == colors[index + 1] {
                same_color.remove(&index);
                same_color.remove(&(index + 1));
            }

            colors[index] = color;

            if index > 0 && colors[index] == colors[index - 1] {
                same_color.insert(index - 1);
                same_color.insert(index);
            }

            if index < n - 1 && colors[index] == colors[index + 1] {
                same_color.insert(index);
                same_color.insert(index + 1);
            }

            result.push(same_color.len() as i32);
        }

        result
    }
}
}