// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LeafNodePairs {
    struct TreeNode {
        uint value;
        uint left;   // index of the left child in the nodes array
        uint right;  // index of the right child in the nodes array
        bool exists; // to check if the node exists
    }

    TreeNode[] public nodes;
   // uint[] public leafDepths;
    uint[] leafDepths;


    constructor() {
        // Example to initialize a simple tree
        nodes.push(TreeNode(1, 1, 2, true)); // Root node
        nodes.push(TreeNode(2, 0, 0, true)); // Leaf node
        nodes.push(TreeNode(3, 3, 4, true)); // Internal node
        nodes.push(TreeNode(4, 0, 0, true)); // Leaf node
        nodes.push(TreeNode(5, 0, 0, true)); // Leaf node
    }

    // Add nodes manually to set up the tree for different test cases
    function addNode(uint _value, uint _left, uint _right) public {
        nodes.push(TreeNode(_value, _left, _right, true));
    }

    function findLeafNodePairs(uint rootIndex, uint distance) public returns (uint) {
   // leafDepths = new uint ;
    //leafDepths = new uint[]();
    uint[] memory leafDepths = new uint[](0);


    dfs(rootIndex, 0);
    return countGoodPairs(distance);
}


    function dfs(uint nodeIndex, uint depth) private {
        if (!nodes[nodeIndex].exists) return;

        TreeNode storage node = nodes[nodeIndex];

        // Check if it is a leaf node
        if (node.left == 0 && node.right == 0) {
            leafDepths.push(depth);
            return;
        }

        // Recursively visit children
        if (node.left != 0) dfs(node.left, depth + 1);
        if (node.right != 0) dfs(node.right, depth + 1);
    }

    function countGoodPairs(uint distance) private view returns (uint count) {
        count = 0;
        // Count pairs of leaf nodes where the path length is <= distance
        for (uint i = 0; i < leafDepths.length; i++) {
            for (uint j = i + 1; j < leafDepths.length; j++) {
                if (absDiff(leafDepths[i], leafDepths[j]) <= distance) {
                    count++;
                }
            }
        }
    }

    function absDiff(uint a, uint b) private pure returns (uint) {
        return a > b ? a - b : b - a;
    }
}
