// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DoubleLinkedList {
    struct Node {
        uint val;
        uint next; // Reference to the next node's index
    }

    Node[] nodes;
    uint head;

    // Function to double the linked list
    function doubleLinkedList() public {
        uint current = head;
        uint carry = 0;

        while (current != 0) {
            uint doubledValue = nodes[current].val * 2 + carry;
            carry = doubledValue / 10;
            nodes[current].val = doubledValue % 10;
            if (nodes[current].next == 0 && carry > 0) {
                nodes[current].next = nodes.length;
                nodes.push(Node(carry, 0));
                break;
            }
            current = nodes[current].next;
        }
    }

    // Function to add nodes to the linked list for testing
    function addNode(uint value) public {
        nodes.push(Node(value, head));
        head = nodes.length - 1;
    }

    // Function to get the linked list values for verification
    function getList() public view returns (uint[] memory) {
        uint count = 0;
        uint current = head;
        while (current != 0) {
            count++;
            current = nodes[current].next;
        }

        uint[] memory values = new uint[](count);
        current = head;
        for (uint i = 0; i < count; i++) {
            values[i] = nodes[current].val;
            current = nodes[current].next;
        }
        return values;
  
    }
}