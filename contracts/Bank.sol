// SPDX-License-Identifier: MIT

pragma solidity >= 0.7.0 <= 0.9.0;

contract Bank {
    /* Features of the bank contract
    - Users have the ability to deposit into their account.
    - Users ae able to view their account balance.
    - Users can withdraw from their account.
    - Users have the ability to transfer to other users' addresses.
    */

    mapping(address => uint) public balances;
    address immutable owner;
    event getTransfersDetails(address userAddress, uint amount,bytes data);

    constructor() {
        owner = msg.sender;
    }
    function deposit() payable external {
        require(msg.value != 0, "You haven't passed in a value");
        balances[msg.sender] += msg.value;
    }

    // function transferFunds(address to) {

    // }

    function withdrawFunds(uint amount) public {
        require(amount > 0, "Transfer fnot possible for less than 1");
        address userAddress = msg.sender;
        (bool sent, bytes memory data) = msg.sender.call{value: amount}('');
        sent = true;
        emit getTransfersDetails(userAddress, amount, data);
    }


    function getUserBalance() public view returns(uint) {
        return balances[msg.sender];
    }
}