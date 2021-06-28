// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/Address.sol";

contract Wet is ERC20 {
    using Address for address payable;
    uint256 private _balance;
    
    constructor(address owner_) ERC20("Wrapped Ether", "WET") {
    }

    function deposit() public payable {
        require(msg.value > 0 ,"Wet contract : 1 wei min for a transaction");
         _balance += msg.value;
         _mint(msg.sender, msg.value);
    }
    
    function withdraw(uint256 amount) external payable {
        require(amount > 0 ,"Wet contract : 1 wei min for a transaction");
        transfer(address(this),amount);
        _balance -= amount;
        _burn(address(this), amount) ;
        payable(msg.sender).sendValue(amount);
    }
    
    function getBalance() public view returns(uint256){
        return _balance;
    }
}
