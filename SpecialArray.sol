// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SpecialArray {
    function findSpecialValue(int[] memory nums) public pure returns (int) {
        uint n = nums.length;
        int[] memory sortedNums = sort(nums);

        for (uint x = 0; x <= n; x++) {
            uint count = countGreaterOrEqual(sortedNums, int(x));
            if (count == x) {
                return int(x);
            }
        }

        return -1;
    }

    // Helper function to sort an array (using a simple insertion sort for demonstration purposes)
    function sort(int[] memory data) private pure returns (int[] memory) {
        int length = int(data.length);
        for (int i = 1; i < length; i++) {
            int key = data[uint(i)];
            int j = i - 1;
            while (j >= 0 && data[uint(j)] > key) {
                data[uint(j + 1)] = data[uint(j)];
                j = j - 1;
            }
            data[uint(j + 1)] = key;
        }
        return data;
    }

    // Count elements greater than or equal to x
    function countGreaterOrEqual(int[] memory sortedNums, int x) private pure returns (uint) {
        uint low = 0;
        uint high = sortedNums.length;
        while (low < high) {
            uint mid = low + (high - low) / 2;
            if (sortedNums[mid] >= x) {
                high = mid;
            } else {
                low = mid + 1;
            }
        }
        return sortedNums.length - low; // Number of elements >= x
    }
}
