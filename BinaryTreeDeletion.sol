// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BinaryTreeDeletion {
    struct Node {
        uint value;
        uint left;   // index of the left child
        uint right;  // index of the right child
        bool exists; // exists flag to handle deletion
    }

    Node[] public tree;
    uint public rootIndex = 0; // Default root index

    constructor(uint[] memory values, uint[] memory leftChildren, uint[] memory rightChildren) {
        require(values.length == leftChildren.length && values.length == rightChildren.length, "Invalid tree inputs");
        for (uint i = 0; i < values.length; i++) {
            tree.push(Node({
                value: values[i],
                left: leftChildren[i] != type(uint).max ? leftChildren[i] : type(uint).max,
                right: rightChildren[i] != type(uint).max ? rightChildren[i] : type(uint).max,
                exists: true
            }));
        }
    }

    // Function to remove all leaves with a given target value
    function deleteLeavesWithTarget(uint target) public {
        require(tree.length > 0, "Tree is empty");
        rootIndex = deleteRecursively(rootIndex, target);
    }

    // Recursive function to delete target leaves
    function deleteRecursively(uint index, uint target) private returns (uint) {
        if (index == type(uint).max || !tree[index].exists) return type(uint).max;

        // Recursively delete in children
        if (tree[index].left != type(uint).max) {
            tree[index].left = deleteRecursively(tree[index].left, target);
        }
        if (tree[index].right != type(uint).max) {
            tree[index].right = deleteRecursively(tree[index].right, target);
        }

        // Check if current node is a leaf and matches target
        if (tree[index].left == type(uint).max && tree[index].right == type(uint).max && tree[index].value == target) {
            tree[index].exists = false; // "Delete" this node
            return type(uint).max; // No valid child
        }
        return index;
    }

    // Function to display the tree values for verification
    function getTreeValues() public view returns (uint[] memory) {
        uint[] memory values = new uint[](tree.length);
        for (uint i = 0; i < tree.length; i++) {
            if (tree[i].exists) {
                values[i] = tree[i].value;
            } else {
                values[i] = 0; // Assuming 0 as deleted marker
            }
        }
        return values;
    }
}
