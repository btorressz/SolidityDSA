// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MergeSort {
    // Function to sort an array using MergeSort algorithm
    function mergeSort(uint[] memory array) public pure returns (uint[] memory) {
        if (array.length <= 1) {
            return array;
        }

        uint middle = array.length / 2;
        uint[] memory left = new uint[](middle);
        uint[] memory right = new uint[](array.length - middle);

        for (uint i = 0; i < middle; i++) {
            left[i] = array[i];
        }
        for (uint i = middle; i < array.length; i++) {
            right[i - middle] = array[i];
        }

        mergeSort(left);
        mergeSort(right);
        merge(array, left, right);

        return array;
    }

    // Helper function to merge two halves
    function merge(uint[] memory array, uint[] memory left, uint[] memory right) internal pure {
        uint i = 0;
        uint j = 0;
        uint k = 0;

        while (i < left.length && j < right.length) {
            if (left[i] <= right[j]) {
                array[k] = left[i];
                i++;
            } else {
                array[k] = right[j];
                j++;
            }
            k++;
        }

        // Copy the remaining elements of left, if any
        while (i < left.length) {
            array[k] = left[i];
            i++;
            k++;
        }

        // Copy the remaining elements of right, if any
        while (j < right.length) {
            array[k] = right[j];
            j++;
            k++;
        }
    }
}
