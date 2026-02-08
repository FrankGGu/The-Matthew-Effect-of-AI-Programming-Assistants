impl Solution {

use std::str::FromStr;

struct Solution;

impl Solution {
    pub fn num_valid_emails(emails: Vec<String>) -> i32 {
        let mut count = 0;
        for email in emails {
            if is_valid_email(&email) {
                count += 1;
            }
        }
        count
    }
}

fn is_valid_email(email: &str) -> bool {
    let parts: Vec<&str> = email.split('@').collect();
    if parts.len() != 2 {
        return false;
    }
    let (local, domain) = (parts[0], parts[1]);

    if local.is_empty() || domain.is_empty() {
        return false;
    }

    if local.contains("..") {
        return false;
    }

    let local_chars: Vec<char> = local.chars().collect();
    let domain_chars: Vec<char> = domain.chars().collect();

    if local_chars.iter().any(|&c| !is_valid_local_char(c)) {
        return false;
    }

    if domain_chars.iter().any(|&c| !is_valid_domain_char(c)) {
        return false;
    }

    if domain.contains("..") {
        return false;
    }

    true
}

fn is_valid_local_char(c: char) -> bool {
    match c {
        'a'..='z' | 'A'..='Z' | '0'..='9' | '.' | '_' | '-' => true,
        _ => false,
    }
}

fn is_valid_domain_char(c: char) -> bool {
    match c {
        'a'..='z' | 'A'..='Z' | '0'..='9' | '.' | '-' => true,
        _ => false,
    }
}
}