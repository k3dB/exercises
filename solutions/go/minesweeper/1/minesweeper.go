package minesweeper

import "strconv"

// Annotate returns an annotated board
func Annotate(board []string) []string {
    rowCount := len(board)

    for i := 0; i < rowCount; i++ {
        row := []rune(board[i])
        columnCount := len(row)

        for j := 0; j < columnCount; j++ {
            if !IsBomb(row[j]) { continue }

            if i > 0 {
                board[i - 1] = UpdateRow(board[i - 1], j)
            }

            board[i] = UpdateRow(board[i], j)

            if i < rowCount - 1 {
                board[i + 1] = UpdateRow(board[i + 1], j)
            }
        }
    }

    return board
}

func IsBomb(label rune) bool {
    return label == '*'
}

func UpdateRow(row string, index int) string {
    tiles := []rune(row)

    if index > 0 && !IsBomb(tiles[index - 1]) {
        tiles[index - 1] = Increment(tiles[index - 1])
    }

    if !IsBomb(tiles[index]) {
        tiles[index] = Increment(tiles[index])
    }

    if index < len(tiles) - 1 && !IsBomb(tiles[index + 1]) {
        tiles[index + 1] = Increment(tiles[index + 1])
    }

    return string(tiles)
}

func Increment(label rune) rune {
    if label >= '1' && label <= '7' {
        return []rune(strconv.Itoa(int(label - '0') + 1))[0]
    }

    return '1'
}
