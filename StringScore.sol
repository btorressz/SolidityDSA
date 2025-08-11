// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StringScore {
    function calculateScore(string memory s) public pure returns (uint) {
        bytes memory b = bytes(s);
        uint score = 0;
        for (uint i = 1; i < b.length; i++) {
            // Correctly handle conversions and calculations
            int diff = int(uint8(b[i])) - int(uint8(b[i - 1]));
            score += abs(diff);
        }
        return score;
    }

    // Helper function to calculate the absolute value of an integer
    function abs(int x) private pure returns (uint) {
        if (x < 0) {
            return uint(-x);
        }
        return uint(x);
    }
}
