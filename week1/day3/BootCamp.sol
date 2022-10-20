// SPDX-License-Identifier: None

pragma solidity 0.8.17;


contract BootcampContract {

    uint256 number;
    address deployer;
    address deadAddress;

    constructor() {
        deployer = msg.sender;
        deadAddress = 0x000000000000000000000000000000000000dEaD;
    }

    function whoCalledMe() external view returns (address) {
        if (deployer == msg.sender) {
            return deadAddress;
        } else {
            return deployer;
        }
    }


    function store(uint256 num) public {
        number = num;
    }


    function retrieve() public view returns (uint256){
        return number;
    }
}