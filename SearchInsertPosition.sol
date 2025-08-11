// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SearchInsertPosition {
    function searchInsert(int[] memory nums, int target) public pure returns (int) {
        uint low = 0;
        uint high = nums.length;
        while (low < high) {
            uint mid = low + (high - low) / 2;
            if (nums[mid] < target) {
                low = mid + 1;
            } else {
                high = mid;
            }
        }
        return int(low);
    }
}
