impl Solution {

use std::collections::HashSet;

struct Solution;

impl Solution {
    pub fn alphabet_board_path(target: String) -> String {
        let mut res = String::new();
        let mut cur = (0, 0);
        for c in target.chars() {
            let pos = get_pos(c);
            while cur.0 > pos.0 {
                res.push('U');
                cur.0 -= 1;
            }
            while cur.1 > pos.1 {
                res.push('L');
                cur.1 -= 1;
            }
            while cur.0 < pos.0 {
                res.push('D');
                cur.0 += 1;
            }
            while cur.1 < pos.1 {
                res.push('R');
                cur.1 += 1;
            }
            res.push(c);
        }
        res
    }
}

fn get_pos(c: char) -> (i32, i32) {
    let idx = c as i32 - 'a' as i32;
    (idx / 5, idx % 5)
}
}