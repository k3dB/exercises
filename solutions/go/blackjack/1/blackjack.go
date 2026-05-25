package blackjack

// ParseCard returns the integer value of a card following blackjack ruleset.
func ParseCard(card string) int {
    switch card {
    case "ace":
        return 11
    case "two":
        return 2
    case "three":
        return 3
    case "four":
        return 4
    case "five":
        return 5
    case "six":
        return 6
    case "seven":
        return 7
    case "eight":
        return 8
    case "nine":
        return 9
    case "ten", "jack", "queen", "king":
        return 10
    default:
        return 0
    }
}

// FirstTurn returns the decision for the first turn, given two cards of the
// player and one card of the dealer.
func FirstTurn(card1, card2, dealerCard string) string {
    yourHand    := ParseCard(card1) + ParseCard(card2)
    dealerShown := ParseCard(dealerCard)

    switch {
    case card1 == "ace" && card2 == "ace":
        return "P"
    case yourHand == 21 && dealerShown > 9:
        return "S"
    case yourHand == 21:
        return "W"
    case yourHand > 16 && yourHand < 21:
        return "S"
    case yourHand > 11 && yourHand < 17 && dealerShown > 6:
        return "H"
    case yourHand > 11 && yourHand < 17:
        return "S"
    default:
        return "H"
    }
}
