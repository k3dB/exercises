let birthday = "Birthday"
let valentine = "Valentine's Day"
let anniversary = "Anniversary"

let space: Character = " "
let exclamation: Character = "!"

func buildSign(for occasion: String, name: String) -> String {
    var message = "Happy"
    message.append(space)
    message += occasion
    message.append(space)
    message += name
    message.append(exclamation)

    return message
}

func graduationFor(name: String, year: Int) -> String {
    """
    Congratulations \(name)!
    Class of \(year)
    """
}

func costOf(sign: String) -> Int {
    20 + sign.count * 2
}
