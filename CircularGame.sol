// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CircularGame {
    // Josephus problem solver function
    function findTheWinner(int n, int k) public pure returns (int) {
        int winner = 0; // Start with the base case
        for (int i = 2; i <= n; i++) {
            winner = (winner + k) % i;
        }
        return winner + 1; // Since the problem assumes 1-based indexing
    }
}
