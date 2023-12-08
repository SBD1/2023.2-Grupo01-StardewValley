import Math from "Math"

function getRandomFloat(min, max) {
    return Math.random() * (max - min) + min;
}

function waitForEnter(callback) {
    const rl = readline.createInterface({
        input: process.stdin,
        output: process.stdout
    });

    const timer = setTimeout(() => {
        rl.close();
        callback(false);
    }, 2000);

    rl.question('Você sente uma mordida! Rápido, pressione [ENTER] para fisgar o peixe!', () => {
        clearTimeout(timer);
        rl.close();
        callback(true);
    });
}

export default Pesquisa = () => {
    let caught = false;
    console.log("Você puxa sua vara de pesca e lança a isca na água. Agora, aguarde pacientemente...\n\n");

    while (1) {
        for (let i = 0; i < 3; i++) {
            setTimeout(function () {
                console.log(".");
            }, 1000);
        }
        console.log("\n");

        let seg = getRandomFloat(0, 1);
        seg *= 10000;

        setTimeout(seg);

        waitForEnter();
    }

    console.log(`Parabéns! Você pescou um ${PeixePescado}!\n`)
}
