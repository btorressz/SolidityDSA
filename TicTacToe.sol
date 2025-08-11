// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

contract TicTacToe {
    function checkBoard(int[3][3] memory board) public pure returns (int) {
        // Check for win conditions
        for (int player = 1; player <= 2; player++) {
            // Check rows and columns
            for (uint i = 0; i < 3; i++) {
                if ((board[i][0] == player && board[i][1] == player && board[i][2] == player) ||
                    (board[0][i] == player && board[1][i] == player && board[2][i] == player)) {
                    return player;
                }
            }
            // Check diagonals
            if ((board[0][0] == player && board[1][1] == player && board[2][2] == player) ||
                (board[0][2] == player && board[1][1] == player && board[2][0] == player)) {
                return player;
            }
        }

        // Check for any empty spots, indicating the game is not finished
        for (uint i = 0; i < 3; i++) {
            for (uint j = 0; j < 3; j++) {
                if (board[i][j] == 0) {
                    return -1; // Game not finished
                }
            }
        }

        // If no win and no empty spots, it's a draw
        return 0; // Draw
    }
}
