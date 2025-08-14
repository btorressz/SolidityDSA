// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/// @title Partition Array Such That Maximum Difference Is K
contract PartitionArray {
    /// @notice Returns the minimum number of groups so that in each group
    /// the max difference between any element and the group's min is <= k.
    /// @dev Mirrors:
    ///   1) sort(nums)
    ///   2) count = 1; min = nums[0]
    ///   3) for each num: if num - min > k => ++count, min = num
    /// @param nums Array of integers (can be negative)
    /// @param k Allowed max difference within a group (must be >= 0)
    function partitionArray(int256[] memory nums, int256 k) external pure returns (uint256) {
        uint256 n = nums.length;
        if (n == 0) return 0;
        require(k >= 0, "k must be non-negative");

        _insertionSort(nums);

        uint256 count = 1;           // at least one group when n > 0
        int256 currentMin = nums[0];

        for (uint256 i = 1; i < n; i++) {
            // if nums[i] - currentMin > k => start a new group
            if (nums[i] - currentMin > k) {
                unchecked { count++; }
                currentMin = nums[i];
            }
        }

        return count;
    }

    /// @dev Simple in-place insertion sort (ascending). O(n^2) but compact and gas-friendly for small arrays.
    function _insertionSort(int256[] memory a) internal pure {
        uint256 n = a.length;
        for (uint256 i = 1; i < n; i++) {
            int256 key = a[i];
            uint256 j = i;
            // Move elements of a[0..i-1] that are > key to one position ahead
            while (j > 0 && a[j - 1] > key) {
                a[j] = a[j - 1];
                unchecked { j--; }
            }
            a[j] = key;
        }
    }
}
