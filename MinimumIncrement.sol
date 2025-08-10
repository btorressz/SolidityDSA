// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MinimumIncrement {
    function minIncrementForUnique(int[] memory nums) public pure returns (uint) {
        if (nums.length <= 1) return 0;
        
        quickSort(nums, 0, int(nums.length - 1));
        uint moves = 0;
        int prev = nums[0];

        for (uint i = 1; i < nums.length; i++) {
            if (nums[i] <= prev) {
                moves += uint(prev - nums[i] + 1);
                nums[i] = prev + 1;
            }
            prev = nums[i];
        }

        return moves;
    }

    // Quick sort implementation in Solidity
    function quickSort(int[] memory arr, int left, int right) internal pure {
        int i = left;
        int j = right;
        if (i == j) return;
        int pivot = arr[uint(left + (right - left) / 2)];
        while (i <= j) {
            while (arr[uint(i)] < pivot) i++;
            while (pivot < arr[uint(j)]) j--;
            if (i <= j) {
                (arr[uint(i)], arr[uint(j)]) = (arr[uint(j)], arr[uint(i)]);
                i++;
                j--;
            }
        }
        if (left < j)
            quickSort(arr, left, j);
        if (i < right)
            quickSort(arr, i, right);
    }
}
