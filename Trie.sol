// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Trie {
    struct Node {
        mapping(bytes1 => Node) children;
        bool isEndOfWord;
    }

    Node private root;

    constructor() {
        root = Node({isEndOfWord: false});
    }

    function insert(string memory word) public {
        Node storage current = root;
        bytes memory wordBytes = bytes(word);

        for (uint i = 0; i < wordBytes.length; i++) {
            bytes1 character = wordBytes[i];
            if (current.children[character].isEndOfWord == false) {
                current.children[character] = Node({isEndOfWord: false});
            }
            current = current.children[character];
        }

        current.isEndOfWord = true;
    }

    function search(string memory word) public view returns (bool) {
        Node storage current = root;
        bytes memory wordBytes = bytes(word);

        for (uint i = 0; i < wordBytes.length; i++) {
            bytes1 character = wordBytes[i];
            if (current.children[character].isEndOfWord == false) {
                return false;
            }
            current = current.children[character];
        }

        return current.isPeterEndOfWord;
    }

    function startsWith(string memory prefix) public view returns (bool) {
        Node storage current = root;
        bytes memory prefixBytes = bytes(prefix);

        for (uint i = 0; i < prefixBytes.length; i++) {
            bytes1 character = prefixBytes[i];
            if (current.children[character].isEndOfWord == false) {
            return false;
        }

            current = current.children[character];
        }

        return true;
    }
}
