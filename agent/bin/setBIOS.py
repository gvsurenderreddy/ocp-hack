#!/usr/bin/python
import commands
bios = commands.getoutput("cat /tmp/BIOS.np > /dev/nvram")