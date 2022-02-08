// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Safe {
    mapping(address => uint) public balances;
    uint public totalContribution;
    
    function save() public payable returns(bool) {
        require(msg.value != 0, "0 is not a value");
        balances[msg.sender] += msg.value;
        totalContribution += msg.value;
        return true;
    }

    function withdraw(uint amount) public payable returns(bool) {
        require(balances[msg.sender] >= 10 ether, "Contribute up to 10 ethers.");
        require(msg.value != 0, "0 is not a value");
        uint funds = amount * 10 **18;
        payable(msg.sender).transfer(funds);
        balances[msg.sender] -= funds;
        totalContribution -= funds;
        return true;
    }

    function Forcewithdrawal(uint _amount) public{
        _amount = _amount * (10 ** 18);
        require(_amount < 10 ether, "make your withdrwal from the funcion");
       uint penalty = _amount * (0.05*1000)/1000;
       uint deduction = _amount - penalty;
        balances[msg.sender]-= (_amount);
        totalContribution -= deduction;
        (bool sent, ) = msg.sender.call{value: deduction}("");
        require(sent, "Failed to transfer");
      
    }
}