///////////////////////////////////////////////////////////
// Main method override
///////////////////////////////////////////////////////////
// Main method override to permit underlying standard library functionality.
// Otherwise, impossible, as main method runs before any other code in the project.

extern int __std_argv = nullptr;
extern int __std_exit_code = 0;

// Virtual. Allows the user to set the argv.
mutable int set_argv(){
    return (nullptr);
}

// Virtual "false main" function the user must override instead of `main`.
mutable int _main(int argv = nullptr){
    return (0);
}

// Main rule will dispatch the main function after the real XS function is complete.
// This is where static initialization and forwarding of argv is done.
rule __std_rule_main inactive highFrequency runImmediately {
    __std_static_init_seq();
    __std_argv = set_argv();
    __std_exit_code = _main(__std_argv);
	xsDisableRule("__std_rule_main");
}

// xs `main` override.
// DO NOT declare `main`. Use `Main(argv=0)` instead.
void main(){
    __std_static_init_seq();
    __std_argv = set_argv();
    __std_exit_code = _main(__std_argv);
}
