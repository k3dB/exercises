# Anagram

Welcome to Anagram on Exercism's MIPS Assembly Track.
If you need help running the tests or submitting your code, check out `HELP.md`.
If you get stuck on the exercise, check out `HINTS.md`, but try and solve it without using those first :)

## Introduction

At a garage sale, you find a lovely vintage typewriter at a bargain price!
Excitedly, you rush home, insert a sheet of paper, and start typing away.
However, your excitement wanes when you examine the output: all words are garbled!
For example, it prints "stop" instead of "post" and "least" instead of "stale."
Carefully, you try again, but now it prints "spot" and "slate."
After some experimentation, you find there is a random delay before each letter is printed, which messes up the order.
You now understand why they sold it for so little money!

You realize this quirk allows you to generate anagrams, which are words formed by rearranging the letters of another word.
Pleased with your finding, you spend the rest of the day generating hundreds of anagrams.

## Instructions

Given a target word and one or more candidate words, your task is to find the candidates that are anagrams of the target.

An anagram is a rearrangement of letters to form a new word: for example `"owns"` is an anagram of `"snow"`.
A word is _not_ its own anagram: for example, `"stop"` is not an anagram of `"stop"`.

The target word and candidate words are made up of one or more ASCII alphabetic characters (`A`-`Z` and `a`-`z`).
Lowercase and uppercase characters are equivalent: for example, `"PoTS"` is an anagram of `"sTOp"`, but `"StoP"` is not an anagram of `"sTOp"`.
The words you need to find should be taken from the candidate words, using the same letter case.

Given the target `"stone"` and the candidate words `"stone"`, `"tones"`, `"banana"`, `"tons"`, `"notes"`, and `"Seton"`, the anagram words you need to find are `"tones"`, `"notes"`, and `"Seton"`.

## Input/Output format

Each set of words is represented as a null-terminated string, with a newline character at the end of each word.

You must return the anagrams in the same order as they are listed in the candidate words.

An example would be `"tones\nnotes\nSeton\n"`

## Registers

| Register | Usage        | Type    | Description                                                    |
| -------- | ------------ | ------- | -------------------------------------------------------------- |
| `$a0`    | input        | address | null-terminated target string, without newline                 |
| `$a1`    | input        | address | null-terminated candidates string with newline after each word |
| `$a2`    | input/output | address | null-terminated output string with newline after each word     |
| `$t0-9`  | temporary    | any     | for temporary storage                                          |

## Source

### Created by

- @keiravillekode

### Based on

Inspired by the Extreme Startup game - https://github.com/rchatley/extreme_startup