use std::collections::HashMap;

pub fn can_construct_note(magazine: &[&str], note: &[&str]) -> bool {
    let mut magazine_map = HashMap::new();
    for word in magazine {
        let count = magazine_map.entry(word).or_insert(0);
        *count += 1;
    }

    let mut note_map = HashMap::new();
    for word in note {
        let count = note_map.entry(word).or_insert(0);
        *count += 1;
    }

    for (key, value) in &note_map {
        if magazine_map.get(key).copied().unwrap_or(0) < *value {
            return false;
        }
    }

    true
}
