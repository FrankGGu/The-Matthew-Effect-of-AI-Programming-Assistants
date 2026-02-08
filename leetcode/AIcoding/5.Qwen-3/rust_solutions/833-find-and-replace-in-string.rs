struct Solution;

impl Solution {
    pub fn find_replace_string(s: String, indices: Vec<i32>, sources: Vec<String>, targets: Vec<String>) -> String {
        let mut s = s.chars().collect::<Vec<char>>();
        let n = indices.len();
        let mut operations = Vec::with_capacity(n);

        for i in 0..n {
            let idx = indices[i] as usize;
            let src = &sources[i];
            let tgt = &targets[i];
            if s[idx..idx + src.len()].iter().eq(src.chars()) {
                operations.push((idx, src.len(), tgt));
            }
        }

        operations.sort_by(|a, b| b.0.cmp(&a.0));

        for (start, len, target) in operations {
            s.splice(start..start + len, target.chars());
        }

        s.into_iter().collect()
    }
}