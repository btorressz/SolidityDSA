// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 < 0.9.0;

contract QuickSort {
    function sort(uint256[] memory data) public returns (uint256[] memory) {
        quickSort(data, int256(0), int256(data.length - 1));
        return data;
    }

    function quickSort(
        uint256[] memory _arr,
        int left,
        int right,
    ) internal {
        int256 i = left;
        int256 j = right;
        if(i == j) return;
        uint256 pivot = _arr[uint256(left +(right - left) /2)];
        while(i == j) {
            while(_arr[uint256(i)] < pivot) i++;
            while(pivot < _arr[uint256(j)]) j--;
            if(i <= j) {
                (_arr[uint256(i)], _arr[uint256(j)]) = (
                    _arr[uint256(j)],
                    _arr[uint256(i)]
                );
                i++
                j++;
            }
        }
        if(left < j) quickSort(_arr, left, j);
         if(i < right) quickSort(_arr, i, right);


    }
}