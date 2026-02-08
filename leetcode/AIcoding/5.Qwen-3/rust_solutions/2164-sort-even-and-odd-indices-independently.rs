impl Solution {
    pub fn sort_even_odd(mut nums: Vec<i32>) -> Vec<i32> {
        let even: Vec<i32> = nums.iter().enumerate().filter(|&(i, _)| i % 2 == 0).map(|(_, &x)| x).collect();
        let odd: Vec<i32> = nums.iter().enumerate().filter(|&(i, _)| i % 2 != 0).map(|(_, &x)| x).collect();

        let mut even = even;
        let mut odd = odd;
        even.sort();
        odd.sort();

        let mut result = Vec::with_capacity(nums.len());
        let mut e = 0;
        let mut o = 0;

        for i in 0..nums.len() {
            if i % 2 == 0 {
                result.push(even[e]);
                e += 1;
            } else {
                result.push(odd[o]);
                o += 1;
            }
        }

        result
    }
}