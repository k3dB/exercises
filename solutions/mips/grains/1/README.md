# Grains

Welcome to Grains on Exercism's MIPS Assembly Track.
If you need help running the tests or submitting your code, check out `HELP.md`.
If you get stuck on the exercise, check out `HINTS.md`, but try and solve it without using those first :)

## Introduction

There once was a wise servant who saved the life of a prince.
The king promised to pay whatever the servant could dream up.
Knowing that the king loved chess, the servant told the king he would like to have grains of wheat.
One grain on the first square of a chessboard, with the number of grains doubling on each successive square.

## Instructions

Calculate the number of grains of wheat on a chessboard.

A chessboard has 64 squares.
Square 1 has one grain, square 2 has two grains, square 3 has four grains, and so on, doubling each time.

Write code that calculates:

- the number of grains on a given square
- the total number of grains on the chessboard

## Registers

| Register | Usage     | Type    | Description                      |
| -------- | --------- | ------- | -------------------------------- |
| `$a0`    | input     | integer | square number in the range 1..64 |
| `$v0`    | output    | integer | low 32 bits of output            |
| `$v1`    | output    | integer | high 32 bits of output           |
| `$t0-9`  | temporary | any     | for temporary storage            |

## Source

### Created by

- @keiravillekode

### Based on

The CodeRanch Cattle Drive, Assignment 6 - https://web.archive.org/web/20240908084142/https://coderanch.com/wiki/718824/Grains