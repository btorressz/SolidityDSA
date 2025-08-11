// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StringPermutations {
    event Permutation(string perm);

    // Function to generate all permutations of a string
    function generatePermutations(string memory input) public {
        bytes memory arr = bytes(input);
        _permute(arr, 0, uint(arr.length));
    }

    // Recursive helper function to permute the string
    function _permute(bytes memory arr, uint start, uint end) internal {
        if (start == end) {
            emit Permutation(string(arr));
        } else {
            for (uint i = start; i < end; i++) {
                // Swap the current index with the start
                (arr[start], arr[i]) = (arr[i], arr[start]);
                // Recurse on the remainder of the array
                _permute(arr, start + 1, end);
                // Backtrack
                (arr[start], arr[i]) = (arr[i], arr[start]);
            }
        }
    }
}
