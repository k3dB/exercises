#[cfg(feature = "grapheme")]
use unicode_reverse::reverse_grapheme_clusters_in_place;

pub fn reverse(input: &str) -> String {
    #[cfg(feature = "grapheme")]
    if cfg!(feature = "grapheme") {
        let mut reversed = input.to_string();
        reverse_grapheme_clusters_in_place(&mut reversed);
        return reversed;
    }

    input.chars().rev().collect()
}
