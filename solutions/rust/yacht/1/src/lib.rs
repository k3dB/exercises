#[derive(Debug)]
pub enum Category {
    Ones,
    Twos,
    Threes,
    Fours,
    Fives,
    Sixes,
    FullHouse,
    FourOfAKind,
    LittleStraight,
    BigStraight,
    Choice,
    Yacht,
}

type Dice = [u8; 5];

pub fn score(dice: Dice, category: Category) -> u8 {
    match category {
        Category::Ones   => dice.iter().filter(|&r| *r == 1).sum(),
        Category::Twos   => dice.iter().filter(|&r| *r == 2).sum(),
        Category::Threes => dice.iter().filter(|&r| *r == 3).sum(),
        Category::Fours  => dice.iter().filter(|&r| *r == 4).sum(),
        Category::Fives  => dice.iter().filter(|&r| *r == 5).sum(),
        Category::Sixes  => dice.iter().filter(|&r| *r == 6).sum(),
        Category::FullHouse      => score_full_house(dice),
        Category::FourOfAKind    => score_four_of_a_kind(dice),
        Category::LittleStraight => score_little_straight(dice),
        Category::BigStraight    => score_big_straight(dice),
        Category::Choice         => dice.iter().sum(),
        Category::Yacht          => score_yacht(dice)
    }
}

fn score_yacht(dice: Dice) -> u8 {
    if dice.windows(2).all(|r| r[0] == r[1]) {
        return 50
    }

    return 0
}

fn score_full_house(dice: Dice) -> u8 {
    let mut sorted = dice.to_vec();
    sorted.sort();

    if  sorted[0] != sorted[4]
    &&  sorted[0] == sorted[1]
    &&  sorted[3] == sorted[4]
    && (sorted[2] == sorted[0] || sorted[2] == sorted[4]) {
        return dice.iter().sum()
    }

    return 0
}

fn score_four_of_a_kind(dice: Dice) -> u8 {
    let mut sorted = dice.to_vec();
    sorted.sort();

    if sorted[0] == sorted[3] {
        return sorted[0] * 4
    }

    if sorted[1] == sorted[4] {
        return sorted[4] * 4
    }

    return 0
}

fn score_little_straight(dice: Dice) -> u8 {
    let mut sorted = dice.to_vec();
    sorted.sort();

    if sorted == vec![1, 2, 3, 4, 5] {
        return 30
    }

    return 0
}

fn score_big_straight(dice: Dice) -> u8 {
    let mut sorted = dice.to_vec();
    sorted.sort();

    if sorted == vec![2, 3, 4, 5, 6] {
        return 30
    }

    return 0
}
