/* const LocalFechado = () => {
    console.log(" __________________________________________\n")
    console.log("|                                          |\n")
    console.log("|           Stardew Valley - MUD           |\n")
    console.log("|__________________________________________|\n")
    console.log("\n")
    console.log("Local: XXXXXXXXX")
    console.log("\n")
    console.log("1. Ação 1")
    console.log("2. Ação 2")
    console.log("3. Status do jogador")
    console.log("4. Status do jogo")
} */

/* const LocalFechado = () => {
    console.log(" __________________________________________\n")
    console.log("|           Stardew Valley - MUD           |\n")
    console.log("| Estação: XXXXXXX                 Dia: XX |\n")
    console.log("| Região: XXXXX                Hora: XX:XX |\n")
    console.log("|------------------------------------------|\n")
    console.log("| Nome: XXXXXXXXXXX                        |\n")
    console.log("| Energia: XXX/XXX                         |\n")
    console.log("|                                          |\n")
    console.log("|                                          |\n")
    console.log("|                                          |\n")
    console.log("|__________________________________________|\n")
    console.log("\n")
    console.log("1. Opção 1\n")
    console.log("2. Opção 2\n")
} */

export default LocalFechado = () => {
    let numAcao = 2;

    console.log(
        `1. Sair do local
        ${acoes.forEach(element => {
            console.log(`${numAcao}. ${element}`)
            numAcao++
        })}
`)
}