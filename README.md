# bash-scripting

Bash Scripting Agenda

Following are the shell scripting topics which we discuss as a part of our project

1. SheBang and Comments
2. Printing
3. Variables
    - Local Variables.
    - Environment Variables.
    - Command Substitution.
4. Inputs
    - Special Variables
    - Prompts
5. Functions
6. Redirectors & Quotes & Exit status 
7. Conditions
8. Loops
9. Basis of SED Command
10. Commands
Four types of commands in total :

1. Binary ( /bin, /sbin )
2. Alias 
3. Shell Builtin Commands
4. Functions
Colors are of 2 types FOREGROUND & BACKGROUND Color.

Colors       Foreground          Background

Red               31                  41

Green             32                  42

Yellow            33                  43

Blue              34                  44

Magenta           35                  45

Cyan              36                  46
Redirectors :
>   : Standard Output to a file : ( This will override the existing content on the file : > = 1> )
>>  : Standard Output to a file : ( But, this will not override, just appends on the top of the file )

2>  : Standard Error to a file  

&>  : Redirects both standard output and standard error
&>> : Redirects both standard output and standard error, but appends on the top of the exiting content.
Exit Status : Every command that you execute will return some status code and based on that code we can decide whether the command is success / failure /partially completed and the command to see the exit code of the previous command is $?

In Linux, exit codes range from 0 to 255.

0      : Exit Code means, command completed successfully
1-255  : Either partially completed or failed 

There are 2 types of CONDITIONS in SHELL :
IF
CASE
In IF we have 2 types:

1) Simple If
2) If Else 
3) Else IF
Simple If
Syntax:

if [ expression ]; then
    command will be executed
fi 
If Else
Syntax:

if [ expression ]; then
    command will be executed
else
    these commands will be executed
fi 
Else If
Syntax:

if [ expression1 ]; then
    command will be executed

elif [ expression2 ]; then 
    command-x will be executed

elif [ expression3 ]; then 
    command-y will be executed

else
    these commands will be executed
fi 
Expressions are categorized in to three
    1. Numbers
    2. Strings
    3. Files
Operators on numbers:
    -eq , -ne , -gt, -ge, -lt, -le

    [ 1 -eq 1 ] 
    [ 1 -ne 1 ]
Operators on Strings:
= , == , !=

[ abc = abc ]

-z , -n 

[ -z "$var" ] -> This is true if var is not having any data
[ -n "$var" ] _> This is true if var is having any data

-z and -n are inverse proportional options
Operators on files:
Lot of operators are available and you can check them using man pages of bash 

[ -f file ] -> True of file exists and file is a regular file 

[ -d xyz ]  -> True if file exists and it is a directory

### Explore the file types, There are 7 types on files in Linux.
COMMENT

ACTION=$1

if [ -z "$ACTION" ]; then echo Argument is needed, Either start/stop

else echo Thanks

fi -->

Makefile is a industry standard wrapper for calling scripts, warns us in case of no changes and some meaningful errors
What standards do we follow while developing the code?

1) I want tht script to be run as a ROOT user, without which I want to give user a ERROR Message stating Run it as root or sudo user. 
2) I also need success or failure messages for all the steps.
3) If any of the steps fails, I want my script to exit completely and don't want to proceed.
4) We also need to ensure, that re-run of the script should work.
5) Code should be absolutely DRY, avoid repetitive blocks of code.
**** V.IMP ****
When dealing with internal DNS Records, if you delete XYZ Record and recreate it, sometimes they won't work.
Always prefer not to delete, instead just update.

In Linux, there is a concept called as strict host key checking. This festure will prompt you when you SSH to any of the machine for the very first time, do you want to proceed ? Yes or No