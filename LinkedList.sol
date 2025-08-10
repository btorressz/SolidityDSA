// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LinkedList {
    struct Node {
        uint data;
        uint next;
        bool exists;
    }

    mapping(uint => Node) public nodes;
    uint public head;
    uint public length;

    constructor() {
        head = 0;
        length = 0;
    }

    // Function to add elements at the beginning of the linked list
    function add(uint _data) public {
        Node memory newNode = Node({data: _data, next: head, exists: true});
        nodes[length + 1] = newNode;
        head = length + 1;
        length++;
    }

    // Function to reverse the linked list
    function reverse() public {
        uint current = head;
        uint prev = 0;
        uint next;

        while (current != 0) {
            Node storage currentNode = nodes[current];
            next = currentNode.next;

            if (prev == 0) {
                currentNode.next = 0;
            } else {
                currentNode.next = prev;
            }

            prev = current;
            current = next;
        }
        head = prev;
    }

    // Function to get all elements of the linked list in array format
    function getElements() public view returns (uint[] memory) {
        uint[] memory elements = new uint[](length);
        uint current = head;
        for (uint i = 0; i < length; i++) {
            Node storage node = nodes[current];
            elements[i] = node.data;
            current = node.next;
        }
        return elements;
    }
}
