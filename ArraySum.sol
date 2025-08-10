// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ArraySum {
    // Function to calculate the sum of an array of integers
    function sumArray(uint[] memory data) public pure returns (uint) {
        uint total = 0;
        for (uint i = 0; i < data.length; i++) {
            total += data[i];
        }
        return total;
    }
}
