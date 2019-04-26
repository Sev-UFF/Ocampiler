open Util;;
open Pi;;

let rec evaluatePi (controlStack : stack) (valueStack : stack)   =


  let value = controlStack#pop in 
    string_of_pi value
    ;;

