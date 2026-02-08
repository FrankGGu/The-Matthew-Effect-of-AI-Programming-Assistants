impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn tag_validator(code: String) -> bool {
        let mut stack = VecDeque::new();
        let mut i = 0;
        let len = code.len();
        while i < len {
            if code.as_bytes()[i] == b'<' {
                if i + 1 < len && code.as_bytes()[i + 1] == b'/' {
                    // closing tag
                    i += 2;
                    let start = i;
                    while i < len && code.as_bytes()[i] != b'>' {
                        i += 1;
                    }
                    if i >= len {
                        return false;
                    }
                    let tag = &code[start..i];
                    if tag.len() == 0 || tag.len() > 9 {
                        return false;
                    }
                    for c in tag.chars() {
                        if !c.is_ascii_uppercase() {
                            return false;
                        }
                    }
                    if stack.is_empty() {
                        return false;
                    }
                    let top = stack.pop_back();
                    if top != Some(tag.to_string()) {
                        return false;
                    }
                    i += 1;
                } else {
                    // opening tag
                    i += 1;
                    let start = i;
                    while i < len && code.as_bytes()[i] != b'>' {
                        i += 1;
                    }
                    if i >= len {
                        return false;
                    }
                    let tag = &code[start..i];
                    if tag.len() == 0 || tag.len() > 9 {
                        return false;
                    }
                    for c in tag.chars() {
                        if !c.is_ascii_uppercase() {
                            return false;
                        }
                    }
                    stack.push_back(tag.to_string());
                    i += 1;
                }
            } else {
                // text content
                i += 1;
            }
        }
        stack.is_empty()
    }
}
}