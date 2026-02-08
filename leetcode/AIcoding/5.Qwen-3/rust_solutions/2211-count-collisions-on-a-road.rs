struct Solution;

impl Solution {
    pub fn count_collisions(robots: String) -> i32 {
        let mut stack = Vec::new();
        let mut count = 0;

        for c in robots.chars() {
            match c {
                'L' => {
                    if let Some(&last) = stack.last() {
                        if last == 'R' {
                            count += 1;
                            stack.pop();
                            while let Some(&prev) = stack.last() {
                                if prev == 'R' {
                                    count += 1;
                                    stack.pop();
                                } else {
                                    break;
                                }
                            }
                        }
                    }
                },
                'R' => {
                    stack.push(c);
                },
                'S' => {
                    while let Some(&last) = stack.last() {
                        if last == 'R' {
                            count += 1;
                            stack.pop();
                        } else {
                            break;
                        }
                    }
                    stack.push(c);
                },
                _ => {}
            }
        }

        count
    }
}