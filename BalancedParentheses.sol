// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BalancedParentheses {
    // Function to check if the parentheses in the input string are balanced
    function isBalanced(string memory expression) public pure returns (bool) {
        bytes memory stack = new bytes(bytes(expression).length);
        uint top = 0;

        for (uint i = 0; i < bytes(expression).length; i++) {
            bytes1 char = bytes(expression)[i];

            
            // Push to stack if the character is an opening parenthesis
            if (char == '(') {
                stack[top++] = char;
            }
            // Check for balancing closing parenthesis
            else if (char == ')') {
                if (top == 0) {
                    // If stack is empty, it's an unbalanced expression
                    return false;
                }
                // Pop from stack if there is a matching opening parenthesis
                top--;
            }
        }

        // If stack is empty, all opening parentheses had matching closing ones
        return top == 0;
    }
}