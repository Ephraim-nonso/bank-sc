//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.6;

contract PartnerShip {

    /*
     * @Audience.
     * This is a partnership contract that restricts double registration of partners and CEOS.
     * The CEO and partners cannot be a worker.
     * The employment of a worker is carried out by the CEO and must require 
     an address of one of the partners.The same logic applies for the removal of a worker.
     * The owner and shareholders can always check existing workers' profile through their 
     unique worker id.
     * The worker can retrieve their profile through their worker id.
     */

     // Collection of state variables 
    uint8 index;
    enum Department {Technology, Marketing, Finance}
   
    struct Worker {
        uint8 Id;
        Department departments;
        address workerAddress;
    }

    mapping(address => bool) public partners;
    mapping(uint8 => Worker) private workers;

    constructor(address[] memory _partners) {
        for(uint8 i; i < _partners.length; i++) {
            assert(partners[_partners[i]] == false);
            partners[_partners[i]] = true;
        }
    }

    // function to add new worker, to be called by any worker.
    function employWorker
    (uint8 _index, 
    Department _departments, 
    address _workerAddress, address _testifierAddr) 
    public onlyPartner(_testifierAddr) returns(Worker memory) {
        require(_index != index, "There is already a worker with that id.");
        require(_departments <= Department.Finance, "There are only 3 departments.");
        require(_workerAddress != workers[index].workerAddress, "You cannot employ a worker with same address");
        Worker storage worker = workers[_index];
        worker.Id = _index;
        worker.departments = _departments;
        worker.workerAddress = _workerAddress;
        index++;
        return workers[_index];
    }

    /*Throws an error when it is not called by any of the partner */
    modifier onlyPartner(address _testifierAddr) {
        require(partners[msg.sender] == true, "You're not a partner");
        require(partners[_testifierAddr] == true, "You're not a partner");
        _;
    }

    /* The partners can remove workers using their index*/
    function retrenchWorker(uint8 _workerIndex)  public {
        require(_workerIndex == workers[_workerIndex].Id, "No such worker exist");
        delete(workers[_workerIndex]);
    }

    function showAllWorkers(uint8 _index) public view returns(Worker[] memory activeWorkers) {
        require(_index <= index);
        activeWorkers = new Worker[](_index);
        for(uint8 i = 1; i < index; i++) {
            activeWorkers[i] = workers[i];
        }
    }

    function retrieveData(uint8 _index) external view returns(Worker memory) {
        require(_index != 0, "There is no worker with 0 id.");
        require(_index == workers[_index].Id, "There is no worker with such id.");
        return workers[_index];
    }
}

