/*
 * Configurateur de DetectionHSL
 */
const hslcfg = require(`../config.json`);
const fs = require(`fs`);
let hslmods = new Array();
fs.readdir(`../scripts`, (err, data) => {
    if(err) throw err; 
    data.forEach(f => {
        hslmods.push(f);
    });
});
const inquirer = require(`inquirer`);
inquirer.prompt([
    {
        type: `list`,
        name: `lang`,
        message: `Wich lang do you want to use ? | Quelle langue voulez vous utiliser?`,
        choices: [
            {name: `English`, value: `en`},
            {name: `Français`, value: `fr`}
        ],
        default: `fr`
    }
]).then((lang) => {
    if(lang.lang === `fr`) {
        inquirer.prompt([
            {
                type: `checkbox`,
                name: `mods`,
                message: `Quels modules voulez vous utiliser?`,
                choices: hslmods
            }
        ])
            .then((mods) => {
                const hslconf = {
                    version: `${hslcfg.version}`,
                    modules: mods,
                    lang: lang
                };
                fs.writeFile(`../hslconf.json`, JSON.stringify(hslconf), async () => {
                    console.log(`Configuration écrite`);
                });
            });
    }

}).catch(e => { console.log(e); });
