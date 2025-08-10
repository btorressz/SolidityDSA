// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract QuickSrt {
    // Public function to perform QuickSort on an array
    function quickSort(uint[] memory arr, int left, int right) public pure {
        if (left < right) {
            int partitionIndex = partition(arr, left, right); // Index of the pivot after partitioning
            quickSort(arr, left, partitionIndex - 1);  // Sort the left sub-array
            quickSort(arr, partitionIndex + 1, right); // Sort the right sub-array
        }
    }

    // Helper function to perform the partition step of QuickSort
    function partition(uint[] memory arr, int left, int right) internal pure returns (int) {
        uint pivot = arr[uint(right)];  // Pivot element is chosen to be the rightmost element
        int i = left - 1;  // Index of the smaller element

        for (int j = left; j < right; j++) {
            if (arr[uint(j)] <= pivot) {
                i++;  // Increment index of the smaller element
                (arr[uint(i)], arr[uint(j)]) = (arr[uint(j)], arr[uint(i)]);  // Swap arr[i] and arr[j]
            }
        }
        (arr[uint(i + 1)], arr[uint(right)]) = (arr[uint(right)], arr[uint(i + 1)]);  // Swap arr[i + 1] and arr[right] (or pivot)
        return i + 1;  // Return the partition index
    }
}
