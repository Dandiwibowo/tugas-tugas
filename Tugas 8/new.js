let tryFnc = ()=>{
    (function thisFnc(x=5){

        console.log(x);
        x>0 ? thisFnc(x-1):false;

    })(5);
}
tryFnc();
