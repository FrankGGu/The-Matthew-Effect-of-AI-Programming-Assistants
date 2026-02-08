impl Solution {

use std::vec;

struct Solution;

impl Solution {
    pub fn full_justify(words: Vec<String>, max_width: i32) -> Vec<String> {
        let mut result = Vec::new();
        let mut current_line = Vec::new();
        let mut current_length = 0;

        for word in words {
            if current_length + word.len() + current_line.len() > max_width as usize {
                let spaces = max_width as usize - current_length;
                let mut line = String::new();

                if current_line.len() == 1 {
                    line.push_str(&current_line[0]);
                    line.push_str(&" ".repeat(spaces));
                } else {
                    let total_spaces = spaces;
                    let num_gaps = current_line.len() - 1;
                    let mut space_per_gap = total_spaces / num_gaps;
                    let mut extra_spaces = total_spaces % num_gaps;

                    for (i, w) in current_line.iter().enumerate() {
                        line.push_str(w);
                        if i < num_gaps {
                            line.push_str(&" ".repeat(space_per_gap + if extra_spaces > 0 { 1 } else { 0 }));
                            if extra_spaces > 0 {
                                extra_spaces -= 1;
                            }
                        }
                    }
                }

                result.push(line);
                current_line = vec![word];
                current_length = word.len();
            } else {
                current_line.push(word);
                current_length += word.len();
            }
        }

        let mut last_line = current_line.join(" ");
        last_line.push_str(&" ".repeat(max_width as usize - last_line.len()));
        result.push(last_line);

        result
    }
}
}