impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn count_valid_times(time: String) -> i32 {
        let mut count = 0;
        let time_chars: Vec<char> = time.chars().collect();

        for h in 0..24 {
            for m in 0..60 {
                for s in 0..60 {
                    let h_str = format!("{:02}", h);
                    let m_str = format!("{:02}", m);
                    let s_str = format!("{:02}", s);

                    let mut valid = true;
                    for i in 0..5 {
                        match time_chars[i] {
                            '*' => continue,
                            _ if time_chars[i] != h_str.chars().nth(i).unwrap() && i < 2 => {
                                valid = false;
                                break;
                            },
                            _ if time_chars[i] != m_str.chars().nth(i - 2).unwrap() && i >= 2 && i < 4 => {
                                valid = false;
                                break;
                            },
                            _ if time_chars[i] != s_str.chars().nth(i - 4).unwrap() && i >= 4 => {
                                valid = false;
                                break;
                            },
                            _ => {}
                        }
                    }

                    if valid {
                        count += 1;
                    }
                }
            }
        }

        count
    }
}
}