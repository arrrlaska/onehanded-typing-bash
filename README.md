# onehanded-typing-bash

### Description

This script is intended to facilitate single-handed typing for those with disabilities. The idea was concieved when I dislocated my shoulder in 2005, and wanted my employer to buy ones of those expensive one-handed keyboards so I could type at a decent speed, instead of hunting and pecking. They didn't buy it, but I've been wanting to write this script ever since.

It lets you use shift to flip the keyboard, as if viewed by a mirror.  It also means that everything you type has to be lower-case, and the shift key only works as a mirroring indicator, but hey, this is free, and those one-handed keyboards cost hundreds `^__^`

### Example
If you want to write "hello world" using only the left hand, you would write GeSSW wWrSd

The script doesn't allow for any editing or even backspace, but the good news is that the backspace character gets written out to the file. So what you can do is run:
```bash
sed 's/.^?//g' filename > newfile
```
to process the backspace characters for you

**NOTE** that the ^? characters above are not the caret and question mark, but a visual indicator of the delete symbol. You get this on the command line by pressing CTRL-v, then the delete key (without control)

## Potential issues
**Issue**: the read -N option requires a recent version of bash. It work under bash 5.0.0, but not under bash 3.x.x. YMMV
