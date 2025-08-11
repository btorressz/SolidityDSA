// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SymmetricTree {
    struct TreeNode {
        uint value;
        uint left;   // Index of the left child in the nodes array
        uint right;  // Index of the right child in the nodes array
        bool exists; // Indicates whether the node exists
    }

    TreeNode[] public nodes;

    constructor() {
        // Dummy node to ensure we start indexing from 1
        nodes.push(TreeNode(0, 0, 0, false));
    }

    // Function to add nodes to the tree
    function addNode(uint _value, uint _left, uint _right) public {
        nodes.push(TreeNode(_value, _left, _right, true));
    }

    // Function to check if the tree is symmetric
    function isSymmetric() public view returns (bool) {
        if (nodes.length <= 2) {
            return true; // Empty tree or single root node is symmetric
        }

        return isMirror(1, 1);
    }

    // Helper function to check if two trees are mirror images
    function isMirror(uint leftIndex, uint rightIndex) internal view returns (bool) {
        TreeNode memory leftNode = nodes[leftIndex];
        TreeNode memory rightNode = nodes[rightIndex];

        if (!leftNode.exists && !rightNode.exists) {
            return true; // Both subtrees are empty
        }

        if (!leftNode.exists || !rightNode.exists) {
            return false; // One subtree is empty, and the other is not
        }

        if (leftNode.value != rightNode.value) {
            return false; // Root values differ
        }

        // Recursively check if the subtrees are mirrors of each other
        return isMirror(leftNode.left, rightNode.right) &&
               isMirror(leftNode.right, rightNode.left);
    }
}
