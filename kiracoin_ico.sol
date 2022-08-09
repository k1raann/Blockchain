pragma solidity ^0.4.11;

contract kiracoin_ico{
    uint public max_kiracoins = 1000000;
    uint public usd_to_kiracoins = 100;
    uint public total_kiracoins_bought = 0;

    mapping(address => uint) equity_kiracoins;
    mapping(address => uint) equity_usd;

    modifier can_buy_kiracoins(uint usd_invested){
        require(usd_invested*usd_to_kiracoins + total_kiracoins_bought <= max_kiracoins);
        _;
    }

    function equity_in_kiracoins(address investor) external constant returns (uint){
        return equity_kiracoins[investor];
    }

    function equity_in_usd(address investor) external constant returns (uint){
        return equity_usd[investor];
    }

    function buy_kiracoins(address investor, uint usd_invested) external can_buy_kiracoins(usd_invested){
        uint kiracoins_bought = usd_invested*usd_to_kiracoins;
        equity_kiracoins[investor] += kiracoins_bought;
        equity_usd[investor] = equity_kiracoins[investor]/100;
        total_kiracoins_bought += kiracoins_bought;
    }

    function sell_kiracoins(address investor, uint kiracoins_to_sell) external{
        equity_kiracoins[investor] -= kiracoins_to_sell;
        equity_usd[investor] = equity_kiracoins[investor]/100;
        total_kiracoins_bought -= kiracoins_to_sell;
    }
}
