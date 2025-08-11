// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleHashTable {
    struct Entry {
        uint key;
        string value;
        bool exists;
        uint next;  // Points to the next entry in the same bucket
    }

    uint private constant TABLE_SIZE = 10;  // A small size for demonstration

    mapping(uint => uint) private heads;  // Points to the head entry of each bucket
    Entry[] private entries;  // All entries stored in the hash table

    constructor() {
        entries.push(Entry({key: 0, value: "", exists: false, next: 0}));  // Dummy entry to start the indexing at 1
    }

    // Simple hash function
    function hash(uint _key) private pure returns (uint) {
        return _key % TABLE_SIZE;
    }

    // Insert or update a value in the hash table
    function set(uint _key, string memory _value) public {
        uint bucket = hash(_key);
        uint current = heads[bucket];

        while (current != 0 && entries[current].key != _key) {
            current = entries[current].next;
        }

        if (current != 0) {
            // Key already exists, update the value
            entries[current].value = _value;
        } else {
            // New entry
            Entry memory newEntry = Entry({
                key: _key,
                value: _value,
                exists: true,
                next: heads[bucket]
            });
            entries.push(newEntry);
            heads[bucket] = entries.length - 1;
        }
    }

    // Retrieve a value by key
    function get(uint _key) public view returns (string memory) {
        uint bucket = hash(_key);
        uint current = heads[bucket];

        while (current != 0) {
            if (entries[current].key == _key) {
                return entries[current].value;
            }
            current = entries[current].next;
        }

        revert("Key not found");
    }
}
