pragma solidity ^0.4.15;
import "./User.sol";

contract WNS {

    mapping (bytes32 => User) private userRegister;
    mapping (bytes32 => bool) private handleTracker;

    modifier userDoesNotExist(bytes32 userHandle) {
        require(!handleTracker[userHandle]);
        _;
    }

    modifier userExists(bytes32 userHandle) {
        require(handleTracker[userHandle]);
        _;
    }

    function insert(User newUser, bytes32 userHandle)
        public
        userDoesNotExist(userHandle)
    {
        handleTracker[userHandle] = true;
        userRegister[userHandle] = newUser;
    }

    function remove(bytes32 userHandle) 
        public
        userExists(userHandle)
    {
        // Remove the handle from the system
        handleTracker[userHandle] = false;
    }

    function contains(bytes32 userHandle)
        public
        returns (bool)
    {
        return handleTracker[userHandle];
    }
}
