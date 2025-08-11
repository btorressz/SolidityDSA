// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleLinkedList {
    struct Node {
        uint data;
        uint next;
        bool exists;
    }

    uint public head = 0;  // Index of the head node
    uint public size = 0;  // Total number of nodes in the list

    mapping(uint => Node) public nodes;  // Mapping to store nodes

    // Adds a new node with the specified data at the head of the list
    function add(uint _data) public {
        uint newIndex = size + 1;  // Determine new node's index
        nodes[newIndex] = Node(_data, head, true);  // Create the new node, pointing to the old head
        head = newIndex;  // Update head to the new index
        size++;  // Increase the size of the list
    }

    // Returns the data of all nodes in the list, starting from the head
    function getNodes() public view returns (uint[] memory) {
        uint[] memory result = new uint[](size);  // Array to store node data
        uint current = head;  // Start at the head of the list

        for (uint i = 0; i < size; i++) {
            Node storage node = nodes[current];  // Retrieve the node from mapping
            result[i] = node.data;  // Store node data in the result array
            current = node.next;  // Move to the next node
        }

        return result;  // Return the array of data
    }
}
