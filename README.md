# Hi. This is a script to simplify working with ffmpeg
# It can :

- Reduce size of video
- Convert format of video
- Join multiple videos together
- Remove the audio of a video
- Extract the audio from video
- Cut a video into a smaller clip
- and more in development

## Installation

### Automatically

```sh
$ git clone https://github.com/hessamashari/video-tool.git
$ cd video-tool
$ chmod +x install.sh
$ ./install.sh
```

### Manually

#### Install dependencies

*In __Debian__ base distributions (like Ubuntu) try :*

```sh
$ sudo apt install ffmpeg
```

*In __RedHat__ base distributions (like Fedora) try :*

```sh
$ sudo dnf install ffmpeg
```

*In __Arch__ base distributions (like Manjaro) try :*

```sh
$ sudo pacman -S ffmpeg
```

#### Install script

```sh
$ git clone https://github.com/hessamashari/video-tool.git
$ cd video-tool
$ chmod +x video-tool
$ sudo cp video-tool /usr/bin/video-tool
```

## Usage

```sh
$ video-tool
```

## Update

```sh
$ video-tool --update
```

## Uninstall

```sh
$ video-tool --uninstall
```

## Help

```sh
$ video-tool --help
```

Exit the program with Ctrl+C :)


Please dont forget star  
Thanks!
