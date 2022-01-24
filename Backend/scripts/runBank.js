const main = async() =>{
    const  waveContractFactory = await hre.ethers.getContractFactory("SolBank");
    console.log(waveContractFactory);
    const  waveContract = await waveContractFactory.deploy();
    // console.log(waveContract);
    await waveContract.deployed();
};

const runMain = async() => {
    try{
        await main();
        process.exit(0);
    }
    catch(error){
        console.error(error);
        process.exit(1);
    }

};

runMain();