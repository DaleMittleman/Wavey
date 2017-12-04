pragma solidity ^0.4.15;
import "./User.sol";
import "./Owned.sol";
import "./WNS.sol";
import "./ServiceManager.sol";

/**
 * @title Service is a utility that leverages the friend network
 */
contract Service is Owned {

    uint public reputation;
    bytes32 public serviceName;

    WNS wns = WNS(0x1975e32D4F00F662F92617B1d746f7C2D2009f59);
    ServiceManager sm = ServiceManager(0xdD870fA1b7C4700F2BD7f44238821C26f7392148);

    event LogServiceCreated(
        bytes32 serviceName,
        address owner);

    event LogServiceKilled(
        bytes32 serviceName,
        address killer);

    /**
     * @dev Create a service with a given name
     * @param name The name of the service
     */
    function Service(bytes32 name) public {
        serviceName = name;
        reputation = 0;
        LogServiceCreated(name, msg.sender);
    }

    /**
     * @dev Adds a user onto the network
     * @param newUserHandle The desired handle for the new user
     * Note: Ownership of this user will belong to the service
     */
    function createUser(bytes32 newUserHandle) public {
        // Make sure the handle is novel
        require(!wns.contains(newUserHandle));

        // Create a new user, add it to WNS
        User newUser = new User(newUserHandle);
        wns.insert(newUser, newUserHandle);

        reputation += 1;
    }

    /**
     * @dev Kill the service, remove it from the ServiceManager
     */
    function killService() public
        onlyOwner
    {
        sm.removeService(serviceName);
        LogServiceKilled(serviceName, msg.sender);
    }
}
