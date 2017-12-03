pragma solidity ^0.4.15;

/**
 * @title Owned is a modifier to enforce permissions on contracts
 */
contract Owned {
    address owner;

    /**
     * @dev Set owner to contract initator
     */
    function Owned() public {
        owner = msg.sender;
    }

    /**
     * @dev Only allow owner to run certain functions
     */
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    /**
     * @dev Allow owner to transfer their ownership
     */
    function transfer(address addr) public onlyOwner {
        owner = addr;
    }
}
