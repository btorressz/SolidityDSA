// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract JumbledNumberSorter {
    struct NumberWithIndex {
        uint256 number;
        uint256 index;
        uint256 mappedValue;
    }

    function sortJumbledNumbers(uint256[10] memory mappingRule, uint256[] memory nums) public pure returns (uint256[] memory) {
        NumberWithIndex[] memory numbersWithIndices = new NumberWithIndex[](nums.length);

        // Calculate mapped values and store original indices
        for (uint256 i = 0; i < nums.length; i++) {
            numbersWithIndices[i] = NumberWithIndex(nums[i], i, mapNumber(mappingRule, nums[i]));
        }

        // Sort based on mapped values
        quickSort(numbersWithIndices, int256(0), int256(nums.length - 1));

        // Extract sorted numbers
        uint256[] memory sortedNums = new uint256[](nums.length);
        for (uint256 i = 0; i < nums.length; i++) {
            sortedNums[i] = numbersWithIndices[i].number;
        }

        return sortedNums;
    }

    function mapNumber(uint256[10] memory mappingRule, uint256 num) private pure returns (uint256) {
        if (num == 0) return mappingRule[0];
        
        uint256 mappedNum = 0;
        uint256 power = 1;
        
        while (num > 0) {
            uint256 digit = num % 10;
            mappedNum += mappingRule[digit] * power;
            power *= 10;
            num /= 10;
        }
        
        return mappedNum;
    }

    function quickSort(NumberWithIndex[] memory arr, int256 left, int256 right) private pure {
        if (left >= right) return;
        int256 pivotIndex = partition(arr, left, right);
        if (left < pivotIndex - 1) quickSort(arr, left, pivotIndex - 1);
        if (pivotIndex < right) quickSort(arr, pivotIndex, right);
    }

    function partition(NumberWithIndex[] memory arr, int256 left, int256 right) private pure returns (int256) {
        NumberWithIndex memory pivot = arr[uint256(left + (right - left) / 2)];
        while (left <= right) {
            while (compare(arr[uint256(left)], pivot) < 0) left++;
            while (compare(pivot, arr[uint256(right)]) < 0) right--;
            if (left <= right) {
                (arr[uint256(left)], arr[uint256(right)]) = (arr[uint256(right)], arr[uint256(left)]);
                left++;
                right--;
            }
        }
        return left;
    }

    function compare(NumberWithIndex memory a, NumberWithIndex memory b) private pure returns (int256) {
        if (a.mappedValue != b.mappedValue) {
            return a.mappedValue < b.mappedValue ? -1 : 1;
        }
        return a.index < b.index ? -1 : (a.index > b.index ? 1 : 0);
    }
}