//SPDX-License-Identifier: Unlicensed

pragma solidity 0.8.5;

contract Escrow {
    
    mapping(address => bool) addrSaved;
    mapping(address => uint) balances;

    function deposit(uint256 amt) external payable returns(bool success) {
        require(amt == msg.value, "Value not valid");
        balances[msg.sender] += amt;
        addrSaved[msg.sender] = true;
        (success, ) = address(this).call{value: amt}('');
    }

    function balancOf(address _addr) external view returns(uint bal) {
        bal = balances[_addr];
    }

    function withdraw(uint amt) external payable returns(bool success) {
        require(amt <= balances[msg.sender], "Insufficient funds");
        balances[msg.sender] -= amt;
        (success, ) = address(msg.sender).call{value: amt}('');
        if(balances[msg.sender] == 0) return addrSaved[msg.sender] = false;
    }

    function transfer(address _to, uint amt) external returns(bool success) {
        require(amt <= balances[msg.sender], "Insufficient funds");
        balances[msg.sender] -= amt;
        balances[_to] += amt;
        (success, ) = address(_to).call{value: amt}('');
        if(balances[msg.sender] == 0) return addrSaved[msg.sender] = false;
    }

    receive() external payable {}
}