struct Solution;

impl Solution {
    pub fn find_substring(s: String, power: i32, modulo: i32, k: i32, hash_value: i32) -> String {
        let n = s.len();
        let mut result = 0;
        let mut current_hash = 0;
        let mut power_k = 1;
        let base = 256;
        let mod_val = modulo as u64;
        let power_val = power as u64;
        let k_val = k as u64;
        let hash_val = hash_value as u64;

        for i in 0..k as usize {
            current_hash = (current_hash * base + s.as_bytes()[i] as u64) % mod_val;
            power_k = (power_k * power_val) % mod_val;
        }

        if current_hash == hash_val {
            return s[0..k as usize].to_string();
        }

        for i in k as usize..n {
            current_hash = (current_hash - s.as_bytes()[i - k as usize] as u64) % mod_val;
            current_hash = (current_hash * power_val + s.as_bytes()[i] as u64) % mod_val;
            if current_hash == hash_val {
                result = i - k as usize + 1;
                break;
            }
        }

        s[result..result + k as usize].to_string()
    }
}