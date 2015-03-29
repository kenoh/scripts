#!/bin/bash

# Map this to some keyboard shortcut and you will get a Guake-like terminal :)

TERMINAL_EXECUTABLE='xfce4-terminal'
WANTED_WM_CLASS='xfce4-terminal.Xfce4-terminal'


function wanted_terminal() {
	local CURRENT_DESKTOP=`wmctrl -d | grep -E '^\S+\s+\*' | sed 's/^\(\S\+\).*/\1/'`
	local WANTED_TERMINAL=`wmctrl -lx | grep -E "^\S+\s+$CURRENT_DESKTOP\s+$WANTED_WM_CLASS" | sort | head -n 1 | sed 's/^\(\S\+\).*/\1/'`
	echo $WANTED_TERMINAL
}

if [ -z $(wanted_terminal) ]; then
	#window not found
	exec $TERMINAL_EXECUTABLE &
	sleep 0.1
	wmctrl -r ':ACTIVE:' -b add,maximized_vert,maximized_horz
else
	#window found
	wmctrl -i -a $(wanted_terminal)
fi
