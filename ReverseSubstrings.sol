// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ReverseSubstrings {
    function reverseParentheses(string memory s) public pure returns (string memory) {
        bytes memory input = bytes(s);
        uint256[] memory stack = new uint256[](input.length);
        uint top = 0;

        for (uint i = 0; i < input.length; i++) {
            if (input[i] == '(') {
                stack[top++] = i;
            } else if (input[i] == ')') {
                reverse(input, stack[--top], i);
            }
        }

        bytes memory result = new bytes(input.length);
        uint index = 0;
        for (uint i = 0; i < input.length; i++) {
            if (input[i] != '(' && input[i] != ')') {
                result[index++] = input[i];
            }
        }

        return string(result);
    }

    function reverse(bytes memory arr, uint start, uint end) private pure {
        while (start < end) {
            (arr[start], arr[end]) = (arr[end], arr[start]);
            start++;
            end--;
        }
    }
}
