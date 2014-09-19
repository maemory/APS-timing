#APS Timing Program

This is the README file for the modified version of the APS timing program
originally developed by Thomas Bewley (http://turbulence.ucsd.edu/talktimer).

Written by:
  Jason Graham <jgraha8@gmail.com>
  Johns Hopkins University

Last modified: 2014-09-18 by Michael Emory

## Directory Organization

The main program is located in the file `APS_DFD.m` which contains several
settings near the top of the file for configuring the window font, sounds, setup
file, etc. The most critical component is configuring the setup file located in
the directory `setup/`. The configuration used for the APS-DFD 2011 meeting is
located in `APS_DFD2011_setup.dat`.

Please see `description/APS_DFD_description.pdf` for additional
information. The notes from the timer usage at APS-DFD 2009 and 2010
are located in `description/APSTimingNotes.pdf`.

## Important Information

There is a known memory leak with this program in `Matlab` that will cause the
program to freeze when running for extended periods of time. For some systems
this will usually only cause a problem if the program is allowed to run
overnight. So it is usually best to restart the program at the beginning of each
day. However, we did encounter the issue during the 2011 meeting. To overcome
this we used two synchronized systems with which we were able to switch to a
fresh Matlab session during the lunch break without impacting the meeting talks.
