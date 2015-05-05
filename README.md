# Scheduler

A simple scheduler written in Prolog using CLP (Constraint logic programming) in *SWI-Prolog*.
**Currently it only works on a single day, but the extension should not be difficult.**

## Intro

This is a project assignment from OET university in Pula.

There are a lot of problems with the organization of time. There are "races" for the resources (rooms). When professors relocate their time, they leave time and space (room) that could be used by other professors that know about it.

## Used libraries

The idea was to use **PIO**, but that is left for the reader to implement.
We use a **CSV** parser and **CLPFD** (constrained programming).

    +---------+-------+    +-------------+  +-------+   +-------+---------+
    |         |       |    |             |  |       |   |       |         |
    |   PIO   |  CSV  +----> Prolog data +--> clpfd +--->  CSV  |   PIO   |
    |         |       |    |             |  |       |   |       |         |
    +---------+-------+    +-------------+  +-------+   +-------+---------+

## How does it work?

We draw a list of professors with their desired working hours (in Excel?) using CSV format. This format must contain all the data for a single resource. When you collect all the data, save excel file in *** CSV (Comma Separated Values) *** format and load it into the program. The program outputs the possibile time arrangements.

## Data example

    NAME_SURNAME;FROM;TO;LENGTH;RESOURCES
    Vanja Bevanda;13;15;1;1
    Vanja Bevanda;16;18;1;1
    Ivica Petrinic;14;16;1;1
    Ivica Petrinic;16;17;1;1

## Rules

-	There can be no time overlap

## Improvements

-	Satisfy the weekly, monthly required time

## Check it out

- http://asciiflow.com/

- http://www.swi-prolog.org/
- http://www.swi-prolog.org/pldoc/man?section=clpfd
- http://www.swi-prolog.org/pldoc/man?section=csv
- http://www.swi-prolog.org/pldoc/man?section=apply





