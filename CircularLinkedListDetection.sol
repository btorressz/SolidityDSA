// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CircularLinkedListDetection {
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

    // Function to check for a cycle in the list
    function detectCycle() public view returns (bool) {
        if (size == 0) return false;  // Empty list cannot have a cycle

        uint slow = head;
        uint fast = head;

        while (nodes[fast].exists && nodes[nodes[fast].next].exists) {
            slow = nodes[slow].next;  // Move slow by 1 step
            fast = nodes[nodes[fast].next].next;  // Move fast by 2 steps

            if (slow == fast) {
                return true;  // Cycle detected
            }
        }

        return false;  // No cycle found
    }
}
