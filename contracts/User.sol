pragma solidity ^0.4.15;
import "./WNS.sol";
import "./Owned.sol";

/**
 * @title Self-Sovereign Social Networking
 */
contract User is Owned {
    bytes32 private id;
    bytes32 private name;

    event LogDescription(string indexed description);
    event LogName(string indexed name);
    event LogImage(string indexed img);

    enum Status { unset, sent, received }

    mapping (bytes32 => User) public friends;
    mapping (bytes32 => Status) public pending;
    mapping (address => bool) private _permissioned;

    WNS wns = WNS(0x7502ab3685672f27412cfcc7a6dbe8bef8d9909d);

    /**
     * @dev Require that caller is permissioned or owner
     */
    modifier onlyPermissioned() {
        require(_permissioned[msg.sender] == true || owner == msg.sender);
        _;
    }

    /**
     * @dev Contract constructor instantiates user with owner
     * @param _id The WNS name that a user wants to register
     */
    function User(bytes32 _id) public {
        id = _id;
        wns.insert(this, _id);
    }

    /**
     * @dev Simply gets a user's name / WNS id
     */
    function getName() public constant returns (bytes32) {
        return name;
    }

    /**
     * @dev Simply gets a user's name / WNS id
     */
    function getId() public constant returns (bytes32) {
        return id;
    }

    /**
     * @dev Set user's name
     * @param _name The name that a user wants to set
     */
    function setName(bytes32 _name) public onlyOwner {
        name = _name;
    }

    /**
     * @dev Adds a friend to the contract from pending
     * @param friend The friend's id that we're adding from pending
     */
    function acceptFriend(bytes32 friend) public onlyPermissioned {
        require(pending[friend] == Status.received);
        friends[friend] = wns.get(friend);
    }

    /**
     * @dev Adds a friend to pending list
     * @param friend Id of a potential friend's contract
     * @notice gets foreign user contract from WNS
     */
    function addFriend(bytes32 friend) public onlyPermissioned {
        pending[friend] = Status.sent;
        require(wns.contains(friend));
        User u = wns.get(friend);
        u.addPending();
    }

    /**
     * @dev Removes a friend from friend's list
     * @param friend The id of a friend
     */
    function removeFriend(bytes32 friend) public onlyPermissioned {
        delete friends[friend];
    }

    /**
     * @dev Adds to a friend's pending list
     * @notice Queries the caller's contract
     */
    function confirm() public {
        User u = User(msg.sender);
        require(pending[u.getId()] == Status.sent);
        delete pending[u.getId()];
        friends[u.getId()] = u;
    }

    /**
     * @dev Adds to a friend's pending list
     * @notice Queries the caller's contract
     */
     function addPending() public {
        User u = User(msg.sender);
        pending[u.getId()] = Status.received;
     }

    /**
     * @dev Changes WNS to another address for private networks
     */
    function changeWNS(address addr) public onlyOwner {
        wns = WNS(addr);
    }

    /**
     * @dev Adds a permissioned address
     * @param addr Address that we want to permission
     */
    function addPermissioned(address addr) public onlyOwner {
        _permissioned[addr] = true;
    }

    /**
     * @dev Removes a permissioned address
     * @param addr Address that we want to remove as a permission
     */
    function removePermissioned(address addr) public onlyOwner {
        delete _permissioned[addr];
    }
}
