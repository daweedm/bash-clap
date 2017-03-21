# bash-clap
a pure bash script to detect hand claps

## Installation
##### Linux (Debian, Ubuntu, Raspbian, ...)
```bash
apt-get install sox git
```

##### macOS [(homebrew required)](https://brew.sh/)
```bash
brew install sox
```
##### Then
```bash
git clone https://github.com/daweedm/bash-clap && cd bash-clap && chmod +x bash-clap.sh
```

## Configuration
### What audio source to use ? [ref.](http://www.voxforge.org/home/docs/faq/faq/linux-how-to-determine-your-audio-cards-or-usb-mics-maximum-sampling-rate)

##### Linux (Debian, Ubuntu, Raspbian, ...)
First, install alsa-utils :
```bash
apt-get install alsa-utils
```

Then list all available devices : 
```bash
arecord --list-devices
```
You get an output similar to this

> **** List of CAPTURE Hardware Devices ****  
> **card X**: (...), **device Y**: (..)  
> Subdevices: 1/1  
> Subdevice #0: subdevice #0  
> (...)

You might have more than one audio interface (integrated audio card, USB-wired mic, ...). Once you have chosen the interface you want to use, you can guess your audio source from the numbers **X** and **Y** : `src="alsa hw:X,Y"`

Open `bash-clap.sh` and change the src variable to your audio source if it differs from the default one.

##### macOS
Nothing to do ! You can leave `src` value to `"auto"`

## Action

When a clap is detected, the `on_clap()` function is executed. You can customize its behavior in the `bash-clap.sh` file. 

### Notes

You can use the `screen` for Linux tool to keep the process listening for claps in the background
