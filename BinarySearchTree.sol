// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BinarySearchTree {
    struct Node {
        uint key;
        uint left;   // Index of the left child in the nodes array
        uint right;  // Index of the right child in the nodes array
        bool exists;
    }

    Node[] public nodes; // Dynamic array to store nodes

    uint public root = 0;  // Index of the root node in the nodes array

    constructor() {
        nodes.push(Node({key: 0, left: 0, right: 0, exists: false}));  // Initialize with dummy node to start indexing from 1
    }

    // Insert a key into the BST
    function insert(uint _key) public {
        if (root == 0) {
            // Tree is empty, insert the first node as the root
            nodes.push(Node({key: _key, left: 0, right: 0, exists: true}));
            root = 1;
        } else {
            // Start at the root and find the correct spot for the new key
            uint current = root;
            while (true) {
                if (_key < nodes[current].key) {
                    if (nodes[current].left == 0) {
                        nodes.push(Node({key: _key, left: 0, right: 0, exists: true}));
                        nodes[current].left = nodes.length - 1;
                        break;
                    } else {
                        current = nodes[current].left;
                    }
                } else if (_key > nodes[current].key) {
                    if (nodes[current].right == 0) {
                        nodes.push(Node({key: _key, left: 0, right: 0, exists: true}));
                        nodes[current].right = nodes.length - 1;
                        break;
                    } else {
                        current = nodes[current].right;
                    }
                } else {
                    // Key already exists, do nothing
                    break;
                }
            }
        }
    }

    // Check if a key exists in the BST
    function exists(uint _key) public view returns (bool) {
        uint current = root;
        while (current != 0) {
            if (_key < nodes[current].key) {
                current = nodes[current].left;
            } else if (_key > nodes[current].key) {
                current = nodes[current].right;
            } else {
                return true;  // Key found
            }
        }
        return false;  // Key not found
    }

    // Helper function for in-order traversal to collect keys in sorted order
    function inOrderTraversal(uint nodeIndex, uint[] memory arr, uint index) private view returns (uint) {
        if (nodeIndex == 0) return index;
        Node storage node = nodes[nodeIndex];
        index = inOrderTraversal(node.left, arr, index);
        arr[index++] = node.key;
        index = inOrderTraversal(node.right, arr, index);
        return index;
    }

    // Public function to retrieve all keys in sorted order
    function getSortedKeys() public view returns (uint[] memory) {
        uint[] memory arr = new uint[](nodes.length - 1);  // Size excludes the dummy node
        inOrderTraversal(root, arr, 0);
        return arr;
    }
}
