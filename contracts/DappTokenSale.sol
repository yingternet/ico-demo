pragma solidity ^0.4.2;

import "./DappToken.sol";

contract DappTokenSale {
    address admin;
    DappToken public tokenContract;
    uint256 public tokenPrice;
    uint256 public tokensSold;
    uint256 public basedNumber = 1000000000000000000;
	
    event Sell(address _buyer, uint256 _amount);

    function DappTokenSale(DappToken _tokenContract, uint256 _tokenPrice) public {
        admin = msg.sender;
        tokenContract = _tokenContract;
        tokenPrice = _tokenPrice;
    }

    function multiply(uint x, uint y) internal pure returns (uint z) {
        require(y == 0 || (z = x * y) / y == x);
    }

    function buyTokens(uint256 _numberOfTokens) public payable {
        require(msg.value == multiply(_numberOfTokens, tokenPrice));
        require(tokenContract.balanceOf(this) >= _numberOfTokens * basedNumber);
        require(tokenContract.transfer(msg.sender, _numberOfTokens * basedNumber));

        tokensSold += _numberOfTokens;

        Sell(msg.sender, _numberOfTokens);
	admin.transfer(msg.value);
    }
	
    function () public payable {
        //require(now >= startDate && now <= endDate);
        /*
        uint tokens;
        if (now <= bonusEnds) {
            tokens = msg.value * 2000;
        } else {
            tokens = msg.value * 1000;
        }*/
 	uint256 _numberOfTokens = msg.value / tokenPrice;
        require(tokenContract.balanceOf(this) >= _numberOfTokens * basedNumber);
        require(tokenContract.transfer(msg.sender, _numberOfTokens * basedNumber));	
		
		tokensSold += _numberOfTokens;
        Sell(msg.sender, _numberOfTokens);
		admin.transfer(msg.value);

    }
	
    function endSale() public {
        require(msg.sender == admin);
        require(tokenContract.transfer(admin, tokenContract.balanceOf(this)));

        // UPDATE: Let's not destroy the contract here
        // Just transfer the balance to the admin
        admin.transfer(address(this).balance);
    }
}
