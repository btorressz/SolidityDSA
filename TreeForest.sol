// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TreeForest {
    struct TreeNode {
        uint value;
        uint left;
        uint right;
        uint parent; // 0 if it's the root
        bool exists; // To check if the node still exists in the mapping
    }

    mapping(uint => TreeNode) public tree;
    uint[] public roots;
    mapping(uint => bool) private toDelete;

    // Example initialization (can be modified as needed)
    constructor() {
        // Construct the tree as per the problem's example
        tree[1] = TreeNode(1, 2, 3, 0, true);
        tree[2] = TreeNode(2, 4, 5, 1, true);
        tree[3] = TreeNode(3, 6, 7, 1, true);
        tree[4] = TreeNode(4, 0, 0, 2, true);
        tree[5] = TreeNode(5, 0, 0, 2, true);
        tree[6] = TreeNode(6, 0, 0, 3, true);
        tree[7] = TreeNode(7, 0, 0, 3, true);
    }

    function deleteNodesAndReturnForest(uint[] memory _toDelete) public {
        // Mark nodes for deletion
        for (uint i = 0; i < _toDelete.length; i++) {
            toDelete[_toDelete[i]] = true;
        }

        // Recursively delete nodes and find new roots
        if (!toDelete[1]) { // Checking if the root itself is not to be deleted
            if (dfs(1)) roots.push(1);
        }

        // Outputs the remaining tree roots (not in any specific order)
        for (uint i = 0; i < roots.length; i++) {
            // Each root would start a new tree in a real implementation
            emit LogRoot(roots[i]);
        }
    }

    // Depth-first search to handle deletions
    function dfs(uint node) private returns (bool) {
        if (node == 0) return false;
        TreeNode storage currentNode = tree[node];

        bool isRoot = currentNode.parent == 0 || toDelete[currentNode.parent];
        bool leftExists = dfs(currentNode.left);
        bool rightExists = dfs(currentNode.right);

        if (toDelete[node]) {
            // Delete the node
            currentNode.exists = false;
            if (leftExists) roots.push(currentNode.left);
            if (rightExists) roots.push(currentNode.right);
            return false;
        } else {
            // Update children pointers if necessary
            return true;
        }
    }

    event LogRoot(uint root);
}
