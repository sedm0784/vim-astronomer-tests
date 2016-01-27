# Test Cases for the Astronomer Vim Plugin

These are the test cases for the Astronomer plugin. They require the test
framework, [Vader](https://github.com/junegunn/vader.vim).

## Failing Test Case

Currently, test case #22 in `star_gaze.vader` fails (The |'expandtab'| option
is set for a file where it shouldn't be touched.) However I'm fairly certain
that it's not Astronomer that is causing the problem:

1. If you open the file in an interactive Vim session, the behaviour is
   correct: |'expandtab'| isn't changed from the global setting.
2. If you debug the test case, |'expandtab'| can be seen to be set
   before any code in Astronomer is run.

### Further Details

I initiate the debug run with `./run_tests.sh`

    "[Vader-workbench]" [New File]
    Entering Debug mode.  Type "cont" to continue.
    /private/var/folders/t5/prkr25g14cbbphrg2xy65w000000gn/T/vxdFFzt/64
    line 2: edit tests/mixed/mixed3.txt

Vim enters debug mode before running the `edit` command in the `debug` line.

I set a breakpoint:

    >breakadd func *star_gaze

And check the current setting of `expandtab`

    >verbose set expandtab?
    noexpandtab
            Last set from /private/var/folders/t5/prkr25g14cbbphrg2xy65w000000gn/T/vxdFFzt/64

Next I type "step". (For some reason this line of input is removed from the
screen.) Vim outputs:

    "tests/mixed/mixed3.txt" 5L, 57C
    BufRead Auto commands for "*"
    cmd: if !did_filetype() && expand("<amatch>") !~ g:ft_ignore_pat | runtime! scripts.vim | endif

Now I check the `expandtab` setting again:

    >verbose set expandtab?
      expandtab

It's already been set! I continue debugging, to check that my breakpoint was
set correctly.

    >cont
    Breakpoint in "<SNR>28_star_gaze" line 1
    function <SNR>28_star_gaze
    line 1: if &buftype ==# 'help'
    >

It was.
