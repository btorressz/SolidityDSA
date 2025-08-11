// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TopKFrequentElements {
    struct Element {
        uint num;
        uint count;
    }

    mapping(uint => uint) private freq; // Frequency mapping declared at the contract level

    // Function to return the k most frequent elements from the given array
    function topKFrequent(uint[] memory nums, uint k) public returns (uint[] memory) {
        uint n = nums.length;

        // Reset frequency mapping
        for (uint i = 0; i < n; i++) {
            freq[nums[i]] = 0;
        }

        // Populate frequency mapping
        for (uint i = 0; i < n; i++) {
            freq[nums[i]]++;
        }

        // Prepare an array of elements to perform a simple frequency-based extraction
        Element[] memory elements = new Element[](n);
        uint uniqueCount = 0;

        // Transfer from mapping to array for sorting
        for (uint i = 0; i < n; i++) {
            if (freq[nums[i]] != 0) {
                elements[uniqueCount] = Element(nums[i], freq[nums[i]]);
                freq[nums[i]] = 0; // Set frequency to zero to avoid duplication
                uniqueCount++;
            }
        }

        // Sort elements by frequency
        quickSort(elements, 0, int(uniqueCount - 1));

        // Collect the top k elements
        uint[] memory topK = new uint[](k);
        for (uint i = 0; i < k; i++) {
            topK[i] = elements[i].num;
        }

        return topK;
    }

    // Helper function to perform a quick sort on the array of elements
    function quickSort(Element[] memory arr, int left, int right) internal pure {
        int i = left;
        int j = right;
        if (i == j) return;
        uint pivot = arr[uint(left + (right - left) / 2)].count;
        while (i <= j) {
            while (arr[uint(i)].count > pivot) i++;
            while (pivot > arr[uint(j)].count) j--;
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
