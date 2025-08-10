// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ArrayTransformation {
    // Function to check if we can make `arr` equal to `target` by reversing subarrays.
    function canMakeEqual(int[] memory target, int[] memory arr) public pure returns (bool) {
        if (target.length != arr.length) {
            return false;
        }

        uint256 maxElementValue = 1000;  // Adjust this based on the maximum possible element value
        uint256[] memory countTarget = new uint256[](maxElementValue + 1);
        uint256[] memory countArr = new uint256[](maxElementValue + 1);

        // Count the frequency of each element in `target`
        for (uint i = 0; i < target.length; i++) {
            countTarget[uint(target[i])]++;  // Cast to uint because Solidity does not support negative array indices
        }

        // Count the frequency of each element in `arr`
        for (uint i = 0; i < arr.length; i++) {
            countArr[uint(arr[i])]++;
        }

        // Compare frequencies
        for (uint i = 1; i <= maxElementValue; i++) {  // Start from 1 if your elements are 1-indexed
            if (countTarget[i] != countArr[i]) {
                return false;
            }
        }

        return true;
    }
}
