// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract InversionCount {
    // Function to count inversions in the array
    function countInversions(int[] memory data) public pure returns (uint) {
        if (data.length < 2) {
            return 0;
        }
        uint[] memory aux = new uint[](data.length);
        return mergeSortAndCount(data, aux, 0, int(data.length - 1));
    }

    // Helper function to perform merge sort and count inversions
    function mergeSortAndCount(int[] memory arr, uint[] memory aux, int left, int right) internal pure returns (uint) {
        uint inversions = 0;
        if (left < right) {
            int mid = left + (right - left) / 2;
            inversions += mergeSortAndCount(arr, aux, left, mid);
            inversions += mergeSortAndCount(arr, aux, mid + 1, right);
            inversions += merge(arr, aux, left, mid, right);
        }
        return inversions;
    }

    // Helper function to merge two halves and count inversions
    function merge(int[] memory arr, uint[] memory aux, int left, int mid, int right) internal pure returns (uint) {
        for (int i = left; i <= right; i++) {
            aux[uint(i)] = uint(arr[uint(i)]);
        }
        int i = left;
        int j = mid + 1;
        uint inversions = 0;

        for (int k = left; k <= right; k++) {
            if (i > mid) {
                arr[uint(k)] = int(aux[uint(j++)]);
            } else if (j > right) {
                arr[uint(k)] = int(aux[uint(i++)]);
            } else if (aux[uint(i)] <= aux[uint(j)]) {
                arr[uint(k)] = int(aux[uint(i++)]);
            } else {
                arr[uint(k)] = int(aux[uint(j++)]);
                inversions += uint(mid - i + 1); // Count inversions
            }
        }
        return inversions;
    }
}