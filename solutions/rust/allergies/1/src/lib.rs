pub struct Allergies {
    pub score: u32
}

#[derive(Debug, PartialEq, Eq)]
pub enum Allergen {
    Eggs,
    Peanuts,
    Shellfish,
    Strawberries,
    Tomatoes,
    Chocolate,
    Pollen,
    Cats,
}

impl Allergies {
    pub fn new(score: u32) -> Self {
        Self {
            score: score
        }
    }

    pub fn is_allergic_to(&self, allergen: &Allergen) -> bool {
        match allergen {
            Allergen::Eggs         => self.score &   1 ==   1,
            Allergen::Peanuts      => self.score &   2 ==   2,
            Allergen::Shellfish    => self.score &   4 ==   4,
            Allergen::Strawberries => self.score &   8 ==   8,
            Allergen::Tomatoes     => self.score &  16 ==  16,
            Allergen::Chocolate    => self.score &  32 ==  32,
            Allergen::Pollen       => self.score &  64 ==  64,
            Allergen::Cats         => self.score & 128 == 128
        }
    }

    pub fn allergies(&self) -> Vec<Allergen> {
        let mut allergens = vec![
            Allergen::Eggs,
            Allergen::Peanuts,
            Allergen::Shellfish,
            Allergen::Strawberries,
            Allergen::Tomatoes,
            Allergen::Chocolate,
            Allergen::Pollen,
            Allergen::Cats
        ];

        allergens.retain(|allergen| self.is_allergic_to(&allergen));

        allergens
    }
}
