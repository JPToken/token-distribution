// ---------------------------------------------
//  JPToken Project
//  www    : https://www.jptoken.org/
//  e-mail : support@jptoken.org
// ---------------------------------------------

pragma solidity ^0.4.16;


// ---------------------------------------------
// The specification of the token
// ---------------------------------------------
// Name   : JPToken
// Symbol : JPT
// 18 digits of decimal point
// The issue upper limit: 1,000,000,000
// ---------------------------------------------

contract JPToken {

    string public constant name = "JPToken";

    string public constant symbol = "JPT";

    uint8  public constant decimals = 18;

    uint256 private _totalSupply = 1000000000 * (10 ** uint256(decimals));

    address public owner;

    mapping (address => uint256) balances;

    // ---------------------------------------------
    // Modification : Only an owner can carry out.
    // ---------------------------------------------
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    // ---------------------------------------------
    // Constructor
    // ---------------------------------------------
    function JPToken() public {
        // The owner address is maintained.
        owner = msg.sender;

        // All tokens are allocated to an owner.
        balances[owner] = _totalSupply;
    }

    // ---------------------------------------------
    // The total amount
    // ---------------------------------------------
    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    // ---------------------------------------------
    // The balance of the token
    // ---------------------------------------------
    function balanceOf(address _owner) public view returns (uint256) {
        return balances[_owner];
    }

    // ---------------------------------------------
    // The transfer of the token
    // ---------------------------------------------
    function transfer(address _to, uint256 _amount) public returns (bool success) {

        // Have that within the balance.
        require(balances[msg.sender] >= _amount);

        // Be more than 1
        require(_amount > 0);

        // If I send money, increase it.
        require(balances[_to] + _amount > balances[_to]);

        // A token is remitted
        balances[msg.sender] -= _amount;
        balances[_to] += _amount;

        // Event transmission
        Transfer(msg.sender, _to, _amount);

        return true;
    }

    // ---------------------------------------------
    // token transfer result
    // ---------------------------------------------
    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    // ---------------------------------------------
    // Destruction of a contract (only owner)
    // ---------------------------------------------
    function destory() public onlyOwner {
        selfdestruct(owner);
    }
}
