pub struct Player {
    pub health: u32,
    pub mana: Option<u32>,
    pub level: u32,
}

impl Player {
    pub fn revive(&self) -> Option<Player> {
        if self.health != 0 {
            return None
        }

        Some(Player {
            health: 100,
            mana: if self.level >= 10 { Some(100) } else { None },
            level: self.level
        })
    }

    pub fn cast_spell(&mut self, mana_cost: u32) -> u32 {
        let full_damage = mana_cost * 2;
        let mut actual_damage = 0;

        match self.mana {
            Some(m) if m > mana_cost => {
                self.mana = Some(m - mana_cost);
                actual_damage = full_damage;
            },
            Some(m) if m == mana_cost => {
                self.mana = None;
                actual_damage = full_damage;
            },
            Some(m) if m < mana_cost => (),
            _ if self.health > mana_cost => self.health -= mana_cost,
            _ => self.health = 0
        }

        actual_damage
    }
}
