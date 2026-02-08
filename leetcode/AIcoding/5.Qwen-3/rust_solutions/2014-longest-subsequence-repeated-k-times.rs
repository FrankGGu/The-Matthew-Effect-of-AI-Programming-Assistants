impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn longest_repeating_subsequence(s: String, k: i32) -> String {
        let s = s.as_bytes();
        let n = s.len();
        let mut result = String::new();
        let mut candidates = HashSet::new();

        for len in (1..=n).rev() {
            let mut queue = vec![];
            for c in b'a'..=b'z' {
                if s.iter().filter(|&&ch| ch == c).count() >= k as usize {
                    queue.push(vec![c]);
                }
            }

            while let Some(mut curr) = queue.pop() {
                let curr_str = unsafe { std::str::from_utf8_unchecked(&curr) };
                if curr_str.len() > result.len() {
                    result = curr_str.to_string();
                }

                let last = *curr.last().unwrap();
                for next in b'a'..=b'z' {
                    let mut new_seq = curr.clone();
                    new_seq.push(next);
                    if is_subsequence(&new_seq, s, k) {
                        queue.push(new_seq);
                    }
                }
            }
        }

        result
    }
}

fn is_subsequence(seq: &[u8], s: &[u8], k: i32) -> bool {
    let mut count = 0;
    let mut i = 0;
    let mut j = 0;

    while i < seq.len() && j < s.len() {
        if seq[i] == s[j] {
            i += 1;
            j += 1;
        } else {
            j += 1;
        }
    }

    if i == seq.len() {
        count += 1;
        i = 0;
        j = 0;
        while i < seq.len() && j < s.len() {
            if seq[i] == s[j] {
                i += 1;
                j += 1;
            } else {
                j += 1;
            }
        }
        if i == seq.len() && count >= k as usize {
            return true;
        }
    }

    false
}
}