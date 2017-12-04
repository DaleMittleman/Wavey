pragma solidity ^0.4.15;
import "./Service.sol";

/**
 * @title ServiceManager is a utility that creates and tracks Services
 */
contract ServiceManager {

    mapping (bytes32 => Service) private services;
    mapping (bytes32 => bool) private serviceNameTracker;

    /**
     * @dev Check that a service does not already exist
     * with the given name
     */
    modifier serviceDoesNotExist(bytes32 serviceName) {
        require(!serviceNameTracker[serviceName]);
        _;
    }

    /**
     * @dev Check that a service exists
     * with the given name.
     */
    modifier serviceExists(bytes32 serviceName) {
        require(serviceNameTracker[serviceName]);
        _;
    }

    /**
      * @dev Creates a service with the given name
      * @param serviceName The requested service name
      */
    function createService(bytes32 serviceName) public
        serviceDoesNotExist(serviceName)
    {
        Service service = new Service(serviceName);
        addService(serviceName, service);
    }

    /**
     * @dev Adds a service to the list
     * @param serviceName The name of the new service
     * @param service The Service contract just created
     */
    function addService(bytes32 serviceName, Service service) private
        serviceDoesNotExist(serviceName)
    {
        serviceNameTracker[serviceName] = true;
        services[serviceName] = service;
    }

    /**
     * @dev Removes a service from the list.
     * @param serviceName The name of the service to be removed.
     */
    function removeService(bytes32 serviceName) public
        serviceExists(serviceName)
    {
        serviceNameTracker[serviceName] = false;
    }

    /**
     * @dev Checks if a service exists
     * with the given name.
     */
    function hasService(bytes32 serviceName) public view
        returns (bool)
    {
        return serviceNameTracker[serviceName];
    }
}
