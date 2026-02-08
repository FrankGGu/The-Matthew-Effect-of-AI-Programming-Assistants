impl Solution {
    pub fn largest_special_integer(s: String) -> String {
        let mut max_num = String::new();
        let mut count = 0;
        let mut current = String::new();

        for c in s.chars() {
            if c == '0' {
                count += 1;
                current.push(c);
            } else {
                if count >= 3 {
                    let num = format!("000{}", current.len() - 3);
                    if num.len() > max_num.len() || (num.len() == max_num.len() && num > max_num) {
                        max_num = num;
                    }
                }
                count = 0;
                current.clear();
            }
        }

        if count >= 3 {
            let num = format!("000{}", current.len() - 3);
            if num.len() > max_num.len() || (num.len() == max_num.len() && num > max_num) {
                max_num = num;
            }
        }

        max_num
    }
}