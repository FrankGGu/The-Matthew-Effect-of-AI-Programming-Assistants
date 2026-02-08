struct Solution;

impl Solution {
    pub fn count_vowel_permutation(n: i32) -> i32 {
        let mod_val = 10_i64.pow(9) + 7;
        let mut a = 1;
        let mut e = 1;
        let mut i = 1;
        let mut o = 1;
        let mut u = 1;

        for _ in 1..n {
            let new_a = (e + i + u) % mod_val;
            let new_e = (a + i) % mod_val;
            let new_i = (e + o) % mod_val;
            let new_o = (i) % mod_val;
            let new_u = (i + o) % mod_val;

            a = new_a;
            e = new_e;
            i = new_i;
            o = new_o;
            u = new_u;
        }

        (a + e + i + o + u) % mod_val as i32
    }
}