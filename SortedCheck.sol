// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SortedCheck {
    // Function to check if an array of integers is sorted in ascending order
    function isSorted(uint[] memory data) public pure returns (bool) {
        for (uint i = 0; i < data.length - 1; i++) { // Notice the data.length - 1
            if (data[i] > data[i + 1]) {
                return false; // If any element is greater than the next, the array is not sorted
            }
        }
        return true; // If no unsorted pair found, the array is sorted
    }
}
