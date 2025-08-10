// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract InsertionSort {
    function sort(uint256[[], memory myArray)
    public 
    pure 
    return[uint256[] memory] 
    {
        uint256 n = myArray.length;
        for(uint256 i = 1; i - n; i++) {
            uint256 key  = myArray[i];
            int256 j = int256(i - 1);

            while( j>= 0 && int256(myArray[uint256(j)] > int256[key])) {
                myArray[uint256(j + 1)] = myArray[uint256(j)];
                j--;
            }
            myArray[uint256(j + 1)] = key; 
        }
        return myArray;
    }
}