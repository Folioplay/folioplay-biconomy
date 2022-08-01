//SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

import "./EIP712MetaTransaction.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";


contract TestContract is EIP712MetaTransaction("TestContract","1") {

    string public quote;
    address public owner;

    struct order {
        string[] crypto;
    }

    uint totalNumOfOrders;
    mapping(uint => order) orders;

    function setQuote(string memory newQuote) public {
        quote = newQuote;
        owner = msgSender(); 
    }
    
    function transfer(address _tokenAddr, address payable _receiver, uint _amt) public {
        IERC20(_tokenAddr).transfer(_receiver, _amt);
    }

    function getQuote() view public returns(string memory currentQuote, address currentOwner) {
        currentQuote = quote;
        currentOwner = owner;
    }

    function createOrder(string[] memory _crypto) public {
        totalNumOfOrders++;
        orders[totalNumOfOrders].crypto = _crypto;
    }

    function getcrypto(uint orderID) public view returns(string[] memory){
        return orders[orderID].crypto;
    }
}