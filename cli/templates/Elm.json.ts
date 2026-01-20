export default () => `
{
    "type": "application",
    "source-directories": [
        "src"
    ],
    "elm-version": "0.19.1",
    "dependencies": {
        "direct": {
            "elm/core": "1.0.3",
            "elm/json": "1.1.3",
            "mdgriffith/elm-codegen": "6.0.1"
        },
        "indirect": {
            "elm/parser": "1.1.0",
            "elm-community/basics-extra": "4.1.0",
            "rtfeldman/elm-hex": "1.0.0",
            "stil4m/elm-syntax": "7.3.8",
            "stil4m/structured-writer": "1.0.3",
            "the-sett/elm-pretty-printer": "3.1.1"
        }
    },
    "test-dependencies": {
        "direct": {},
        "indirect": {}
    }
}

`;
