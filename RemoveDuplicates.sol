// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RemoveDuplicates {
    // Function to remove duplicates from a sorted array
    function removeDuplicates(int[] memory data) public pure returns (uint newLength) {
        if (data.length == 0) {
            return 0;
        }

        uint j = 0; // Index of the last unique element in the array
        for (uint i = 1; i < data.length; i++) {
            if (data[j] != data[i]) {
                j++;
                data[j] = data[i]; // Copy the next unique element to the position j+1
            }
        }

        newLength = j + 1; // Length of array with no duplicates
        return newLength;
    }
}
