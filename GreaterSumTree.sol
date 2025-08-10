// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GreaterSumTree {
    struct Node {
        uint value;
        int left;  // Index of left child, -1 if none
        int right; // Index of right child, -1 if none
    }

    Node[] public nodes;

    // Constructor to initialize the BST
    constructor(uint[] memory values, int[] memory lefts, int[] memory rights) {
        for(uint i = 0; i < values.length; i++) {
            nodes.push(Node(values[i], lefts[i], rights[i]));
        }
    }

    // Function to convert BST to a Greater Sum Tree
    function toGreaterSumTree() public {
        uint totalSum = 0;
        _dfs(nodes.length - 1, totalSum);
    }

    // Helper function for DFS traversal and value updates
    function _dfs(int idx, uint acc) private returns (uint) {
        if (idx == -1) return acc;

        // Process right subtree
        uint newAcc = _dfs(nodes[uint(idx)].right, acc);

        // Update current node
        nodes[uint(idx)].value += newAcc;
        newAcc = nodes[uint(idx)].value;

        // Process left subtree
        return _dfs(nodes[uint(idx)].left, newAcc);
    }

    // Function to get the value of the node at index `idx`
    function getNodeValue(uint idx) public view returns (uint) {
        return nodes[idx].value;
    }
}
