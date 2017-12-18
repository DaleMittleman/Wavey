# Wavey
A decentralized social network.  For the best explanation of our work, please read [our whitepaper]().  Below is just a summary.

### Context
#### Self-Sovereign Social Networking
With this project, we aim to tackle a handful of the problems that exist as a result of the current social networking landscape.

Among these problems are 
* Repetitive username / password validation
* Repetitive social networking features
* Authentication through centralized services

Blockchains can represent a better solution to user authentication.  By introducing public and private keys for each user in a trust-less, decentralized system, blockchains can introduce *self-sovereign identity*, where each user has full control over their own identity.  

Other services that have realized self-sovereign identity have decoupled the featur of digital identity management from the utility of a service for which one would need a digital identity.  Without such a service, it is undesirable to use such a system.

#### Smart Contract Development
Development of decentralized applications ('Dapp's) has been made simpler via the rise of Ethereum, and by extension, smart contracts.  Smart contracts provide a means to create apps with little infrastructure overhead and large-scale accessibility.  Availability of contracts makes them a viable option for standardization of functionality traditionality taken on by centralized services.

You can read more about smart contracts [here](http://solidity.readthedocs.io/en/develop/introduction-to-smart-contracts.html).

### Introduction to Wavey
Wavey is a social network built on the Ethereum blockchain that provides self-sovereign digital identity, and leverages smart contracts to broker peer to peer communication channels between its users.

The wavey system in composed a Etheruem smart contracts, a web client, and libraries for developers to integrate connectivity into their apps.

### Use Cases
Decentralized app, or Dapps, have a sizable barrier to entry.  A developer must first download an Ethereum light clien, or a chrome extension like [Metamask](https://metamask.io/).  In order to interact with Dapps that they write as well as Dapps that already exist, they will want to understand how gas and fees work.  For a new user, there is a steep learning curve.

Our goal with this project is to provide a means of abstraction for Dapp developers.  By leveraging the social network that Wavey provides, apps could provide interfaces through which regular users could interact with Dapps without having to overcome the hurdles that come with working with Ethereum.

## The Code
#### [Owned](https://github.com/DaleMittleman/Wavey/blob/master/contracts/Owned.sol)
We needed an interface that mimicked the Proxy contracts that exists within the Uport project.  Handles ownership of Users and Services.

#### [User](https://github.com/DaleMittleman/Wavey/blob/master/contracts/User.sol)
The User contract is the heart of the Wavey architecture.  

The contract handles all interacts between Users that exist within standard social networks.  A User can follow friends, accept followings from other Users, and add permissioned users to the account.

Account interactions are handled through logs as opposed state variables in an effort to keep gas costs low.

#### [WNS](https://github.com/DaleMittleman/Wavey/blob/master/contracts/WNS.sol)
The WNS, or 'Wavey Name Service', handles the tracking of relations between user handles and user addresses.  It provides infrastructure for CRUD operations on the set of network users.

#### [Service](https://github.com/DaleMittleman/Wavey/blob/master/contracts/Service.sol)
Services can be added to the network that leverage the user network that Wavey provides.  Services can only add users to the network if they are the gateway through which a user registers with Wavey.

Services are incentivized to add users to Wavey through the existence of a reputation statistic.

#### [ServiceManager](https://github.com/DaleMittleman/Wavey/blob/master/contracts/ServiceManager.sol)
The service manager is for Services what the WNS is for Users.  The contract keeps track of service names and their corresponding addresses.
