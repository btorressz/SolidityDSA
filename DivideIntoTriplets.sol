// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/// @title 2966. Divide Array Into Arrays With Max Difference 
contract DivideIntoTriplets {
    function divideArray(int256[] memory nums, int256 k) external pure returns (int256[3][] memory) {
        uint256 n = nums.length;
        if (k < 0) return new int256[3][](0);
        if (n == 0) return new int256[3][](0);
        if (n % 3 != 0) return new int256[3][](0);

        _insertionSort(nums);

        uint256 m = n / 3;
        int256[3][] memory groups = new int256[3][](m);

        for (uint256 gi = 0; gi < m; gi++) {
            uint256 i = gi * 3;
            int256 a = nums[i];
            int256 b = nums[i + 1];
            int256 c = nums[i + 2];

            if (c - a > k) {
                // not possible
                return new int256[3][](0);
            }

            groups[gi][0] = a;
            groups[gi][1] = b;
            groups[gi][2] = c;
        }

        return groups;
    }

    function _insertionSort(int256[] memory a) internal pure {
        uint256 n = a.length;
        for (uint256 i = 1; i < n; i++) {
            int256 key = a[i];
            uint256 j = i;
            while (j > 0 && a[j - 1] > key) {
                a[j] = a[j - 1];
                unchecked { j--; }
            }
            a[j] = key;
        }
    }
}
