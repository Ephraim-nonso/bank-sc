// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Contract {
    address payable public owner;
    address payable public charity;

    constructor (address _charity) {
        owner = payable(msg.sender);
        charity = payable(_charity);
    }

    function tip() public payable {
        owner.transfer(msg.value);
    }

    /*
    The function below has the ability to self destruct a contract.
    This implies that the contract is destroyed; the power
    of the selfdestruct opcode.
     */
    function donate() public payable {
        // charity.transfer(address(this).balance);
        selfdestruct(charity);
    }

    receive() external payable {}
}