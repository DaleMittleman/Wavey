pragma solidity ^0.4.15;

/// @title Self-Sovereign Social Networking
contract User {

    bytes32 private id;
    mapping (bytes32 => address) private friends;
    mapping (bytes32 => address) private received;
    mapping (address => bool) private _owners;

    /// @dev Contract constructor instantiates user with owner
    /// @param name The WNS name that a user wants to register
    function User(bytes32 name) public {
        id = name;
    }

    /// @dev Simply gets a user's name / WNS id
    function getName() public constant returns (bytes32) {
        return id;
    }

    /// @dev Adds a friend to the contract from pending
    /// @param fid The friend's id that we're adding from pending
    /// Note: You can be friends with somebody without reciprocation
    function addFriend(bytes32 fid) public {
        require(received[fid] != address(0));
        User u = User(received[fid]);
        friends[u.getName()] = received[fid];
        delete received[fid];
    }

    /// @dev Adds a friend to pending list
    /// @param fid Id of a potential friend's contract
    /// Note: Hooligans can send empty fid, or call this from a non-User
    ///  Note: Get contract addr from WNS instead of msg.sender later
    function request(bytes32 fid) public {
        require(fid != "");
        received[fid] = msg.sender;
    }
}
