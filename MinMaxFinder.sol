// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MinMaxFinder {
    // Function to find the minimum and maximum values in an array of integers
    function findMinMax(uint[] memory data) public pure returns (uint min, uint max) {
        require(data.length > 0, "Array cannot be empty");

        min = data[0];
        max = data[0];

        for (uint i = 1; i < data.length; i++) {
            if (data[i] < min) {
                min = data[i];
            }
            if (data[i] > max) {
                max = data[i];
            }
        }

        return (min, max);
    }
}
