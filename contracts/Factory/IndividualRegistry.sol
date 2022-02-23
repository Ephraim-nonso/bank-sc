//SPDX-License-Identifier: MIT

pragma solidity 0.8.5;

contract IndividualRegistry {
    uint index;
    struct Person {
        string name;
        address personAddr;
        bool registered;
    }

    mapping(uint => Person) persons;

    function addPerson(string memory _name, address _personAddr) external returns(bool success) {
        Person storage person = persons[index];
        person.name = _name;
        person.personAddr = _personAddr;
        person.registered = true;
        success = true;
    }

    function registeredPerson(uint index) external view returns(Person memory detail) {
        
    }
}