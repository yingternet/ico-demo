# ico-demo

This ico-demo is based on excellent code from Gregory at 
https://github.com/dappuniversity/token_sale

I just modified few places:

1. make the token 18 digits (just like ether) explicitly so it can recognized by metamask correctly 
2. Hack around the number so 1 YTT Token = 0.001 Ether and number look correctly from website and metamask
3. Add default payable function so user can also just send the ether to token sale address to purchase directly
4. Put both Token and address on the website just for show
5. I use kovan testnetwork =) since geth can never sync up with rinkeby testnet.........
