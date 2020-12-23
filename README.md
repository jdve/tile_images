# Tile Images
When using a set of images for language learning, it is often helpful to
combine them into a single tiled image.  For example, this image can be
printed to use during language sessions.  Or it can be attached as "cover
art" to a recorded MP3 for listening drills.  This tool combines a given
set of images into a single tiled image.  In addition, it creates a PDF
containing both the single tiled image as well as the tiled images spread
across multiple pages to faciliate better printing quality and a page
containing the list of files included in the PDF for reference purposes.

## Usage

### MacOS Finder
1. Install [XQuartz](https://www.xquartz.org/).
2. Download the [latest release](https://github.com/jdve/tile_images/releases).
3. Unzip the release.
4. Double-click `Tile Images.workflow` to install.
5. Right-click on any number of image files in Finder.
6. Choose the "Tile Images" option from the "Quick Actions" menu.

![Using MacOS Finder](doc/finder.gif)

### Terminal
Alternatively, you can run the command line tool from the terminal.  This is
useful if you want to do more advanced scripting.

![Using Terminal](doc/terminal.gif)

## Development
While this tool is packaged for MacOS as a convenient Finder Quick Action, the
core is written using [nim](https://nim-lang.org), a cross-platform programming
language.  Under the hood, it uses [ImageMagick](https://imagemagick.org/) to
create the tiled images.  This means that it's quite possible to use it on other
platforms as well.  If you're interested in contributing, please feel free to
submit a pull request.

To build it, first install nim using `brew install nim`.  Then run
`./build.sh`.  This will compile the tool as well as repackage the Finder Quick
Action with the new version.  To see more details about command line options,
run `./bin/tile_images --help`.

