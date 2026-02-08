impl Solution {

use std::net::Ipv4Addr;
use std::str::FromStr;

struct Solution;

impl Solution {
    pub fn is_valid_ip(ip: String) -> bool {
        if ip.len() == 0 {
            return false;
        }
        let parts: Vec<&str> = ip.split('.').collect();
        if parts.len() != 4 {
            return false;
        }
        for part in &parts {
            if part.len() == 0 || part.len() > 3 {
                return false;
            }
            if part.starts_with('0') && part.len() > 1 {
                return false;
            }
            if let Ok(num) = part.parse::<u8>() {
                if num > 255 {
                    return false;
                }
            } else {
                return false;
            }
        }
        true
    }

    pub fn valid_ip_addresses(ip: String) -> Vec<String> {
        let mut result = Vec::new();
        let parts: Vec<&str> = ip.split('.').collect();
        if parts.len() != 4 {
            return vec![];
        }
        for i in 0..4 {
            let original_part = parts[i];
            if original_part.len() == 0 {
                continue;
            }
            let mut modified_part = original_part.to_string();
            if modified_part.starts_with('0') && modified_part.len() > 1 {
                modified_part = modified_part[1..].to_string();
            }
            let modified_ip = match i {
                0 => format!("{}.{},{},{}", modified_part, parts[1], parts[2], parts[3]),
                1 => format!("{},{}.{},{}", parts[0], modified_part, parts[2], parts[3]),
                2 => format!("{},{}.{},{}", parts[0], parts[1], modified_part, parts[3]),
                3 => format!("{},{},{}.{}", parts[0], parts[1], parts[2], modified_part),
                _ => continue,
            };
            if Solution::is_valid_ip(modified_ip.clone()) {
                result.push(modified_ip);
            }
        }
        result
    }
}
}