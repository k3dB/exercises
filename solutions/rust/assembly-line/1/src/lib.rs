const LINE_RATE_PER_HOUR: f64 = 221.0;
const MINUTES_PER_HOUR: f64 = 60.0;

struct Quality {
  high: f64,
  medium: f64,
  low: f64
}

pub fn production_rate_per_hour(speed: u8) -> f64 {
    speed as f64 * LINE_RATE_PER_HOUR * success_percentage(speed)
}

pub fn working_items_per_minute(speed: u8) -> u32 {
    (production_rate_per_hour(speed) / MINUTES_PER_HOUR).floor() as u32
}

fn success_percentage(speed: u8) -> f64 {
    let percentage = Quality { high: 1.0, medium: 0.9, low: 0.77 };

    match speed {
        1..=4 => percentage.high,
        5..=8 => percentage.medium,
        _ => percentage.low
    }
}
