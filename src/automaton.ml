open Pi;;
open Util;;

let controlStack =  new pi stack;;
let valueStack =  new pi stack;;

let rec evaluateStatement statement = 
  controlStack#push statement

  while controlStack != [] do
    let value = controlStack#pop in 
      if value == Sum(x, y) begin
       controlStack#push ExpOc(OPSUM)
       controlStack#push ExpOc(OPSUM)
       controlStack#push ExpOc(OPSUM)
      end
      else begin
        controlStack#push ExpOc(OPMUL)
      end


  end
  print_endline "terminou";;
  