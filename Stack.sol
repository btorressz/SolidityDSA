// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Stack {
    uint[] private stack;
    uint private top = 0;  // This will also serve as the size of the stack

    // Pushes a new element to the top of the stack
    function push(uint _element) public {
        stack.push(_element);
        top++;  // Increase the top index
    }

    // Removes the top element from the stack
    function pop() public {
        require(top != 0, "Stack is empty");
        stack.pop();
        top--;  // Decrease the top index
    }

    // Returns the top element of the stack without removing it
    function peek() public view returns (uint) {
        require(top != 0, "Stack is empty");
        return stack[top - 1];  // Array is 0-indexed, so top-1 gives the top element
    }

    // Returns the current size of the stack
    function size() public view returns (uint) {
        return top;
    }

    // Checks if the stack is empty
    function isEmpty() public view returns (bool) {
        return top == 0;
    }
}
