// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract InsertionSortt {
    // Function to perform insertion sort on an array of integers
    function insertionSort(uint[] memory arr) public pure returns (uint[] memory) {
        uint n = arr.length;
        for (uint i = 1; i < n; i++) {
            uint key = arr[i];
            uint j = i - 1;

            // Move elements of arr[0..i-1], that are greater than key, to one position ahead
            // of their current position
            while (j >= 0 && arr[j] > key) {
                arr[j + 1] = arr[j];
                if (j == 0) break; // Prevents underflow of uint
                j--;
            }
            arr[j + 1] = key;
        }
        return arr;
    }
}
