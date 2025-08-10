// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract QueueUsingTwoStacks {
    uint[] private stackIn;
    uint[] private stackOut;

    // Enqueue an element to the queue
    function enqueue(uint _element) public {
        stackIn.push(_element);  // Push element to the inbound stack
    }

    // Dequeue an element from the queue
    function dequeue() public returns (uint) {
        if (stackOut.length == 0) {
            // Move all elements from stackIn to stackOut
            while (stackIn.length != 0) {
                // Pop from stackIn and push to stackOut to reverse the order
                stackOut.push(stackIn[stackIn.length - 1]);
                stackIn.pop();
            }
        }

        // Check if stackOut is still empty (means both stacks were empty)
        require(stackOut.length != 0, "Queue is empty");

        // Pop from stackOut to get the oldest element (front of the queue)
        uint element = stackOut[stackOut.length - 1];
        stackOut.pop();
        return element;
    }

    // Returns the front element of the queue without removing it
    function peek() public view returns (uint) {
        if (stackOut.length == 0) {
            require(stackIn.length != 0, "Queue is empty");  // Ensure there's at least one element
            return stackIn[0];  // The bottom element of stackIn is the front of the queue
        }
        return stackOut[stackOut.length - 1];  // The top element of stackOut is the front of the queue
    }

    // Returns the size of the queue
    function size() public view returns (uint) {
        return stackIn.length + stackOut.length;  // Total size is the sum of both stacks
    }

    // Checks if the queue is empty
    function isEmpty() public view returns (bool) {
        return stackIn.length == 0 && stackOut.length == 0;  // Queue is empty if both stacks are empty
    }
}
