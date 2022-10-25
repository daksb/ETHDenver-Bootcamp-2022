// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract VolcanoCoin is Ownable{

uint256 totalSupply = 10000;
mapping(address => uint) public balances;
mapping(address => Payment[]) public userTransfer;

struct Payment{
    address Recipient;
    uint256 ReceivedAmount;
}

event totalSupplySet(uint256);
event transferedAmount(address to, uint256 value);

constructor() {
    balances[msg.sender] = totalSupply;
}

function getTotalSupply() public view returns(uint256){    
    return totalSupply;
}

function increaseTotalSupply() public onlyOwner{
    totalSupply = totalSupply + 1000;
    emit totalSupplySet(totalSupply);
}

function getUserBalance(address user) public view returns(uint256){
    return balances[user];
}

function getOwnerBalance() public view returns(uint256){
    return balances[msg.sender];
}

function transfer(uint256 amounttotransfer, address recipient) public{
    require(balances[msg.sender] >= amounttotransfer);
    balances[msg.sender] = balances[msg.sender] - amounttotransfer;
    balances[recipient] = balances[recipient] + amounttotransfer;
    userTransfer[msg.sender].push(Payment({Recipient:recipient, ReceivedAmount:amounttotransfer})); 
    emit transferedAmount(recipient, amounttotransfer);
}

function getPayments(address user) public view returns(Payment[] memory){
    Payment[] memory userPayments = userTransfer[user];
    return userPayments;
}

}