// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ValidParentheses {
    function isValid(string memory s) public pure returns (bool) {
        bytes memory sBytes = bytes(s);
        bytes memory stack = new bytes(sBytes.length);
        uint top = 0;

        for (uint i = 0; i < sBytes.length; i++) {
            bytes1 char = sBytes[i];
            if (char == '(' || char == '{' || char == '[') {
                stack[top++] = char;
            } else {
                if (top == 0) return false;
                bytes1 lastOpen = stack[--top];
                if (char == ')' && lastOpen != '(') return false;
                if (char == '}' && lastOpen != '{') return false;
                if (char == ']' && lastOpen != '[') return false;
            }
        }
        return top == 0;
    }
}