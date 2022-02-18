//SPDX-License-Identifier: UNLINCENSED

pragma solidity 0.8.6;

contract Cooperative {
    //State variables
    uint8 numOfApprovals;
    uint8 id;
    address CEO;
    mapping(address => bool) public owners;
    struct HOD {
        uint id;
        string department;
    }
    HOD[] hods;
    // 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4

    constructor(address[] memory _shareholders) {
        // address owner;
        CEO = msg.sender;
        owners[msg.sender] = true;
        for(uint8 i; i < _shareholders.length; i++) {
        assert((owners[_shareholders[i]] == false));
            owners[_shareholders[i]] = true;
        }
    }

    modifier onlyCEO(address _oneShareHolder) {
        require(owners[CEO] == false, "You're not the CEO");
        require(owners[_oneShareHolder] == false, "Provide a true shareholder.");
        require(CEO != _oneShareHolder, "Provide another shareholder");
        _;
    }

    function addHOD(string memory _dept, address _oneShareHolder) external onlyCEO(_oneShareHolder) returns(bool) {
        id += 1;
        HOD memory hod = HOD(id, _dept);
        hods.push(hod);
        return true; 
    }
}
