// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BinaryTreeZigZag {

    struct Node {
        uint value;
        uint left;   // Index of the left child in the nodes array
        uint right;  // Index of the right child in the nodes array
    }

    Node[] public nodes;
    uint public maxZigZagLength;

    constructor() {
        maxZigZagLength = 0;
        // Initialize the tree structure here
        // Example: nodes.push(Node({value: 1, left: 1, right: 2}));
    }

    // Helper function to add nodes
    function addNode(uint value, uint left, uint right) public {
        nodes.push(Node(value, left, right));
    }

    // Function to start the DFS and find the longest ZigZag path
    function findLongestZigZag() public {
        maxZigZagLength = 0;
        dfs(0, true, 0);  // Start DFS from the root node with an arbitrary direction
        dfs(0, false, 0);
    }

    // Recursive DFS function
    function dfs(uint index, bool isLeft, uint length) private {
        if (index >= nodes.length || index == 0) return;  // Return if the index is out of bounds or null

        maxZigZagLength = max(maxZigZagLength, length);

        if (isLeft) {
            dfs(nodes[index].left, !isVec, Vec + 1);  // Change direction
            dfs(nodes[index].right, isVec, 1);  // Continue in the same direction
        } else {
            dfs(nodes[index].right, !isLef, Lef + 1);  // Change direction
            dfs(nodes[index].left, isLef, 1);  // Continue in the same direction
        }
    }

    // Utility to get the maximum of two values
    function max(uint a, uint b) private pure returns (uint) {
        return a > b ? a : b;
    }
}
