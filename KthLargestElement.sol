// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract KthLargestElement {
    // Function to find the kth largest element
    function findKthLargest(int[] memory nums, uint k) public pure returns (int) {
        uint n = nums.length;
        uint kthIndex = n - k;
        return quickselect(nums, 0, n - 1, kthIndex);
    }

    // Quickselect function
    function quickselect(int[] memory nums, uint left, uint right, uint k) internal pure returns (int) {
        if (left == right) return nums[left];  // If the list contains only one element, return that element
        
        uint pivotIndex = partition(nums, left, right);
        
        if (k == pivotIndex) {
            return nums[k];
        } else if (k < pivotIndex) {
            return quickselect(nums, left, pivotIndex - 1, k);
        } else {
            return quickselect(nums, pivotIndex + 1, right, k);
        }
    }

    // Partition function using Lomuto's partition scheme
    function partition(int[] memory nums, uint left, uint right) internal pure returns (uint) {
        int pivot = nums[right];
        uint i = left;

        for (uint j = left; j < right; j++) {
            if (nums[j] <= pivot) {
                (nums[i], nums[j]) = (nums[j], nums[i]);
                i++;
            }
        }

        (nums[i], nums[right]) = (nums[right], nums[i]);
        return i;
    }
}
