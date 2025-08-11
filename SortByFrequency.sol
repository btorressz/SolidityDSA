// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SortByFrequency {
    function sortByFrequency(int[] memory nums) public pure returns (int[] memory) {
        mapping(int => uint) freq;
        for (uint i = 0; i < nums.length; i++) {
            freq[nums[i]]++;
        }
        
        for (uint i = 0; i < nums.length; i++) {
            for (uint j = i + 1; j < nums.length; j++) {
                if (freq[nums[i]] > freq[nums[j]] || (freq[nums[i]] == freq[nums[j]] && nums[i] < nums[j])) {
                    int temp = nums[i];
                    nums[i] = nums[j];
                    nums[j] = temp;
                }
            }
        }
        
        return nums;
    }
}
