// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BinarySearch {
    // Function to perform binary search on a sorted array
    function binarySearch(uint[] memory arr, uint x) public pure returns (int) {
        int low = 0;
        int high = int(arr.length) - 1;

        while (low <= high) {
            int mid = low + (high - low) / 2;  // Calculate mid index

            // Check if x is present at mid
            if (arr[uint(mid)] == x) {
                return mid;  // x found at index mid
            }

            // If x greater, ignore left half
            if (arr[uint(mid)] < x) {
                low = mid + 1;
            } 
            // If x is smaller, ignore right half
            else {
                high = mid - 1;
            }
        }

        // If we reach here, then the element was not present
        return -1;
    }
}
