export default () => `
{
    "type": "application",
    "source-directories": ["."],
    "elm-version": "0.19.1",
    "dependencies": {
      "direct": {
        "elm/browser": "1.0.2",
        "elm/core": "1.0.5",
        "elm/html": "1.0.0",
        "elm/json": "1.1.3",
        "mdgriffith/elm-codegen": "5.1.1"
      },
      "indirect": {
        "elm/parser": "1.1.0",
        "elm/time": "1.0.0",
        "elm/url": "1.0.0",
        "elm/virtual-dom": "1.0.2",
        "elm-community/basics-extra": "4.1.0",
        "elm-community/list-extra": "8.6.0",
        "miniBill/elm-unicode": "1.0.2",
        "rtfeldman/elm-hex": "1.0.0",
        "stil4m/elm-syntax": "7.2.9",
        "stil4m/structured-writer": "1.0.3",
        "the-sett/elm-pretty-printer": "3.0.0"
      }
    },
    "test-dependencies": {
      "direct": {},
      "indirect": {}
    }
  }

`;
