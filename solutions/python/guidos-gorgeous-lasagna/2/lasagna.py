EXPECTED_BAKE_TIME = 40
PREPARATION_TIME = 2

def bake_time_remaining(elapsed_bake_time: int) -> int:
    """Calculate the bake time remaining in minutes."""
    return EXPECTED_BAKE_TIME - elapsed_bake_time

def preparation_time_in_minutes(number_of_layers: int) -> int:
    """Calulate the number of minutes it takes to prepare the lasagna."""
    return number_of_layers * PREPARATION_TIME

def elapsed_time_in_minutes(
        number_of_layers: int,
        elapsed_bake_time: int) -> int:
    """Calculate the total elapsed cooking time in minutes."""
    return preparation_time_in_minutes(number_of_layers) + elapsed_bake_time
