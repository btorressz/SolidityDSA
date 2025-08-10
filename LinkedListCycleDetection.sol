pragma solidity ^0.8.0;

contract LinkedListCycleDetection {
    struct Node {
        int data;
        bool exists;
    }

    mapping (uint => Node) public nextNode; 
    Node public head;

    function insertNode(int _data) public {
        Node memory newNode = Node(_data, true);
        if (head.exists == false) {
            head = newNode;
        } else {
            nextNode[uint(newNode.data)] = newNode; // Use data field as the key
            head = newNode;
        }
    }

    function detectCycle() public view returns (bool) {
        Node memory slow = head;
        Node memory fast = head;

        while (fast.exists && nextNode[uint(fast.data)].exists) {
            slow = nextNode[uint(slow.data)];
            fast = nextNode[uint(nextNode[uint(fast.data)].data)];

            if (slow.data == fast.data) {
                return true;
            }
        }
        return false;
    }
}