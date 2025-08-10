// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LinearSearch {
    // Function to perform linear search on an array of integers
    function linearSearch(uint[] memory data, uint target) public pure returns (int) {
        for (uint i = 0; i < data.length; i++) {
            if (data[i] == target) {
                return int(i); // Return the index of the target if found
            }
        }
        return -1; // Return -1 if the target is not found
    }
}
