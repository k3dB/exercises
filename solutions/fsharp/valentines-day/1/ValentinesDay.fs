module ValentinesDay

type Approval =
    | Yes
    | No
    | Maybe

type Cuisine =
    | Korean
    | Turkish

type Genre =
    | Crime
    | Horror
    | Romance
    | Thriller

type Activity =
    | BoardGame
    | Chill
    | Movie of Genre
    | Restaurant of Cuisine
    | Walk of int

let rateActivity (activity: Activity): Approval =
    match activity with
        | BoardGame -> Approval.No
        | Chill -> Approval.No
        | Movie m ->
            match m with
                | Genre.Romance -> Approval.Yes
                | _ -> Approval.No
        | Restaurant r ->
            match r with
                | Cuisine.Korean -> Approval.Yes
                | _ -> Approval.Maybe
        | Walk distance ->
            match distance with
                | d when d < 3 -> Approval.Yes
                | d when d < 5 -> Approval.Maybe
                | _ -> Approval.No
