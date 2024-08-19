const { ethers } =  require("ethers");

async function abraham ( 
) {
   
        var abra =ethers.Wallet.createRandom(
          
    )

    return(abra);


   
}
abraham().then(xx=>{
    console.log(xx)
    console.log(xx._signingKey())
}).catch(e=>{console.log(e)});
    