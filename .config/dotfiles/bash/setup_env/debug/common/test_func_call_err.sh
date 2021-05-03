#!/usr/bin/env bash

should_pass() {
    fn_err_msg --err='big error' --expected='123' --received='1' 'test_func' "$(basename $0)"
    # echo "call made:  fn_err_msg --err='big error' 'test_script' '$(basename $0)'"
}


should_fail() {
    fn_err_msg --msg='this is why the error happened' --err='big error' --expected='123' --recieved='1' 'test_func' "$(basename $0)"
    fn_err_msg 
    # mispelling of recieved
}



perform_tests(){
    source ../colors/minimal/8-16_compat.sh > /dev/null
    source ./func_call_err.sh

    echo -e "$(with_color 'RED_B' "---------- FAIL tests ---------------")"
    should_fail
    echo -e "$(with_color 'GREEN_B' "---------- PASS tests -----------------------")"
    should_pass
}

# __cleanup_env_of_COLORs
