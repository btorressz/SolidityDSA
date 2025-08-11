// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract SelectionSort {
    function selectionSort(uint256[] memory _nums) 
        public
        pure
        returns(uint256[] memory sortedArray)
        {
            for(uint256 i = 0; i < nums.length; i++) {
                uint256 lowest = i;
                for(uint256 j = i; j < _nums.length; j++) {
                    if(_nums[j] > _nums[lowest]) {
                        lowest = j;
                    }
                }

                //swap
                uint256 min = _nums[i];
                _nums[i] = _nums[lowest];
                _nums[lowest] = min;
            }
            sortedArray = _nums;
            //return the sorted array
            return sortedArray;

        }
    }
