struct Solution {}

impl Solution {
    pub fn clumsy(n: i32) -> i32 {
        if n == 1 {
            return 1;
        }
        let mut stack = Vec::new();
        stack.push(n);
        let mut i = n - 1;
        let mut op = 0;
        while i > 0 {
            match op % 4 {
                0 => stack.push(stack.pop().unwrap() * i),
                1 => stack.push(stack.pop().unwrap() / i),
                2 => stack.push(-i),
                3 => stack.push(i),
                _ => {}
            }
            i -= 1;
            op += 1;
        }
        stack.iter().sum()
    }
}