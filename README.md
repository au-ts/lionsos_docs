# LionsOS documentation

This repository holds the source for the documentation website for LionsOS.

If you find any issues with the documentation please file an issue or create
a pull request.

## Dependencies

The website is built using the [Hugo static site generator](https://gohugo.io/). To install
Hugo follow the instructions below for your environment.

On Ubuntu/Debian:
```sh
sudo apt install hugo
```

On macOS with [Homebrew](https://brew.sh/):
```sh
brew install hugo
```

## Developing

Each page is written using Markdown and can be found in `content/docs/`.

If you are developing the documentation and want to preview your changes, run:
```sh
./server.sh
```

You should see a message such as `Web Server is available at http://localhost:1313/`.
Open the link in your browser to view the documentation, the page will automatically
reload on any changes.

## Design files 

All diagrams are in SVG format and made in a tool called [Figma](https://figma.com).

The link to the design file is [here](https://www.figma.com/file/cUe98sFv4JyY7VWz374RNv/LionsOS-docs?type=design&node-id=0%3A1&mode=design&t=M6pKokl1dW035I91-1).

